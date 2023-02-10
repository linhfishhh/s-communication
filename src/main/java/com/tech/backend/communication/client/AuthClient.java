package com.tech.backend.communication.client;

import com.tech.backend.communication.client.config.FeignClientAccessToken;
import com.tech.backend.communication.client.config.FeignClientConfig;
import com.tech.backend.communication.config.oauth2.SOAuth2Request;
import com.tech.backend.communication.model.response.RestResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Author: chautn on 6/18/2018 11:15 AM
 */
@FeignClient(name = "s-uaa", url = "${feign.baseUrl.uaa}", configuration = FeignClientConfig.class)
public interface AuthClient {

  @RequestMapping(method = RequestMethod.POST, value = "/uaa/login", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
  ResponseEntity<RestResult<FeignClientAccessToken>> requestAccessToken(SOAuth2Request request);

}
