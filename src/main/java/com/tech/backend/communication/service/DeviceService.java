package com.tech.backend.communication.service;

import com.tech.backend.communication.model.entity.Device;
import com.tech.backend.communication.model.request.DeviceRequest;
import java.util.List;

/**
 * Author: chautn on 7/5/2018 10:49 AM
 */
public interface DeviceService {

  void register(DeviceRequest request);

  void unregister(DeviceRequest request);

  List<Device> getDevice(Long profileId);
}
