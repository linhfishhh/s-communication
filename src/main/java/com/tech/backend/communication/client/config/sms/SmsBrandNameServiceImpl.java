package com.tech.backend.communication.client.config.sms;

import com.tech.backend.communication.client.SmsBrandNameFptClient;
import com.tech.backend.communication.client.config.FeignClientException;
import com.tech.backend.communication.client.request.SmsBrandNameFptAuthRequest;
import com.tech.backend.communication.client.response.SmsBrandNameFptAccessToken;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

/**
 * @author nguyen.tam.thi at 16:19 2020-10-12
 */
@Slf4j
@Service
public class SmsBrandNameServiceImpl implements SmsBrandNameService {
  @Autowired
  private Environment env;

  @Autowired
  private SmsBrandNameFptClient smsBrandNameFptClient;

  @Autowired
  private SmsBrandNameFptAccessToken smsBrandNameFptAccessToken;

  @Override
  public void smsBrandNameFptAuthenticate() {
    SmsBrandNameFptAuthRequest request = new SmsBrandNameFptAuthRequest();
    request.setGrantType(env.getRequiredProperty("sms_brand_name.supplier.fpt.grant_type"));
    request.setClientId(env.getRequiredProperty("sms_brand_name.supplier.fpt.client_id"));
    request.setClientSecret(env.getRequiredProperty("sms_brand_name.supplier.fpt.client_secret"));
    request.setScope(env.getRequiredProperty("sms_brand_name.supplier.fpt.scope"));
    request.setSessionId(UUID.randomUUID().toString());
    log.info("Requesting access token for " + request.toString());
    SmsBrandNameFptAccessToken accessToken = smsBrandNameFptClient.requestAccessToken(request).getBody();
    if (accessToken == null || StringUtils.isBlank(accessToken.getAccessToken())) {
      throw new FeignClientException("Can not self authenticate");
    }
    log.info("Got access token: " + accessToken.getAccessToken());
    smsBrandNameFptAccessToken.setAccessToken(accessToken.getAccessToken());
  }
}
