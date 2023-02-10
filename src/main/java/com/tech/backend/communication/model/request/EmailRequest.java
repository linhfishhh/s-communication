package com.tech.backend.communication.model.request;

import java.util.Map;
import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/4/2018 3:39 PM
 */
@Getter
@Setter
public class EmailRequest {

  private Long profileId;
  private String profileType;
  private String email;
  private String templateCode;
  private Map<String, Object> params;
  private String tenantId;
  private String bcc;
  private String cc;
  private String fromName;
  private String replyTo;
}
