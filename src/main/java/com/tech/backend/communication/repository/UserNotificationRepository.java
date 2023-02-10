package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.UserNotification;
import com.tech.backend.communication.repository.custom.UserNotificationRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author nguyen.tam.thi at 13:53 2020-04-21
 */
@Repository
public interface UserNotificationRepository extends JpaRepository<UserNotification, Long>, UserNotificationRepositoryCustom {
    Long countAllByProfileIdAndReadIsFalse(Long profileId);
    Long countAllByTenantIdAndProfileIdIsNull(String tenantId);

    @Transactional
    @Modifying
    void deleteByProfileIdAndUserNotificationId(Long profileId, Long userNotificationId);

    @Transactional
    @Modifying
    @Query(value = "UPDATE user_notification SET read = TRUE WHERE user_notification_id = ?1", nativeQuery = true)
    void markRead(Long notificationId);
}
