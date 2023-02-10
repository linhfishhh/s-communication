package com.tech.backend.communication.client.config;

import com.tech.backend.communication.model.response.RestResult;
import org.springframework.http.ResponseEntity;

/**
 * Author: chautn on 6/14/2018 1:49 PM
 */
public class FeignClientConverter {

  public static <T> T convert(ResponseEntity<RestResult<T>> response) throws FeignClientException {
    RestResult<T> result = response.getBody();
    T data = result == null ? null : result.getData();

    if (result != null && RestResult.STATUS_ERROR.equals(result.getStatus())) {
      throw new FeignClientException(
          result.getMessage(),
          data == null ? null : data.toString()
      );
    }

    return data;
  }
}
