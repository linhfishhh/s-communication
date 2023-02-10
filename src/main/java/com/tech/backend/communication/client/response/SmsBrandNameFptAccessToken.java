package com.tech.backend.communication.client.response;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.springframework.stereotype.Component;

/**
 * @author nguyen.tam.thi at 11:51 2020-10-12
 */
@Component
@Data
public class SmsBrandNameFptAccessToken {

  @JsonIgnore
  public static final String DEFAULT_ACCESS_TOKEN = "xxx";

  @JsonProperty("access_token")
  private String accessToken = DEFAULT_ACCESS_TOKEN;

  @JsonProperty("expires_in")
  private Long expiresIn;

  @JsonProperty("token_type")
  private String tokenType;

  private String scope;
}

