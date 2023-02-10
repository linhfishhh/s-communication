package com.tech.backend.communication.client;

import com.tech.backend.communication.client.config.sms.SmsBrandNameConfiguration;
import com.tech.backend.communication.client.request.SmsBrandNameFptAuthRequest;
import com.tech.backend.communication.client.request.SmsBrandNameFptPushRequest;
import com.tech.backend.communication.client.response.SmsBrandNameFptAccessToken;
import com.tech.backend.communication.client.response.SmsBrandNameFptMessage;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author nguyen.tam.thi at 11:50 2020-10-12
 */
@FeignClient(name = "smsBrandName", url = "${sms_brand_name.supplier.fpt.host}", configuration = SmsBrandNameConfiguration.class)
public interface SmsBrandNameFptClient {
  @RequestMapping(method = RequestMethod.POST, value = "/oauth2/token", consumes = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<SmsBrandNameFptAccessToken> requestAccessToken(SmsBrandNameFptAuthRequest request);

  @RequestMapping(method = RequestMethod.POST, value = "/api/push-brandname-otp", consumes = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<SmsBrandNameFptMessage> push(SmsBrandNameFptPushRequest request);
}
