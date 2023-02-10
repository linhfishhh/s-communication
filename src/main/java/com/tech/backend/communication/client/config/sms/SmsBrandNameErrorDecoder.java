package com.tech.backend.communication.client.config.sms;

import com.google.gson.Gson;
import com.tech.backend.communication.client.config.FeignClientException;
import com.tech.backend.communication.client.response.SmsBrandNameFptError;
import feign.Response;
import feign.codec.ErrorDecoder;
import java.io.BufferedReader;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.oauth2.common.exceptions.UnauthorizedClientException;
import org.springframework.stereotype.Component;

/**
 * @author nguyen.tam.thi at 17:22 2020-10-12
 */
@Slf4j
@Component
public class SmsBrandNameErrorDecoder implements ErrorDecoder {

  @Autowired
  private SmsBrandNameService smsBrandNameService;

  @Override
  public Exception decode(String s, Response response) {
    if (response.status() == HttpStatus.UNAUTHORIZED.value()) {
      smsBrandNameService.smsBrandNameFptAuthenticate();
      return new UnauthorizedClientException("Token Unauthorized");
    }
    try {
      BufferedReader reader = new BufferedReader(response.body().asReader());
      StringBuilder body = new StringBuilder();
      String line;
      while ((line = reader.readLine()) != null) {
        body.append(line).append("\n");
      }
      log.info("Sms brand name feign client response error: " + body.toString());
      SmsBrandNameFptError restResult = new Gson().fromJson(body.toString(), SmsBrandNameFptError.class);
      if (restResult == null || StringUtils.isBlank(restResult.getErrorDescription())) {
        throw new FeignClientException(body.toString());
      } else {
        throw new FeignClientException(
            restResult.getErrorDescription(),
            HttpStatus.valueOf(response.status())
        );
      }

    } catch (Exception e) {
      log.error(e.getMessage(), e);
      return e;
    }
  }
}
