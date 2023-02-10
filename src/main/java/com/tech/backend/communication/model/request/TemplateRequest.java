package com.tech.backend.communication.model.request;

import java.util.Map;
import lombok.Builder;
import lombok.Data;

/**
 * @author chuanlh on 2020-12-07
 */
@Data
@Builder
public class TemplateRequest {

  private String templateCode;
  private String tenantId;
  private String language;
  private String type;
  private Map<String, Object> params;
}
