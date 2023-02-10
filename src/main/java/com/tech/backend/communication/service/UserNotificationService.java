package com.tech.backend.communication.service;

import com.tech.backend.communication.model.response.UserNotificationDto;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * @author nguyen.tam.thi at 14:32 2020-04-21
 */
public interface UserNotificationService {
    Page<UserNotificationDto> getUserNotificationsByProfileId(Long profileId, List<String> types, Integer page, Integer limit);
    Page<UserNotificationDto> getSystemNotifications(String tenantId, List<String> types, Integer page, Integer limit);

    Long countAllNotificationsByProfileId(String tenantId, Long profileId);
    void markRead(Long notificationId);
    void delete(Long profileId, Long notificationId);
    void deleteSystemNotification(Long notificationId);
}
