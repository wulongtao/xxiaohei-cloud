package com.xxiaohei.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/nacos/config")
@RefreshScope
@RequiredArgsConstructor
public class NacosConfigController {

    @Value("${testname:}")
    private String serverAddr;


    @RequestMapping("/getConfigTest")
    public String getConfigTest() {
        System.out.println(serverAddr);
        return serverAddr;
    }

}
