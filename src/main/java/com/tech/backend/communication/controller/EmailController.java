package com.tech.backend.communication.controller;

import com.tech.backend.communication.common.ServicePath;
import com.tech.backend.communication.model.request.EmailRequest;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.service.EmailService;
import com.tech.backend.communication.service.TemplateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by doductrung
 */
@RestController
@RequestMapping(ServicePath.EMAIL)
public class EmailController extends BaseController {

  public static final Logger logger = LoggerFactory.getLogger(EmailController.class);

  @Autowired
  private EmailService emailService;

  @Autowired
  private TemplateService templateService;

  @PostMapping()
  public ResponseEntity sendSingle(@RequestBody EmailRequest request) {
    emailService.send(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Send email successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

}
