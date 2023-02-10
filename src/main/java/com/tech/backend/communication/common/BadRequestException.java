package com.tech.backend.communication.common;

import lombok.Getter;

/**
 * Author: chautn on 6/12/2018 6:12 PM
 */
public class BadRequestException extends RuntimeException {

  @Getter
  private String code;

  public BadRequestException() {
    super("Invalid request");
  }

  public BadRequestException(String message) {
    super(message);
  }

  public BadRequestException(String message, String code) {
    super(message);
    this.code = code;
  }

}
