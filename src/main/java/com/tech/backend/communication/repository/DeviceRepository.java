package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.Device;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Author: chautn on 7/4/2018 4:15 PM
 */
@Repository
public interface DeviceRepository extends JpaRepository<Device, Long> {

  List<Device> findByProfileId(Long profileId);

  List<Device> findByProfileIdOrderByCreatedDateDesc(Long profileId);

  List<Device> findByProfileIdAndDeviceTokenAndPushServer(Long profileId, String deviceToken, String pushServer);
}
