package com.tech.backend.communication.controller;

import com.tech.backend.communication.common.ServicePath;
import com.tech.backend.communication.model.request.PushNotificationOneSignalRequest;
import com.tech.backend.communication.model.request.PushNotificationRequest;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.service.NotificationService;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Created by chautn on 8/11/2017.
 */
@RestController
@RequestMapping(ServicePath.NOTIFICATION)
public class NotificationController extends BaseController {

  public static final Logger logger = LoggerFactory.getLogger(NotificationController.class);

  @Autowired
  private NotificationService notificationService;

  @PostMapping(ServicePath.PUSH)
  public ResponseEntity push(@RequestBody PushNotificationRequest request) {
    notificationService.push(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Push notification successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

  @PostMapping(ServicePath.PUSH_MUCH)
  public ResponseEntity pushMuch(@RequestBody List<PushNotificationRequest> requests) {
    requests.forEach(pushNotificationRequest -> {
      notificationService.push(pushNotificationRequest);
    });
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Push notification successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

  @PostMapping(ServicePath.PUSH_BY_ONE_SIGNAL)
  public ResponseEntity pushByOneSignal(@RequestBody PushNotificationOneSignalRequest request) {
    notificationService.pushByOneSignal(request);
    RestResult result = new RestResult<>();
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Push notification successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }
}
