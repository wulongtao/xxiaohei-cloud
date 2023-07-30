package com.xxiaohei.mybatis.config;

import com.mybatisflex.core.datasource.DataSourceDecipher;
import com.mybatisflex.core.mybatis.FlexConfiguration;
import com.mybatisflex.spring.boot.ConfigurationCustomizer;
import org.apache.ibatis.logging.stdout.StdOutImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 自定义配置
 *
 * @author xxiaohei
 * @since 2023-07-30 10:07
 */
@Configuration
public class CustomConfigurationCustomizer implements ConfigurationCustomizer {

    @Override
    public void customize(FlexConfiguration configuration) {
        System.out.println(">>>>>>> CustomConfigurationCustomizer.customize() invoked");
        configuration.setLogImpl(StdOutImpl.class);
    }

    @Bean
    public DataSourceDecipher decipher() {
        return (property, value) -> {
            System.out.println(">>>>>> decipher.decrypt");
            return value;
        };
    }

}