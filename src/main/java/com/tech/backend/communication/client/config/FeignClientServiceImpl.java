package com.tech.backend.communication.client.config;

import com.tech.backend.communication.client.AuthClient;
import com.tech.backend.communication.config.oauth2.SOAuth2Request;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

/**
 * Author: chautn on 6/18/2018 7:43 PM
 */
@Service
public class FeignClientServiceImpl implements FeignClientService {

  private static final Logger logger = LoggerFactory.getLogger(FeignClientServiceImpl.class);

  @Autowired
  private AuthClient authClient;

  @Autowired
  private Environment env;

  @Autowired
  private FeignClientAccessToken feignClientAccessToken;

  @Override
  public void selfAuthenticate() {
    SOAuth2Request request = new SOAuth2Request();
    request.setGrantType("client_credentials");
    request.setTenantId(env.getRequiredProperty("feign.client.oauth2.clientId"));
    request.setPassword(env.getRequiredProperty("feign.client.oauth2.clientSecret"));
    logger.info("Requesting access token for " + request.toString());
    FeignClientAccessToken accessToken = FeignClientConverter.convert(authClient.requestAccessToken(request));
    if (accessToken == null || StringUtils.isBlank(accessToken.getAccessToken())) {
      throw new FeignClientException("Can not self authenticate");
    }
    logger.info("Got access token: " + accessToken.getAccessToken());
    feignClientAccessToken.setAccessToken(accessToken.getAccessToken());
  }
}
