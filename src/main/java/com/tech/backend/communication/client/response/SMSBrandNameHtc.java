package com.tech.backend.communication.client.response;

import lombok.Getter;
import lombok.Setter;

/**
 * @author chuanlh on 2021-03-24
 */
@Getter
@Setter
public class SMSBrandNameHtc {

  private String code;
  private String message;
  private String transId;
  private String oper;
  private String totalSMS;

}
