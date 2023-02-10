package com.tech.backend.communication.client.request;

import lombok.Builder;
import lombok.Data;

/**
 * @author chuanlh on 2021-03-24
 */
@Data
@Builder
public class SMSBrandNameHtcRequest {

  private String user;
  private String pass;
  private String tranId;
  private String brandName;
  private String phone;
  private Integer dataEncode;
  private String sendTime;
  private String telcoCode;
  private String mess;
}
