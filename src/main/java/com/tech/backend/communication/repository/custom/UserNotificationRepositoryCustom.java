package com.tech.backend.communication.repository.custom;

import com.tech.backend.communication.model.entity.UserNotification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @author nguyen.tam.thi at 13:47 2020-06-26
 */
public interface UserNotificationRepositoryCustom {
    Page<UserNotification> filter(String tenantId, Long profileId, List<String> types, Pageable pageable);
}
