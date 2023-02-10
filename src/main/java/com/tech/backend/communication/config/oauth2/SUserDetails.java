package com.tech.backend.communication.config.oauth2;

import java.io.Serializable;
import java.security.Principal;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Author: chautn on 6/6/2018 3:37 PM
 */
@Getter
@Setter
@ToString
public class SUserDetails implements Principal, Serializable {

  private String tenantId;
  private Long tenantProfileId;
  private Long userId;
  private String profileType;
  private Long profileId;

  public SUserDetails(String tenantId) {
    this.tenantId = tenantId;
  }

  @Override
  public String getName() {
    String name = profileType == null ? "" : profileType;
    name += profileId == null ? "" : ("_" + profileId.toString());
    return name.isEmpty() ? tenantId : name;
  }

}
