package com.tech.backend.communication.service;

import com.tech.backend.communication.model.request.PushNotificationOneSignalRequest;
import com.tech.backend.communication.model.request.PushNotificationRequest;

import java.util.List;

/**
 * Author: chautn on 7/4/2018 4:20 PM
 */
public interface NotificationService {

  void push(PushNotificationRequest request);

  void pushMuch(List<PushNotificationRequest> request);

  void pushByOneSignal(PushNotificationOneSignalRequest request);
}
