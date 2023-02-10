package com.tech.backend.communication.support.expo;

import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/4/2018 5:34 PM
 */
@Getter
@Setter
public class ExpoNotification {

  private String to;
  private Object data;
  private String title;
  private String body;
  private String priority = "high"; // 'default' | 'normal' | 'high'
  private String sound = "default"; // 'default' | null,
  private Integer badge = 1;
}
