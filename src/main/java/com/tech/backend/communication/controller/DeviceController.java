package com.tech.backend.communication.controller;

import com.tech.backend.communication.common.ServicePath;
import com.tech.backend.communication.model.request.DeviceRequest;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.service.DeviceService;
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
 * Author: chautn on 7/5/2018 10:51 AM
 */
@RestController
@RequestMapping(ServicePath.DEVICE)
public class DeviceController extends BaseController {

  public static final Logger logger = LoggerFactory.getLogger(DeviceController.class);

  @Autowired
  private DeviceService deviceService;

  @PostMapping(ServicePath.REGISTER)
  public ResponseEntity register(@RequestBody DeviceRequest request) {
    deviceService.register(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Register device successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

  @PostMapping(ServicePath.UNREGISTER)
  public ResponseEntity unregister(@RequestBody DeviceRequest request) {
    deviceService.unregister(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Unregister device successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

}
