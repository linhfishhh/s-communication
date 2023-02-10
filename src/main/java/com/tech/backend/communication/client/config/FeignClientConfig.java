package com.tech.backend.communication.client.config;

import feign.Request.Options;
import feign.codec.ErrorDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

/**
 * Author: chautn on 6/18/2018 11:34 AM
 */
public class FeignClientConfig {

  @Bean
  public ErrorDecoder feignClientErrorDecoder() {
    return new FeignClientErrorDecoder();
  }

  @Bean
  public FeignClientInterceptor feignClientInterceptor() {
    return new FeignClientInterceptor();
  }

  @Bean
  public Options feignClientOptions(Environment env) {
    int connectTimeout = Integer.parseInt(env.getProperty("feign.client.request.connectTimeout", "500000"));
    int readTimeout = Integer.parseInt(env.getProperty("feign.client.request.readTimeout", "500000"));
    return new Options(connectTimeout, readTimeout);
  }
}
