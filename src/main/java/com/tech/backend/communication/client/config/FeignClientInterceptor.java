package com.tech.backend.communication.client.config;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Component;

/**
 * Author: chautn on 6/16/2018 12:39 PM
 */
public class FeignClientInterceptor implements RequestInterceptor {

  private static final Logger logger = LoggerFactory.getLogger(FeignClientInterceptor.class);

  @Autowired
  private FeignClientService feignClientService;

  @Autowired
  private FeignClientAccessToken feignOAuthAccessToken;

  @Override
  public void apply(RequestTemplate template) {
    logger.info("Process request to: " + template.url());
    if ("/uaa/login".equals(template.url())) {
      // login doesn't need bearer
      return;
    }
    SecurityContext securityContext = SecurityContextHolder.getContext();
    Authentication authentication = securityContext.getAuthentication();

    if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
      logger.info("Need to self authenticate...");
      if (StringUtils.isBlank(feignOAuthAccessToken.getAccessToken())) {
        feignClientService.selfAuthenticate();
      }
      template.header("Authorization", "Bearer " + feignOAuthAccessToken.getAccessToken());
    } else if (authentication instanceof OAuth2Authentication) {
      logger.info("Forwarding user request...");
      OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) authentication.getDetails();
      if (details != null) {
        template.header("Authorization", "Bearer " + details.getTokenValue());
      } else {
        throw new FeignClientException("Unauthorized feign client");
      }
    } else {
      logger.error("Unknown authentication: " + authentication);
    }

  }

}
