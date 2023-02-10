package com.tech.backend.communication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableOAuth2Client;

/**
 * @author vuld
 */
@SpringBootApplication
@EnableOAuth2Client
@EnableDiscoveryClient
@EnableFeignClients
public class CommunicationServiceApplication {

  public static void main(String[] args) {
    SpringApplication.run(CommunicationServiceApplication.class, args);
  }
}
