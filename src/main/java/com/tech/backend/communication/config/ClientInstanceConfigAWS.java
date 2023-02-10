package com.tech.backend.communication.config;

import com.netflix.appinfo.AmazonInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.commons.util.InetUtils;
import org.springframework.cloud.netflix.eureka.EurekaInstanceConfigBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.Environment;

/**
 * Author: chautn on 2/21/2019 10:10 AM
 */
@Configuration
@Profile({"aws"})
public class ClientInstanceConfigAWS {

  @Autowired
  private Environment env;

  @Bean
  public EurekaInstanceConfigBean eurekaInstanceConfig(InetUtils inetUtils) {
    EurekaInstanceConfigBean config = new EurekaInstanceConfigBean(inetUtils);
    AmazonInfo info = AmazonInfo.Builder.newBuilder().autoBuild("eureka");
    config.setEnvironment(env);
    config.setInstanceId(config.getHostname() + ":" + config.getAppname() + ":" + env.getProperty("server.port", Integer.class, 0));
    config.setNonSecurePort(env.getProperty("server.port", Integer.class, 0));
    config.setHostname(info.get(AmazonInfo.MetaDataKey.publicHostname));
    config.setIpAddress(info.get(AmazonInfo.MetaDataKey.publicIpv4));
    config.setDataCenterInfo(info);

    return config;
  }

}
