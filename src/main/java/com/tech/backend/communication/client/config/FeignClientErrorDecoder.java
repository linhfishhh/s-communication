package com.tech.backend.communication.client.config;

import com.google.gson.Gson;
import com.tech.backend.communication.model.response.RestResult;
import feign.Response;
import feign.codec.ErrorDecoder;
import java.io.BufferedReader;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

/**
 * Author: chautn on 6/18/2018 8:37 PM
 */
public class FeignClientErrorDecoder implements ErrorDecoder {

  private static final Logger logger = LoggerFactory.getLogger(FeignClientInterceptor.class);

  @Autowired
  private FeignClientService feignClientService;

  @Override
  public Exception decode(String methodKey, Response response) {
    logger.error("Feign response error with code: " + response.status());
    if (response.status() == HttpStatus.UNAUTHORIZED.value()) {
      feignClientService.selfAuthenticate();
    }
    try {
      BufferedReader reader = new BufferedReader(response.body().asReader());
      StringBuilder body = new StringBuilder();
      String line;
      while ((line = reader.readLine()) != null) {
        body.append(line).append("\n");
      }
      logger.info("Feign response error: " + body.toString());
      RestResult restResult = new Gson().fromJson(body.toString(), RestResult.class);
      if (restResult == null || StringUtils.isBlank(restResult.getStatus())) {
        throw new FeignClientException(body.toString());
      } else {
        throw new FeignClientException(
            restResult.getMessage(),
            HttpStatus.valueOf(response.status())
        );
      }

    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      return e;
    }
  }
}
