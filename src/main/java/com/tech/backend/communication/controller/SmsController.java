package com.tech.backend.communication.controller;

import com.tech.backend.communication.model.request.EmailRequest;
import com.tech.backend.communication.model.request.SmsRequest;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.service.SmsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author nguyen.tam.thi at 16:31 2020-10-12
 */
@RestController
@RequestMapping("/sms")
public class SmsController extends BaseController {

  @Autowired
  private SmsService smsService;

  @PostMapping()
  public ResponseEntity send(@RequestBody SmsRequest request) {
    smsService.send(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Send sms successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }
}
