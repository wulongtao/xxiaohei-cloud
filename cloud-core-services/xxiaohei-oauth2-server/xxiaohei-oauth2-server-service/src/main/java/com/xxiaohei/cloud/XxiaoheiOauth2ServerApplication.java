package com.xxiaohei.cloud;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author xxiaohei
 */
@EnableDiscoveryClient
@SpringBootApplication
@MapperScan("com.xxiaohei.cloud.database.mapper")
public class XxiaoheiOauth2ServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(XxiaoheiOauth2ServerApplication.class, args);
    }

}