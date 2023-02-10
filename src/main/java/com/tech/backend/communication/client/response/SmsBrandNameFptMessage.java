package com.tech.backend.communication.client.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 11:51 2020-10-12
 */
@Data
public class SmsBrandNameFptMessage {
  @JsonProperty("MessageId")
  private String messageId;

  @JsonProperty("BrandName")
  private String brandName;

  @JsonProperty("Phone")
  private String phone;

  @JsonProperty("Message")
  private String message;

  @JsonProperty("PartnerId")
  private String partnerId;

  @JsonProperty("Telco")
  private String telco;

  // 0: is not sent, 1: is sent
  @JsonProperty("IsSent")
  private Integer isSent;
}
