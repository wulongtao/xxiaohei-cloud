package com.xxiaohei.cloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author Administrator
 */
@EnableDiscoveryClient
@SpringBootApplication
public class XxiaoheiGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(XxiaoheiGatewayApplication.class, args);
    }

}