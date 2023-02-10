package com.tech.backend.communication.model.response;

import lombok.Getter;
import lombok.Setter;

/**
 * @author chuanlh on 2020-12-04
 */
@Getter
@Setter
public class TemplateDTO {

  private Long templateId;
  private String type;
  private String code;
  private String message;
  private String encode;
  private String fromName;
  private String fromAddress;
  private String language;
  private String title;
  private String tenantId;
  private String preview;
  private String defaultParamValue;

  private int smsTotal;
}
