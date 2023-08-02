package com.xxiaohei.security;

import com.alibaba.fastjson.JSON;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.session.FindByIndexNameSessionRepository;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisIndexedHttpSession;
import org.springframework.session.security.SpringSessionBackedSessionRegistry;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author xxiaohei
 * @since 2023-07-30 13:54
 */
@Slf4j
@Configuration
@EnableRedisIndexedHttpSession
@EnableWebSecurity
public class SecurityConfig {
    @Autowired
    private FindByIndexNameSessionRepository sessionRepository;

    @Bean
    public AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService());
        return new ProviderManager(provider);
    }

    @Bean
    public UserDetailsService userDetailsService() {
        InMemoryUserDetailsManager users = new InMemoryUserDetailsManager();
        users.createUser(User.withUsername("xxiaohei").password("{noop}xxiaohei").roles("admin").build());
        users.createUser(User.withUsername("xxiaohei1").password("{pbkdf2@SpringSecurity_v5_8}968d42577e8c71d76fd65dc7bc332d52cf4bfb2b90cfaffdc0c15bcdca085376d92e5c12d2d827fc0f36e068353f53fc").roles("").build());
        return users;
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        /*http
                .authorizeHttpRequests(authRequest -> authRequest.requestMatchers("/login").permitAll())
                .formLogin(AbstractAuthenticationFilterConfigurer::permitAll)
                .addFilterAt(jsonRequestAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
                .csrf(AbstractHttpConfigurer::disable)
                .rememberMe(Customizer.withDefaults())
                //多个会话管理控制
                .sessionManagement((sessionManagement) -> sessionManagement.sessionConcurrency(sessionConcurrency -> sessionConcurrency.maximumSessions(1).maxSessionsPreventsLogin(false)));*/

        //开启过滤器的配置
        http.authorizeHttpRequests()
                //任意请求，都要认证之后才能访问
                .anyRequest().authenticated()
                .and()
                //开启表单登录，开启之后，就会自动配置登录页面、登录接口等信息
                .formLogin()
                //和登录相关的 URL 地址都放行
                .permitAll()
                .and()
                //关闭 csrf 保护机制，本质上就是从 Spring Security 过滤器链中移除了 CsrfFilter
                .sessionManagement()
                .maximumSessions(-1)
                .sessionRegistry(sessionRegistry());;
        http.csrf().disable();
        http.addFilterBefore(jsonRequestAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

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
        jsonRequestAuthenticationFilter.setAuthenticationFailureHandler((request, response, exception) -> {
            Map<String, Object> result = new HashMap<>();
            result.put("code", -1);
            result.put("msg", "登录失败");
            result.put("data", exception.getMessage());
            writeResp(result, response);
        });
        jsonRequestAuthenticationFilter.setAuthenticationSuccessHandler((request, response, authentication) -> {
            Map<String, Object> result = new HashMap<>();
            result.put("code", -1);
            result.put("msg", "登录成功");
            result.put("data", authentication);
            writeResp(result, response);
        });
        //security6版本要加上
        jsonRequestAuthenticationFilter.setSecurityContextRepository(new HttpSessionSecurityContextRepository());
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

    @Bean
    public SpringSessionBackedSessionRegistry sessionRegistry(){
        return new SpringSessionBackedSessionRegistry(sessionRepository);
    }
}