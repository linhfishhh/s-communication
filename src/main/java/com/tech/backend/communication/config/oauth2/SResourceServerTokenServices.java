package com.tech.backend.communication.config.oauth2;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.security.oauth2.resource.AuthoritiesExtractor;
import org.springframework.boot.autoconfigure.security.oauth2.resource.FixedAuthoritiesExtractor;
import org.springframework.boot.autoconfigure.security.oauth2.resource.PrincipalExtractor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.client.OAuth2RestOperations;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.resource.BaseOAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.common.exceptions.InvalidTokenException;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.OAuth2Request;
import org.springframework.security.oauth2.provider.token.ResourceServerTokenServices;

/**
 * Author: chautn on 6/10/2018 6:09 PM
 */
public class SResourceServerTokenServices implements ResourceServerTokenServices {

  private static final Logger logger = LoggerFactory.getLogger(SResourceServerTokenServices.class);

  private final String userInfoEndpointUrl;

  private final String clientId;

  private OAuth2RestOperations restTemplate;

  private AuthoritiesExtractor authoritiesExtractor = new FixedAuthoritiesExtractor();

  private PrincipalExtractor principalExtractor = new SPrincipalExtractor();

  public SResourceServerTokenServices(String userInfoEndpointUrl, String clientId) {
    this.userInfoEndpointUrl = userInfoEndpointUrl;
    this.clientId = clientId;
  }

  @Override
  public OAuth2Authentication loadAuthentication(String accessToken) throws AuthenticationException, InvalidTokenException {
    Map<String, Object> map = getMap(this.userInfoEndpointUrl, accessToken);
    if (map.containsKey("error")) {
      if (logger.isDebugEnabled()) {
        logger.debug("userinfo returned error: " + map.get("error"));
      }
      throw new InvalidTokenException(accessToken);
    }
    return extractAuthentication(map);
  }

  @Override
  public OAuth2AccessToken readAccessToken(String accessToken) {
    throw new UnsupportedOperationException("Not supported: read access token");
  }

  private OAuth2Authentication extractAuthentication(Map<String, Object> map) {
    Object principal = getPrincipal(map);
    List<GrantedAuthority> authorities = this.authoritiesExtractor
        .extractAuthorities(map);
    OAuth2Request request = new OAuth2Request(null, this.clientId, null, true, null,
        null, null, null, null);
    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
        principal, "N/A", authorities);
    token.setDetails(map);
    return new OAuth2Authentication(request, token);
  }

  private Object getPrincipal(Map<String, Object> map) {
    Object principal = this.principalExtractor.extractPrincipal(map);
    return (principal == null ? "unknown" : principal);
  }

  @SuppressWarnings({ "unchecked" })
  private Map<String, Object> getMap(String path, String accessToken) {
    if (logger.isDebugEnabled()) {
      logger.debug("Getting user info from: " + path);
    }
    try {
      if (this.restTemplate == null) {
        BaseOAuth2ProtectedResourceDetails resource = new BaseOAuth2ProtectedResourceDetails();
        resource.setClientId(this.clientId);
        this.restTemplate = new OAuth2RestTemplate(resource);
      }
      OAuth2AccessToken existingToken = this.restTemplate.getOAuth2ClientContext().getAccessToken();
      if (existingToken == null || !accessToken.equals(existingToken.getValue())) {
        DefaultOAuth2AccessToken token = new DefaultOAuth2AccessToken(accessToken);
        token.setTokenType(DefaultOAuth2AccessToken.BEARER_TYPE);
        this.restTemplate.getOAuth2ClientContext().setAccessToken(token);
      }
      return this.restTemplate.getForEntity(path, Map.class).getBody();
    }
    catch (Exception ex) {
      logger.warn("Could not fetch user details: " + ex.getClass() + ", " + ex.getMessage());
      return Collections.singletonMap("error", "Could not fetch user details");
    }
  }
}
