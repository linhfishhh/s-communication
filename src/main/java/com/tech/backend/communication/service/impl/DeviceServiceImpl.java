package com.tech.backend.communication.service.impl;

import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.common.ResourceBundle;
import com.tech.backend.communication.config.oauth2.SUserDetails;
import com.tech.backend.communication.model.entity.Device;
import com.tech.backend.communication.model.enumeration.PushServer;
import com.tech.backend.communication.model.request.DeviceRequest;
import com.tech.backend.communication.repository.DeviceRepository;
import com.tech.backend.communication.service.DeviceService;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

/**
 * Author: chautn on 7/5/2018 10:55 AM
 */
@Service
public class DeviceServiceImpl implements DeviceService {

  @Autowired
  private DeviceRepository deviceRepository;

  @Autowired
  private ResourceBundle resourceBundle;

  @Override
  public void register(DeviceRequest request) {
    validateRegisterRequest(request);
    SUserDetails authUser = (SUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    if (authUser.getProfileId() == null) {
      throw new BadRequestException(resourceBundle.getMessage("err.auth"));
    }
    List<Device> devices = deviceRepository.findByProfileIdAndDeviceTokenAndPushServer(authUser.getProfileId(), request.getDeviceToken(), request.getPushServer());
    if (CollectionUtils.isNotEmpty(devices)) {
      return;
    }
    Device device = new Device();
    device.setDeviceToken(request.getDeviceToken());
    device.setDeviceType(request.getDeviceType());
    device.setPushServer(request.getPushServer());
    device.setProfileId(authUser.getProfileId());
    device.setLanguage(request.getLanguage());
    device.setProfileType(authUser.getProfileType());
    deviceRepository.save(device);
  }

  @Override
  public void unregister(DeviceRequest request) {
    SUserDetails authUser = (SUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    if (authUser.getProfileId() == null) {
      throw new BadRequestException(resourceBundle.getMessage("err.auth"));
    }
    List<Device> devices = deviceRepository.findByProfileIdAndDeviceTokenAndPushServer(authUser.getProfileId(), request.getDeviceToken(), request.getPushServer());
    if (CollectionUtils.isNotEmpty(devices)) {
      deviceRepository.deleteAll(devices);
    }
  }

  @Override
  public List<Device> getDevice(Long profileId) {
    if(profileId == null) {
      return new ArrayList<>();
    }
    return deviceRepository.findByProfileIdOrderByCreatedDateDesc(profileId);
  }

  private void validateRegisterRequest(DeviceRequest request) {
    if (StringUtils.isBlank(request.getDeviceToken())) {
      throw new BadRequestException(resourceBundle.getMessage("err.require.param", "deviceToken"));
    }
    PushServer pushServer = PushServer.pushServer(request.getPushServer());
    if (pushServer == null) {
      throw new BadRequestException(resourceBundle.getMessage("err.invalid.param", "pushServer[FCM, EXPO]"));
    }
  }

}
