package com.tech.backend.communication.config;

import com.tech.backend.communication.common.ResourceBundle;
import java.util.Locale;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

/**
 * Author: chautn on 1/30/2019 11:01 AM
 */
@Configuration
public class WebConfig {

  @Autowired
  private Environment env;

  @Bean
  ResourceBundle messageSource() {
    ResourceBundle resourceBundle = new ResourceBundle();
    resourceBundle.setBasename("messages.messages");
    resourceBundle.setDefaultEncoding("UTF-8");
    return resourceBundle;
  }

  @Bean
  LocaleChangeInterceptor localeChangeInterceptor() {
    LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
    interceptor.setParamName("language");
    return interceptor;
  }

  @Bean
  SessionLocaleResolver localeResolver() {
    SessionLocaleResolver resolver = new SessionLocaleResolver();
    resolver.setDefaultLocale(new Locale(env.getProperty("locale.language", "vi"), env.getProperty("locale.country", "VN")));
    return resolver;
  }

  @Bean
  ExecutorService executorService() {
    return new ThreadPoolExecutor(10, 100, 10, TimeUnit.SECONDS, new LinkedBlockingQueue<>(1000));
  }
}
