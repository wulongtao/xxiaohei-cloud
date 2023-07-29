package com.xxiaohei.feign;

import feign.RequestInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.DispatcherServlet;

import java.util.Enumeration;

/**
 * feign配置
 *
 * @author xxiaohei
 * @since 2023-07-16 18:57
 */
@Configuration
public class FeignConfig {

    @Value("${spring.application.name}")
    private String applicationName;

    /**
    * 让DispatcherServlet向⼦线程传递RequestContext
    * @param servlet servlet
    * @return org.springframework.boot.web.servlet.ServletRegistrationBean<org.springframework.web.servlet.DispatcherServlet>
    * @author xxiaohei
    * @since 2023/7/16
    */
    @Bean
    public ServletRegistrationBean<DispatcherServlet> dispatcherRegistration(DispatcherServlet servlet) {
        servlet.setThreadContextInheritable(true);
        return new ServletRegistrationBean<>(servlet, "/**");
    }

    /**
    * 覆写拦截器，在feign发送请求前取出原来的header并转发
    * @return feign.RequestInterceptor
    * @author xxiaohei
    * @since 2023/7/16
    */
    @Bean
    public RequestInterceptor requestInterceptor() {
        return (template) -> {
            ServletRequestAttributes attributes = (ServletRequestAttributes)
                    RequestContextHolder
                            .getRequestAttributes();

            HttpServletRequest request = attributes.getRequest();
            //获取请求头
            Enumeration<String> headerNames = request.getHeaderNames();
            if (headerNames != null) {
                while (headerNames.hasMoreElements()) {
                    String name = headerNames.nextElement();
                    String values = request.getHeader(name);
                    //将请求头保存到模板中
                    template.header(name, values);
                }
                template.header("serviceName",applicationName);
            }
        };
    }

}