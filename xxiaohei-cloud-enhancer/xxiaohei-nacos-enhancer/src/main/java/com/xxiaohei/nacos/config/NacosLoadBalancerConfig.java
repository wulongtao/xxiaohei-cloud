package com.xxiaohei.nacos.config;

import com.alibaba.cloud.nacos.NacosDiscoveryProperties;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.loadbalancer.annotation.LoadBalancerClients;
import org.springframework.cloud.loadbalancer.core.ReactorLoadBalancer;
import org.springframework.cloud.loadbalancer.core.ServiceInstanceListSupplier;
import org.springframework.cloud.loadbalancer.support.LoadBalancerClientFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;

/**
 * Nacos负载均衡配置类
 *
 * @author xxiaohei
 * @since 2023-07-26 21:45
 */
@LoadBalancerClients(defaultConfiguration = NacosLoadBalancerConfig.class)
public class NacosLoadBalancerConfig {

    @Bean
    public ReactorLoadBalancer<ServiceInstance> nacosLoadBalancer(Environment environment, LoadBalancerClientFactory loadBalancerClientFactory, NacosDiscoveryProperties configProperties) {
        String name = environment.getProperty(LoadBalancerClientFactory.PROPERTY_NAME);
        return new LocalNacosLoadBalancer(loadBalancerClientFactory.getLazyProvider(name, ServiceInstanceListSupplier.class), name, configProperties);
    }

}