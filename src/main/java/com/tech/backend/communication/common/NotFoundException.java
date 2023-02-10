package com.tech.backend.communication.common;

/**
 * @author nguyen.tam.thi at 11:29 2020-10-12
 */
public class NotFoundException extends BadRequestException {

  public NotFoundException(String exception) {
    super(exception, "404");
  }
}
