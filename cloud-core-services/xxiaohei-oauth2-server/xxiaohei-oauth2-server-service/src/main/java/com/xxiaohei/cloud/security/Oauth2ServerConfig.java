package com.xxiaohei.cloud.security;

import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;

/**
 * 认证服务器配置
 *
 * @author xxiaohei
 * @since 2023-08-13 14:47
 */
@AllArgsConstructor
@Configuration
@EnableAuthorizationServer
public class Oauth2ServerConfig extends AuthorizationServerConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;

    private final SysUserServiceImpl sysUserService;

    private final AuthenticationManager authenticationManager;

    private final JwtTokenEnhancer jwtTokenEnhancer;



}