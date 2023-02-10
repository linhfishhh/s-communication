package com.tech.backend.communication.support.expo;

import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/5/2018 10:22 AM
 */
@Setter
@Getter
public class ExpoResult {

  private Data data;

  @Getter
  @Setter
  public class Data {
    private String status;
    private String message;
    private Details details;

  }

  @Getter
  @Setter
  public class Details {
    private String error;
  }
}
