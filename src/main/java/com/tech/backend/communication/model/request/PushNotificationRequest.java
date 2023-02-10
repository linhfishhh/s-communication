package com.tech.backend.communication.model.request;

import java.util.Map;
import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/4/2018 3:39 PM
 */
@Getter
@Setter
public class  PushNotificationRequest {

  private Long toProfileId;
  private String title;
  private String body;
  private Map<String, String> data;

}
