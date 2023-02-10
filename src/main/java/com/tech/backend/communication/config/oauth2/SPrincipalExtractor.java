package com.tech.backend.communication.config.oauth2;

import com.google.gson.Gson;
import java.util.Map;
import org.springframework.boot.autoconfigure.security.oauth2.resource.PrincipalExtractor;

/**
 * Author: chautn on 6/10/2018 3:59 PM
 */
public class SPrincipalExtractor implements PrincipalExtractor {

  @Override
  public SUserDetails extractPrincipal(Map<String, Object> map) {
    return new Gson().fromJson(map.get("principal").toString(), SUserDetails.class);
  }
}
