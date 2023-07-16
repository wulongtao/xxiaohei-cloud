package com.xxiaohei.api.feign;


import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author 小小黑
 */
@FeignClient(name = "provider-service")
public interface TestClient {

    @GetMapping("/test")
    String test();

}
