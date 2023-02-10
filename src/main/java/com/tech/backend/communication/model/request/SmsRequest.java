package com.tech.backend.communication.model.request;

import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import io.swagger.annotations.ApiModelProperty;
import java.util.Map;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 10:56 2020-10-12
 */
@Data
public class SmsRequest {

  private String tenantId;

  @ApiModelProperty(example = "Multi phone number is appended betwen [,]: 0928282828,092383883")
  private String phone;

  private Long profileId;
  private String templateCode;
  private Map<String, Object> params;
  private String customContent;
  private String language = SupportedLanguage.VIETNAMESE.language();
  private Long providerId;
  private String brandName;
  private ProviderSmsBrandNameConfig providerSmsBrandNameConfig;
}
