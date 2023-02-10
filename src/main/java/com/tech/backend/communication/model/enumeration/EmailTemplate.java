package com.tech.backend.communication.model.enumeration;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * Created by chautn on 8/11/2017.
 */
@Data
@NoArgsConstructor
public class EmailTemplate {
  public static final String RESET_PASSWORD = "RESET_PASSWORD";
  public static final String TYPE = "EMAIL";

  private String name;
  private Map<String, String> params;
  private String description;

  EmailTemplate(String name, Map<String, String> params, String description) {
    this.name = name;
    this.params = params;
    this.description = description;
  }

  public static EmailTemplate fromString(String name) {
    EmailTemplate template = new EmailTemplate();
    template.setName(name);
    return template;
  }
}
