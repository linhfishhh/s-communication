package com.tech.backend.communication.client.config;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

/**
 * Author: chautn on 6/17/2018 5:23 PM
 */

@Component
@Getter
@Setter
public class FeignClientAccessToken {
  @JsonProperty(value = "access_token")
  private String accessToken;
}
