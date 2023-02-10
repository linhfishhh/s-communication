package com.tech.backend.communication.model.entity;

import lombok.Getter;
import lombok.Setter;
import javax.persistence.Id;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Column;
import javax.persistence.Table;
import java.sql.Timestamp;
import java.io.Serializable;
import com.tech.backend.communication.model.entity.listener.SEntity;
import com.tech.backend.communication.model.entity.listener.SEntityListener;

/**
* @author nguyen.tam.thi at 13:39 2020-04-21
*/
@Entity
@Getter @Setter
@Table(name = "user_notification")
@EntityListeners(SEntityListener.class)
public class UserNotification implements Serializable, SEntity {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "user_notification_id", unique = true, nullable = false)
   private Long userNotificationId;

   @Column(name = "tenant_id")
   private String tenantId;

   @Column(name = "profile_id")
   private Long profileId;

   @Column(name = "title")
   private String title;

   @Column(name = "message")
   private String message;

   @Column(name = "params")
   private String params;

   @Column(name = "image")
   private String image;

   @Column(name = "url")
   private String url;

   @Column(name = "read")
   private Boolean read = false;

   @Column(name = "type")
   private String type;

   @Column(name = "created_date")
   private Timestamp createdDate;

   @Column(name = "created_by")
   private String createdBy;

   @Column(name = "modified_date")
   private Timestamp modifiedDate;

   @Column(name = "modified_by")
   private String modifiedBy;

}
