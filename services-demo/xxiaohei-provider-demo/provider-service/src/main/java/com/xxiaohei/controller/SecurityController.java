package com.xxiaohei.controller;

import com.alibaba.fastjson.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author xxiaohei
 * @since 2023-07-30 13:52
 */
@RestController
@RequestMapping("/security")
public class SecurityController {

    @RequestMapping("/getAuthentication")
    public String getAuthentication() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return JSONObject.toJSONString(authentication);
    }

    @RequestMapping("/getAuthenticationByParam")
    public String getAuthentication(Authentication authentication) {
        return JSONObject.toJSONString(authentication);
    }

}