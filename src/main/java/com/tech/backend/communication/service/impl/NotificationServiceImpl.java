package com.tech.backend.communication.service.impl;

import com.google.gson.Gson;
import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.common.ResourceBundle;
import com.tech.backend.communication.model.entity.Device;
import com.tech.backend.communication.model.entity.NotificationConfig;
import com.tech.backend.communication.model.entity.UserNotification;
import com.tech.backend.communication.model.enumeration.OneSignalTargetType;
import com.tech.backend.communication.model.enumeration.PushServer;
import com.tech.backend.communication.model.request.PushNotificationOneSignalRequest;
import com.tech.backend.communication.model.request.PushNotificationRequest;
import com.tech.backend.communication.repository.DeviceRepository;
import com.tech.backend.communication.repository.NotificationConfigRepository;
import com.tech.backend.communication.repository.UserNotificationRepository;
import com.tech.backend.communication.service.NotificationService;
import com.tech.backend.communication.support.expo.ExpoNotification;
import com.tech.backend.communication.support.expo.ExpoResult;
import com.tech.backend.communication.support.fcm.FcmMessage;
import com.tech.backend.communication.support.fcm.FcmMessage.Priority;
import com.tech.backend.communication.support.fcm.FcmNotification;
import com.tech.backend.communication.support.fcm.MulticastResult;
import com.tech.backend.communication.support.fcm.Sender;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.tech.backend.communication.support.onesignal.OneSignalFilter;
import com.tech.backend.communication.support.onesignal.OneSignalFilterField;
import com.tech.backend.communication.support.onesignal.OneSignalFilterOperator;
import com.tech.backend.communication.support.onesignal.OneSignalNotification;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

/**
 * Author: chautn on 7/4/2018 4:21 PM
 */
@Service
public class NotificationServiceImpl implements NotificationService {

  public static final Logger logger = LoggerFactory.getLogger(NotificationServiceImpl.class);

  @Autowired
  private Environment env;

  @Autowired
  private PoolingHttpClientConnectionManager httpClientConnectionManager;

  @Autowired
  private DeviceRepository deviceRepository;

  @Autowired
  private NotificationConfigRepository notificationConfigRepository;

  @Autowired
  private ResourceBundle resourceBundle;

  @Autowired
  private UserNotificationRepository userNotificationRepository;

  @Override
  public void push(PushNotificationRequest request) {
    validatePushNotificationRequest(request);
    List<Device> devices = deviceRepository.findByProfileId(request.getToProfileId());

    if (CollectionUtils.isNotEmpty(devices)) {
      for (Device device : devices) {
        PushServer pushServer = PushServer.pushServer(device.getPushServer());
        if (pushServer != null) {
          switch (pushServer) {
            case FCM:
              fcmPush(device, request);
              break;
            case EXPO:
              expoPush(device, request);
              break;
            default:
              logger.info("Not supported push server: ".concat(pushServer.name()));
              break;
          }
        } else {
          logger.info("Remove invalid device: ".concat(device.getDeviceToken()));
          deviceRepository.delete(device);
        }
      }
    }
  }

  @Override
  public void pushMuch(List<PushNotificationRequest> request) {

  }

