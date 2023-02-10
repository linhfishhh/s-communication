package com.tech.backend.communication.model.request;

import lombok.Builder;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 11:14 2020-10-12
 */
@Data
@Builder
public class TemplateFilterRequest {
  private String templateCode;
  private String tenantId;
  private String language;
  private String type;
}
