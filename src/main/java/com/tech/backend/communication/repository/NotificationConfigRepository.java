package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.NotificationConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by thanhtrung on 11/12/19
 */
@Repository
public interface NotificationConfigRepository extends JpaRepository<NotificationConfig, Integer> {

    NotificationConfig findByTenantId(String tenantId);
}
