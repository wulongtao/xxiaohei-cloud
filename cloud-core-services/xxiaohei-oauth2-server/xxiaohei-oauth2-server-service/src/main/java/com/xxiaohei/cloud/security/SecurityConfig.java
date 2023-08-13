package com.xxiaohei.cloud.security;

import lombok.AllArgsConstructor;
import org.springframework.boot.actuate.autoconfigure.security.servlet.EndpointRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * spring security配置
 *
 * @author xxiaohei
 * @since 2023-08-13 14:48
 */
@AllArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final SysUserServiceImpl userDetailsService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorizeHttpRequests -> authorizeHttpRequests
                        // 允许安全检查相关地址访问
                        .requestMatchers(EndpointRequest.toAnyEndpoint()).permitAll()
                        .requestMatchers("/rsa/publicKey").permitAll()
                        // 允许任意请求被已登录用户访问，不检查Authority
                        .anyRequest().authenticated())
                .authenticationProvider(authenticationProvider());

        return http.build();
    }

    /**
     * 调用loadUserByUsername获得UserDetail信息，在AbstractUserDetailsAuthenticationProvider里执行用户状态检查
     */
    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        // DaoAuthenticationProvider 从自定义的 userDetailsService.loadUserByUsername 方法获取UserDetails
        authProvider.setUserDetailsService(userDetailsService());
        // 设置密码编辑器
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    /**
     * 登录时需要调用AuthenticationManager.authenticate执行一次校验
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return userDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}