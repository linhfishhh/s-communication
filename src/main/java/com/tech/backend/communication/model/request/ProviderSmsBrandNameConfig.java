package com.tech.backend.communication.model.request;

import com.tech.backend.communication.model.enumeration.BrandNameAccountMode;
import lombok.Data;

/**
 * @author chuanlh on 2021-03-23
 */
@Data
public class ProviderSmsBrandNameConfig {

  private String user;
  private String pass;
  private String tranId;
//  private String brandName;
  private Integer dataEncode;
  private String sendTime;
  private String telcoCode;
  private BrandNameAccountMode brandNameAccountMode;
}
