package com.tech.backend.communication.client.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 11:52 2020-10-12
 */
@Data
public class SmsBrandNameFptAuthRequest {
  @JsonProperty("grant_type")
  private String grantType;

  @JsonProperty("client_id")
  private String clientId;

  @JsonProperty("client_secret")
  private String clientSecret;

  private String scope;

  @JsonProperty("session_id")
  private String sessionId;
}
