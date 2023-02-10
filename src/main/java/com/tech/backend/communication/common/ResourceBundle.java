package com.tech.backend.communication.common;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;

/**
 * Author: chautn on 1/30/2019 11:45 AM
 */
public class ResourceBundle extends ResourceBundleMessageSource {

  public String getMessage(String code) {
    return getMessage(code, new Object[0]);
  }

  public String getMessage(String code, Object... params) {
    return getMessage(code, params, "Code not found", LocaleContextHolder.getLocale());
  }

}
