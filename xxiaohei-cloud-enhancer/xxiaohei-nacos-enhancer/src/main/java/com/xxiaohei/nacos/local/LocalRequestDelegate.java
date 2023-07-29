package com.xxiaohei.nacos.local;

import com.xxiaohei.nacos.config.LocalNacosLoadBalancer;
import com.xxiaohei.nacos.constants.LocalNacosConfigConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.Request;
import org.springframework.cloud.client.loadbalancer.RequestData;
import org.springframework.cloud.client.loadbalancer.RequestDataContext;
import org.springframework.http.HttpHeaders;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 本地请求解析委派方法
 *
 * @author xxiaohei
 * @since 2023-07-29 12:26
 */
public class LocalRequestDelegate {
    private static final Logger log = LoggerFactory.getLogger(LocalRequestDelegate.class);

    /**
    * 封装本地请求配置信息，转发请求时用到
    * @param request 请求
    * @return com.xxiaohei.nacos.local.LocalRequestProperty
    * @author xxiaohei
    * @since 2023/7/29
    */
    public static LocalRequestProperty parseLocalRequestProperty(Request request) {
        LocalRequestProperty localRequestProperty = new LocalRequestProperty();
        if (request.getContext() instanceof RequestDataContext requestDataContext) {
            RequestData requestData = requestDataContext.getClientRequest();
            if (Objects.nonNull(requestData)) {
                HttpHeaders httpHeaders = requestData.getHeaders();
                if (Objects.nonNull(httpHeaders)) {
                    //如果找到指定header，就加到配置信息中
                    String cloudDeveloper = httpHeaders.getFirst(LocalNacosConfigConstants.NACOS_METADATA_DEVELOPER_KEY);
                    localRequestProperty.setCloudDeveloper(cloudDeveloper);
                }

            }
        }

        return localRequestProperty;
    }

    /**
    * 查找本地应用并返回调用的实例
    * @param localRequestProperty 本地请求配置
    * @param serviceInstances 实例列表
    * @return org.springframework.cloud.client.ServiceInstance
    * @author xxiaohei
    * @since 2023/7/29
    */
    public static ServiceInstance obtainLocalInstance(LocalRequestProperty localRequestProperty, List<ServiceInstance> serviceInstances) {
        String developer = localRequestProperty.getCloudDeveloper();
        if (!StringUtils.hasText(developer)) {
            return null;
        }

        for (ServiceInstance serviceInstance : serviceInstances) {
            Map<String, String> metadata = serviceInstance.getMetadata();
            //判断如果可以找到本地应用，则直接返回该实例并调用
            if (metadata.containsKey(LocalNacosConfigConstants.NACOS_METADATA_DEVELOPER_KEY)) {
                log.info("本地调用->找到本地调用服务实例，serviceId: {}, host: {}, port: {}", serviceInstance.getServiceId(), serviceInstance.getHost(), serviceInstance.getPort());
                return serviceInstance;
            }
        }

        return null;
    }


}