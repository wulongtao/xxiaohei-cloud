package com.xxiaohei.nacos.config;

import com.alibaba.cloud.commons.lang.StringUtils;
import com.alibaba.cloud.nacos.NacosDiscoveryProperties;
import com.alibaba.cloud.nacos.balancer.NacosBalancer;
import com.alibaba.cloud.nacos.loadbalancer.NacosLoadBalancer;
import com.alibaba.cloud.nacos.util.InetIPv6Utils;
import com.alibaba.nacos.client.naming.utils.CollectionUtils;
import com.xxiaohei.nacos.local.LocalRequestProcessor;
import com.xxiaohei.nacos.local.LocalRequestProperty;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.DefaultResponse;
import org.springframework.cloud.client.loadbalancer.EmptyResponse;
import org.springframework.cloud.client.loadbalancer.Request;
import org.springframework.cloud.client.loadbalancer.Response;
import org.springframework.cloud.loadbalancer.core.NoopServiceInstanceListSupplier;
import org.springframework.cloud.loadbalancer.core.ReactorServiceInstanceLoadBalancer;
import org.springframework.cloud.loadbalancer.core.ServiceInstanceListSupplier;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * 本地调用的负载均衡实现
 *
 * @author xxiaohei
 * @since 2023-07-26 21:37
 */
public class LocalNacosLoadBalancer extends NacosLoadBalancer implements ReactorServiceInstanceLoadBalancer {

    private static final Logger log = LoggerFactory.getLogger(LocalNacosLoadBalancer.class);

    private final String serviceId;

    private ObjectProvider<ServiceInstanceListSupplier> serviceInstanceListSupplierProvider;

    private final NacosDiscoveryProperties nacosDiscoveryProperties;

    private static final String IPV4_REGEX = "((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}";

    private static final String IPV6_KEY = "IPv6";
    /**
     * Storage local valid IPv6 address, it's a flag whether local machine support IPv6 address stack.
     */
    public static String ipv6;

    @Autowired
    private InetIPv6Utils inetIPv6Utils;


    @PostConstruct
    public void init() {
        String ip = nacosDiscoveryProperties.getIp();
        if (StringUtils.isNotEmpty(ip)) {
            ipv6 = Pattern.matches(IPV4_REGEX, ip) ? nacosDiscoveryProperties.getMetadata().get(IPV6_KEY) : ip;
        }
        else {
            ipv6 = inetIPv6Utils.findIPv6Address();
        }
    }

    private List<ServiceInstance> filterInstanceByIpType(List<ServiceInstance> instances) {
        if (StringUtils.isNotEmpty(ipv6)) {
            List<ServiceInstance> ipv6InstanceList = new ArrayList<>();
            for (ServiceInstance instance : instances) {
                if (Pattern.matches(IPV4_REGEX, instance.getHost())) {
                    if (StringUtils.isNotEmpty(instance.getMetadata().get(IPV6_KEY))) {
                        ipv6InstanceList.add(instance);
                    }
                }
                else {
                    ipv6InstanceList.add(instance);
                }
            }
            // Provider has no IPv6, should use IPv4.
            if (ipv6InstanceList.size() == 0) {
                return instances.stream()
                        .filter(instance -> Pattern.matches(IPV4_REGEX, instance.getHost()))
                        .collect(Collectors.toList());
            }
            else {
                return ipv6InstanceList;
            }
        }
        return instances.stream()
                .filter(instance -> Pattern.matches(IPV4_REGEX, instance.getHost()))
                .collect(Collectors.toList());
    }

    public LocalNacosLoadBalancer(
            ObjectProvider<ServiceInstanceListSupplier> serviceInstanceListSupplierProvider,
            String serviceId, NacosDiscoveryProperties nacosDiscoveryProperties) {
        super(serviceInstanceListSupplierProvider, serviceId, nacosDiscoveryProperties);
        this.serviceId = serviceId;
        this.serviceInstanceListSupplierProvider = serviceInstanceListSupplierProvider;
        this.nacosDiscoveryProperties = nacosDiscoveryProperties;
    }

    @Override
    public Mono<Response<ServiceInstance>> choose(Request request) {
        ServiceInstanceListSupplier supplier = serviceInstanceListSupplierProvider
                .getIfAvailable(NoopServiceInstanceListSupplier::new);
        //解析请求信息并初始化本地请求配置
        LocalRequestProperty localRequestProperty = LocalRequestProcessor.parseLocalRequestProperty(request);
        return supplier.get(request).next().mapNotNull(i -> getInstanceResponse(localRequestProperty, i));
    }

    private Response<ServiceInstance> getInstanceResponse(LocalRequestProperty localRequestProperty,
            List<ServiceInstance> serviceInstances) {
        if (serviceInstances.isEmpty()) {
            log.warn("No servers available for service: " + this.serviceId);
            return new EmptyResponse();
        }

        try {
            String clusterName = this.nacosDiscoveryProperties.getClusterName();

            List<ServiceInstance> instancesToChoose = serviceInstances;
            if (StringUtils.isNotBlank(clusterName)) {
                List<ServiceInstance> sameClusterInstances = serviceInstances.stream()
                        .filter(serviceInstance -> {
                            String cluster = serviceInstance.getMetadata()
                                    .get("nacos.cluster");
                            return StringUtils.equals(cluster, clusterName);
                        }).collect(Collectors.toList());
                if (!CollectionUtils.isEmpty(sameClusterInstances)) {
                    instancesToChoose = sameClusterInstances;
                }
            }
            else {
                log.warn(
                        "A cross-cluster call occurs，name = {}, clusterName = {}, instance = {}",
                        serviceId, clusterName, serviceInstances);
            }
            instancesToChoose = this.filterInstanceByIpType(instancesToChoose);

            //如果找到本地应用，直接返回该服务实例
            ServiceInstance localServiceInstance = LocalRequestProcessor.obtainLocalInstance(localRequestProperty, instancesToChoose);
            if (Objects.nonNull(localServiceInstance)) {
                return new DefaultResponse(localServiceInstance);
            }

            ServiceInstance instance = NacosBalancer
                    .getHostByRandomWeight3(instancesToChoose);

            return new DefaultResponse(instance);
        }
        catch (Exception e) {
            log.warn("NacosLoadBalancer error", e);
            return null;
        }
    }
}