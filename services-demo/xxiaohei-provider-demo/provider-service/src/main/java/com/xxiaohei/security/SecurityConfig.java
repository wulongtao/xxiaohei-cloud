package com.xxiaohei.security;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author xxiaohei
 * @since 2023-07-30 13:54
 */
@Slf4j
@Configuration
public class SecurityConfig {

    @Bean
    public AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService());
        return new ProviderManager(provider);
    }

    @Bean
    public UserDetailsService userDetailsService() {
        InMemoryUserDetailsManager users = new InMemoryUserDetailsManager();
        users.createUser(User.withUsername("xxiaohei").password("{noop}xxiaohei").roles("").build());
        return users;
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth.anyRequest().authenticated())
                .formLogin(form -> form.loginProcessingUrl("/login").permitAll())
                .addFilterAt(verificationCodeAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
                .csrf(AbstractHttpConfigurer::disable);
        return http.build();
    }

    @Bean
    public VerificationCodeAuthenticationFilter verificationCodeAuthenticationFilter() {
        VerificationCodeAuthenticationFilter verificationCodeAuthenticationFilter = new VerificationCodeAuthenticationFilter();
        verificationCodeAuthenticationFilter.setAuthenticationManager(authenticationManager());
        verificationCodeAuthenticationFilter.setAuthenticationFailureHandler((request, response, exception) -> {
            Map<String, Object> result = new HashMap<>();
            result.put("code", -1);
            result.put("msg", "登录失败");
            result.put("data", exception.getMessage());
            writeResp(result, response);
        });
        verificationCodeAuthenticationFilter.setAuthenticationSuccessHandler((request, response, authentication) -> {
            Map<String, Object> result = new HashMap<>();
            result.put("code", -1);
            result.put("msg", "登录成功");
            result.put("data", authentication);
            writeResp(result, response);
        });
        return verificationCodeAuthenticationFilter;
    }

    @Bean
    public JsonRequestAuthenticationFilter jsonRequestAuthenticationFilter() {
        JsonRequestAuthenticationFilter jsonRequestAuthenticationFilter = new JsonRequestAuthenticationFilter();
        jsonRequestAuthenticationFilter.setAuthenticationManager(authenticationManager());
        return jsonRequestAuthenticationFilter;
    }


    public void writeResp(Object content, HttpServletResponse response) {
        response.setContentType("application/json;charset=utf-8");
        try {
            response.getWriter().println(JSON.toJSONString(content));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}