  @Override
  public void pushByOneSignal(PushNotificationOneSignalRequest request) {
    //validate request
    validatePushNotificationOneSignalRequest(request);
    //app id and api key
    NotificationConfig notificationConfig = notificationConfigRepository.findByTenantId(request.getTenantId());
    if (notificationConfig == null) {
      throw new BadRequestException(resourceBundle.getMessage("Không tìm thấy tenantId"));
    }
    logger.info("Get notificationConfig");
    //push notification
    OneSignalNotification notification = new OneSignalNotification();
    notification.setAppId(notificationConfig.getAppId());
    Map<String, String> titles = new HashMap<>();
    titles.put("en", request.getTitle());
    notification.setTitles(titles);
    Map<String, String> contents = new HashMap<>();
    contents.put("en", request.getBody());
    notification.setContents(contents);
    notification.setData(request.getData());
    switch (OneSignalTargetType.targetType(request.getTargetType())) {
      case SEGMENTS:
        notification.setIncludedSegments(request.getTargetIds());
        break;
      case EXTERNAL_USER_IDS:
        notification.setIncludedExternalIds(request.getTargetIds());
      case FILTER:
        setupFilterForNotification(notification, request.getTargetIds());
        break;
    }
    HttpPost post = new HttpPost("https://onesignal.com/api/v1/notifications");
    post.addHeader(HttpHeaders.ACCEPT, "application/json");
    post.addHeader(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8");
    post.addHeader(HttpHeaders.AUTHORIZATION, "Basic " + notificationConfig.getApiKey());
    String notificationAsJson = new Gson().toJson(notification);
    post.setEntity(new StringEntity(notificationAsJson, ContentType.APPLICATION_JSON));

    CloseableHttpResponse response = null;
    try {
      logger.info("Send notification: " + notificationAsJson);
      response = HttpClients
              .custom()
              .setConnectionManager(httpClientConnectionManager)
              .build()
              .execute(post);
      logger.info("Onesignal Response: " + response.toString());
      if (request.getIsSaved()) {
        if (request.getIsSaved()) {
          List<UserNotification> composedNotifications = buildUserNotifications(request);
          userNotificationRepository.saveAll(composedNotifications);
        }
      }
    } catch (IOException ex) {
      logger.error("Fail to push notification to OneSignal.", ex);
    } finally {
      if (response != null) {
        try {
          response.close();
        } catch (IOException e) {
          logger.error("Can not close response stream", e);
        }
      }
    }
  }

  /**
   * build one user notification content
   * @param request
   * @return
   */
  private UserNotification buildUserNotification(PushNotificationOneSignalRequest request) {
    UserNotification userNotification = new UserNotification();
    userNotification.setTitle(request.getTitle());
    userNotification.setMessage(request.getBody());
    userNotification.setImage(request.getImage());
    userNotification.setUrl(request.getUrl());
    userNotification.setTenantId(request.getTenantId().toLowerCase());
    if (request.getData() != null) {
      userNotification.setParams(new Gson().toJson(request.getData()));
      if (request.getData().containsKey("type") && request.getData().get("type") != null) {
        userNotification.setType(request.getData().get("type").toString());
      }
    }
    return userNotification;
  }

  /**
   * Build user notifications for saving from request
   * @param request
   * @return
   */
  private List<UserNotification> buildUserNotifications(PushNotificationOneSignalRequest request) {
    List<UserNotification> notifications = new ArrayList<>();
    if (request.getProfileIds() == null) {
      UserNotification noti = buildUserNotification(request);
      notifications.add(noti);
    } else {
      for (Long profileId: request.getProfileIds()) {
        UserNotification noti = buildUserNotification(request);
        noti.setProfileId(profileId);
        notifications.add(noti);
      }
    }
    return notifications;
  }

  // filter by userId (use for isalon)
  private void setupFilterForNotification(OneSignalNotification notification, List<String> externalUserIds) {
    List<OneSignalFilter> filters = new ArrayList<>();
    int index = 0;
    for (String externalUserId: externalUserIds) {
      OneSignalFilterField filter = OneSignalFilterField.createFilterFieldForTagUserId(externalUserId);
      filters.add(filter);
      if (index < externalUserIds.size() - 1) {
        filters.add(OneSignalFilterOperator.operatorOR());
      }
      index ++;
    }
    notification.setFilters(filters);
  }

  private void validatePushNotificationOneSignalRequest(PushNotificationOneSignalRequest request) {
    if (StringUtils.isBlank(request.getTargetType())) {
      throw new BadRequestException(resourceBundle.getMessage("err.require.param", "targetType"));
    }
    if (OneSignalTargetType.targetType(request.getTargetType()) == null) {
      throw new BadRequestException(resourceBundle.getMessage("err.invalid.type", "targetType"));
    }
  }

  private void fcmPush(Device device, PushNotificationRequest request) {
    logger.info("Push to: " + request.getToProfileId() + " on device: " + device.getId());
    Sender sender = new Sender(env.getProperty("push.firebase.server_key"));
    FcmNotification fcmNotification = new FcmNotification.Builder("")
        .body(request.getBody())
        .sound("default")
        .badge(1)
        .title(request.getTitle())
        .build();
    FcmMessage.Builder mBuilder = new FcmMessage.Builder()
        .priority(FcmMessage.Priority.getPriority(Priority.HIGH.name()))
        .notification(fcmNotification);

    if (request.getData() != null && request.getData().size() > 0) {
      for (Entry<String, String> kv : request.getData().entrySet()) {
        mBuilder.addData(kv.getKey(), kv.getValue());
      }
    }

    FcmMessage message = mBuilder.build();
    List<String> deviceTokens = new ArrayList<>();
    deviceTokens.add(device.getDeviceToken());

    try {
      MulticastResult result = sender.send(message, deviceTokens, 1);
      if (result == null || result.getFailure() > 0) {
        logger.info("Remove offline device: ".concat(device.getDeviceToken()));
        deviceRepository.delete(device);
      }
    } catch (IOException e) {
      logger.error("Fail to push notification to FCM server.", e);
    }
  }

  private void expoPush(Device device, PushNotificationRequest request) {
    ExpoNotification notif = new ExpoNotification();
    notif.setTo(device.getDeviceToken());
    notif.setBody(request.getBody());
    notif.setTitle(request.getTitle());
    notif.setData(request.getData());

    HttpPost post = new HttpPost(env.getProperty("push.expo.api"));
    post.addHeader(HttpHeaders.ACCEPT, "application/json");
    post.addHeader(HttpHeaders.CONTENT_TYPE, "application/json");
    post.addHeader(HttpHeaders.ACCEPT_ENCODING, "gzip, deflate");
    post.setEntity(new StringEntity(new Gson().toJson(notif), ContentType.APPLICATION_JSON));

    try {
      CloseableHttpResponse response = HttpClients
          .custom()
          .setConnectionManager(httpClientConnectionManager)
          .build()
          .execute(post);

      if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
        ExpoResult expoResult = new Gson().fromJson(new InputStreamReader(response.getEntity().getContent()), ExpoResult.class);
        if (expoResult.getData() == null || "error".equals(expoResult.getData().getStatus())) {
          logger.info("Remove offline device: ".concat(device.getDeviceToken()));
          deviceRepository.delete(device);
        }
      } else {
        logger.error("Unable to push notification to EXPO server.");
      }
    } catch (IOException e) {
      logger.error("Fail to push notification to EXPO server.", e);
    }
  }

  private void validatePushNotificationRequest(PushNotificationRequest request) {
    if (request.getToProfileId() == null) {
      throw new BadRequestException(resourceBundle.getMessage("err.require.param", "toProfileId"));
    }
  }
}
