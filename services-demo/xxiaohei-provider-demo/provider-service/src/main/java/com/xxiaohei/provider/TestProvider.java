package com.xxiaohei.provider;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestProvider {

    @GetMapping("/test")
    public String test() {
        return "test feign";
    }

}
