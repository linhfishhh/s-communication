package com.tech.backend.communication.config;

import com.tech.backend.communication.config.oauth2.SResourceServerTokenServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.oauth2.resource.ResourceServerProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;

/**
 * Author: chautn on 6/7/2018 12:36 PM
 */
@EnableResourceServer
@Configuration
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

  @Autowired
  private Environment env;

  @Autowired
  private ResourceServerProperties sso;

  @Override
  public void configure(ResourceServerSecurityConfigurer resources) {
    resources.tokenServices(new SResourceServerTokenServices(sso.getUserInfoUri(), sso.getClientId()));
  }

  @Override
  public void configure(HttpSecurity http) throws Exception {
    ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry authorization = http.authorizeRequests();
    boolean enableSecurity = env.getProperty("api.enable_security", Boolean.class, true);
    boolean enableSwagger = env.getProperty("api.enable_swagger", Boolean.class, true);
    if (enableSwagger) {
      authorization.antMatchers("/v2/api-docs", "/configuration/**", "/swagger-resources/**",  "/swagger-ui.html", "/webjars/**", "/api-docs/**").permitAll();
    } else {
      authorization.antMatchers("/v2/api-docs", "/configuration/**", "/swagger-resources/**",  "/swagger-ui.html", "/webjars/**", "/api-docs/**").denyAll();
    }
    if (enableSecurity) {
      authorization
          .antMatchers("/").permitAll()
          .antMatchers("/**").authenticated();
    } else {
      authorization.antMatchers("/**").permitAll();
    }
  }

}
