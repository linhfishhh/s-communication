package com.tech.backend.communication.model.enumeration;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by chautn on 7/25/2017.
 */
public enum SupportedLanguage {
  ENGLISH("en-US"),
  VIETNAMESE("vi-VN");

  private String language;

  SupportedLanguage(String language) {
    this.language = language;
  }

  public static SupportedLanguage getSupportedLanguage(String text) {
    if(StringUtils.isEmpty(text)) {
      return VIETNAMESE;
    }
    for (SupportedLanguage supportedLanguage : values()) {
      if (supportedLanguage.language().equals(text) || (StringUtils.isNotBlank(text) && supportedLanguage.language().equals(text.replace("-", "_")))) {
        return supportedLanguage;
      }
    }
    return VIETNAMESE;
  }

  public String language() {
    return language;
  }

}
