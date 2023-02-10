package com.tech.backend.communication.client.config;

import feign.FeignException;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Author: chautn on 6/14/2018 1:43 PM
 */
public class FeignClientException extends FeignException {

  @Getter
  private String data;
  @Getter
  private HttpStatus httpStatus;

  public FeignClientException(String message) {
    super(message);
  }

  public FeignClientException(String message, String data) {
    super(message);
    this.data = data;
  }

  public FeignClientException(String message, HttpStatus httpStatus) {
    super(message);
    this.httpStatus = httpStatus;
  }

}
