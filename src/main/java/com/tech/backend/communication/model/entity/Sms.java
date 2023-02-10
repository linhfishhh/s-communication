package com.tech.backend.communication.model.entity;

import com.tech.backend.communication.model.entity.listener.SEntity;
import com.tech.backend.communication.model.entity.listener.SEntityListener;
import com.tech.backend.communication.model.enumeration.BrandNameAccountMode;
import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
* @author nguyen.tam.thi at 10:42 2020-10-12
*/
@Entity
@Getter @Setter
@Table(name = "sms")
@EntityListeners(SEntityListener.class)
public class Sms implements Serializable, SEntity {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private Long id;

   @Column(name = "profile_id")
   private Long profileId;

   @Column(name = "tenant_id")
   private String tenantId;

   @Column(name = "template_id")
   private Long templateId;

   @Column(name = "content_params")
   private String contentParams;

   @Column(name = "delivery_time")
   private Timestamp deliveryTime;

   @Column(name = "phone_number")
   private String phoneNumber;

   @Column(name = "custom_content")
   private String customContent;

   @Column(name = "status")
   private String status;

   @Column(name = "result")
   private String result;

   @Column(name = "provider_id")
   private Long providerId;

   @Column(name = "brand_name")
   private String brandName;

   @Enumerated(EnumType.STRING)
   @Column(name = "brand_name_account_mode")
   private BrandNameAccountMode brandNameAccountMode;

   @Column(name = "modified_date")
   private Timestamp modifiedDate;

   @Column(name = "created_date")
   private Timestamp createdDate;

   @Column(name = "modified_by")
   private String modifiedBy;

   @Column(name = "created_by")
   private String createdBy;

   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "template_id", referencedColumnName = "template_id", insertable = false, updatable = false)
   private Template template;
}
