package com.xxiaohei.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import java.util.HashMap;
import java.util.Map;

/**
 * @author xxiaohei
 * @since 2023-07-30 13:54
 */
@Configuration
public class SecurityConfig {

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
                .formLogin(form -> form.loginProcessingUrl("/login").permitAll()/*.successHandler((request, response, authentication) -> {
                    response.setContentType("application/json;charset=utf-8");
                    Map<String, Object> map = new HashMap<>();
                    map.put("code", 0);
                    map.put("message", "success");
                    map.put("data", authentication);
                    response.getWriter().write(new ObjectMapper().writeValueAsString(map));
                })*/)
                .csrf(AbstractHttpConfigurer::disable);
        return http.build();
    }
}