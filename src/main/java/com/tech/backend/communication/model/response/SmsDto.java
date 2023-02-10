package com.tech.backend.communication.model.response;

import lombok.Data;

/**
 * @author nguyen.tam.thi at 11:04 2020-10-12
 */
@Data
public class SmsDto {
  private Long id;
  private Long profileId;
  private String tenantId;
  private Long templateId;
  private String contentParams;
  private Long deliveryTime;
  private String phoneNumber;
  private String customContent;
  private String status;
  private String result;
}
