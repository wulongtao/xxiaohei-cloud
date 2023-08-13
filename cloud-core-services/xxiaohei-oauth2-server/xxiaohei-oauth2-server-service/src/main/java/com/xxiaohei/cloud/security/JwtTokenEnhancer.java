package com.xxiaohei.cloud.security;

import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * JWT内容增强器
 *
 * @author xxiaohei
 * @since 2023-08-13 14:44
 */
@Component
public class JwtTokenEnhancer implements TokenEnhancer {
    @Override
    public OAuth2AccessToken enhance(OAuth2AccessToken oAuth2AccessToken, OAuth2Authentication oAuth2Authentication) {
        SecurityUser securityUser = (SecurityUser) oAuth2Authentication.getPrincipal();

        Map<String, Object> additionalInformation = new HashMap<>(1);
        additionalInformation.put("userId", securityUser.getUserId());
        ((DefaultOAuth2AccessToken)oAuth2AccessToken).setAdditionalInformation(additionalInformation);

        return oAuth2AccessToken;
    }
}