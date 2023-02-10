package com.tech.backend.communication.client.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 11:46 2020-10-12
 */
@Data
public class SmsBrandNameFptPushRequest {
  @JsonProperty("access_token")
  private String accessToken;

  @JsonProperty("session_id")
  private String sessionId;

  @JsonProperty("BrandName")
  private String brandName;

  @JsonProperty("Phone")
  private String phone;

  // encode base 64
  @JsonProperty("Message")
  private String message;
}
