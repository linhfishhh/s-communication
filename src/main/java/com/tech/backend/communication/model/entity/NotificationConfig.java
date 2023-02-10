package com.tech.backend.communication.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * Created by thanhtrung on 11/12/19
 */

@Getter
@Setter
@Entity
@Table(name = "notification_config")
public class NotificationConfig {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @Column(name = "app_id")
    private String appId;

    @Column(name = "api_key")
    private String apiKey;

    @Column(name = "tenant_id")
    private String tenantId;
}
