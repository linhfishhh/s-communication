package com.tech.backend.communication.client.config.sms;

import feign.Request;
import feign.codec.ErrorDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;

/**
 * @author nguyen.tam.thi at 13:47 2020-10-12
 */
public class SmsBrandNameConfiguration {

  @Autowired
  private Environment env;


  @Bean
  public ErrorDecoder smsBrandNameErrorDecoders() {
    return new SmsBrandNameErrorDecoder();
  }

  @Bean
  public SmsBrandNameInterceptor smsBrandNameInterceptor() {
    return new SmsBrandNameInterceptor();
  }

  @Bean
  public Request.Options feignClientOptions() {
    int connectTimeout = Integer.parseInt(env.getProperty("feign.client.dto.connectTimeout", "500000"));
    int readTimeout = Integer.parseInt(env.getProperty("feign.client.dto.readTimeout", "500000"));
    return new Request.Options(connectTimeout, readTimeout);
  }
}
