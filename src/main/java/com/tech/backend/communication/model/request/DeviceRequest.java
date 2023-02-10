package com.tech.backend.communication.model.request;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/5/2018 10:50 AM
 */
@Getter
@Setter
public class DeviceRequest {

  private String deviceToken;
  private String deviceType;
  private String pushServer;
  @JsonIgnore
  private String language;
}
