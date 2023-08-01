package com.xxiaohei;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;

/**
 * 默认支持的密码加密器：org.springframework.security.crypto.factory.PasswordEncoderFactories#createDelegatingPasswordEncoder()
 * @author xxiaohei
 * @since 2023-08-01 21:01
 */
public class SecurityPasswordEncoderTest {

    @Test
    public void testPasswordEncoder() {
        System.out.println("{pbkdf2@SpringSecurity_v5_8}" + Pbkdf2PasswordEncoder.defaultsForSpringSecurity_v5_8().encode("123456"));
    }

}