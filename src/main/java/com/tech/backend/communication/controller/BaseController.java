package com.tech.backend.communication.controller;

import com.tech.backend.communication.client.config.FeignClientException;
import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.config.oauth2.SUserDetails;
import com.tech.backend.communication.model.response.RestResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author vuld
 */
public class BaseController implements ErrorController {

  private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

  @Override
  public String getErrorPath() {
    return "/error";
  }

  @ExceptionHandler({BadRequestException.class})
  @ResponseBody
  public ResponseEntity handleInvalidRequestException(BadRequestException exception) {
    logger.error(exception.getMessage(), exception);
    RestResult<String> result = new RestResult<>();
    result.setStatus(RestResult.STATUS_ERROR);
    result.setMessage(exception.getMessage());
    result.setData(exception.getCode());
    return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
  }

  @ExceptionHandler({FeignClientException.class})
  @ResponseBody
  public ResponseEntity handleFeignClientException(FeignClientException exception) {
    logger.error(exception.getMessage(), exception);
    RestResult<String> result = new RestResult<>();
    result.setStatus(RestResult.STATUS_ERROR);
    result.setMessage(exception.getMessage());
    result.setData(exception.getData());
    return new ResponseEntity<>(result, exception.getHttpStatus() != null ? exception.getHttpStatus() : HttpStatus.INTERNAL_SERVER_ERROR);
  }

  @ExceptionHandler({Exception.class})
  @ResponseBody
  public ResponseEntity handleException(Exception exception) {
    logger.error(exception.getMessage(), exception);
    RestResult<String> result = new RestResult<>();
    result.setStatus(RestResult.STATUS_ERROR);
    result.setMessage("Internal server error");
    result.setData(exception.getMessage());
    return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
  }

  protected Long getProfileId() {
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    if (auth != null && auth.getPrincipal() != null && auth.getPrincipal() instanceof SUserDetails) {
      SUserDetails sUserDetails = (SUserDetails) auth.getPrincipal();
      return sUserDetails.getProfileId();
    } else {
      return null;
    }
  }

  protected String getProfileType() {
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    if (auth != null && auth.getPrincipal() != null && auth.getPrincipal() instanceof SUserDetails) {
      SUserDetails sUserDetails = (SUserDetails) auth.getPrincipal();
      return sUserDetails.getProfileType();
    } else {
      return null;
    }
  }
}
