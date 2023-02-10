package com.tech.backend.communication.model.entity;

import com.tech.backend.communication.model.entity.listener.SEntity;
import com.tech.backend.communication.model.entity.listener.SEntityListener;
import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 7/4/2018 4:10 PM
 */
@Getter
@Setter
@Entity
@Table(name = "device")
@EntityListeners(SEntityListener.class)
public class Device implements Serializable, SEntity {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", unique = true, nullable = false)
  private Long id;

  @Column(name = "profile_id")
  private Long profileId;

  @Column(name = "profile_type")
  private String profileType;

  @Column(name = "device_token")
  private String deviceToken;

  @Column(name = "device_type")
  private String deviceType;

  @Column(name = "push_server")
  private String pushServer;

  @Column(name = "language")
  private String language;

  @Column(name = "created_by", length = 100)
  private String createdBy = "SYSTEM";

  @Column(name = "created_date", nullable = true)
  private Timestamp createdDate;

  @Column(name = "modified_by", length = 50)
  private String modifiedBy = "SYSTEM";

  @Column(name = "modified_date", nullable = true)
  private Timestamp modifiedDate;

}
