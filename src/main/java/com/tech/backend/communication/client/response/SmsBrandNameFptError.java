package com.tech.backend.communication.client.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * @author nguyen.tam.thi at 17:23 2020-10-12
 */
@Data
public class SmsBrandNameFptError {
  private Integer error;

  @JsonProperty("error_description")
  private String errorDescription;
}

