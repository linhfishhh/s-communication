package com.tech.backend.communication.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.commons.util.InetUtils;
import org.springframework.cloud.netflix.eureka.EurekaInstanceConfigBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.Environment;

/**
 * Author: chautn on 2/17/2019 9:28 PM
 */
@Configuration
@Profile({"default", "local"})
public class ClientInstanceConfig {

  @Autowired
  private Environment env;

  @Bean
  public EurekaInstanceConfigBean eurekaInstanceConfig(InetUtils inetUtils) {
    EurekaInstanceConfigBean config = new EurekaInstanceConfigBean(inetUtils);
    config.setEnvironment(env);
    config.setInstanceId(config.getHostname() + ":" + config.getAppname() + ":" + env.getProperty("server.port", Integer.class, 0));
    config.setNonSecurePort(env.getProperty("server.port", Integer.class, 0));
    return config;
  }
}
