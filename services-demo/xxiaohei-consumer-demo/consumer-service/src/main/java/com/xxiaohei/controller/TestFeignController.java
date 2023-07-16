package com.xxiaohei.controller;

import com.xxiaohei.api.feign.TestClient;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class TestFeignController {

    private final TestClient testClient;

    @GetMapping("/testFeign")
    public String testFeign() {
        return testClient.test();
    }


}
