package com.tech.backend.communication.service.impl;

import com.tech.backend.communication.model.entity.UserNotification;
import com.tech.backend.communication.model.mapper.UserNotificationMapper;
import com.tech.backend.communication.model.response.UserNotificationDto;
import com.tech.backend.communication.repository.UserNotificationRepository;
import com.tech.backend.communication.service.UserNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author nguyen.tam.thi at 14:36 2020-04-21
 */
@Service
public class UserNotificationServiceImpl implements UserNotificationService {

    @Autowired
    private UserNotificationRepository userNotificationRepository;

    @Override
    public Page<UserNotificationDto> getUserNotificationsByProfileId(Long profileId, List<String> types, Integer page, Integer limit) {
        if (profileId == null) {
            throw new NullPointerException("Không tìm thấy profile");
        }
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by(Sort.Order.desc("created_date")));
        Page<UserNotification> entities = userNotificationRepository.filter(null, profileId, types, pageRequest);
        return UserNotificationMapper.INSTANCE.toDtos(entities);
    }

    @Override
    public Page<UserNotificationDto> getSystemNotifications(String tenantId, List<String> types, Integer page, Integer limit) {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by(Sort.Order.desc("created_date")));
        Page<UserNotification> entities = userNotificationRepository.filter(tenantId.toLowerCase(), null, types, pageRequest);
        return UserNotificationMapper.INSTANCE.toDtos(entities);
    }

    @Override
    public Long countAllNotificationsByProfileId(String tenantId, Long profileId) {
        return userNotificationRepository.countAllByProfileIdAndReadIsFalse(profileId);
    }

    @Override
    public void markRead(Long notificationId) {
        userNotificationRepository.markRead(notificationId);
    }

    @Override
    public void delete(Long profileId, Long notificationId) {
        userNotificationRepository.deleteByProfileIdAndUserNotificationId(profileId, notificationId);
    }

    @Override
    public void deleteSystemNotification(Long notificationId) {
        userNotificationRepository.deleteById(notificationId);
    }
}
