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
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import javax.persistence.Transient;
import lombok.Data;
import org.springframework.data.annotation.Persistent;


/**
 * The persistent class for the template database table.
 */
@Entity
@Table(name = "template")
@NamedQuery(name = "Template.findAll", query = "SELECT t FROM Template t")
@Data
@EntityListeners(SEntityListener.class)
public class Template implements Serializable, SEntity {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "template_id", unique = true, nullable = false)
  private Long templateId;

  @Column(length = 50)
  private String type;

  @Column(length = 100)
  private String code;

  @Column(name = "created_by", length = 100)
  private String createdBy;

  @Column(name = "created_date", nullable = true)
  private Timestamp createdDate;

  @Column(length = 500)
  private String message;

  @Column(length = 100)
  private String encode;

  @Column(name = "from_name", length = 100)
  private String fromName;

  @Column(name = "default_param_value")
  private String defaultParamValue;

  @Column(name = "from_address", length = 100)
  private String fromAddress;

  @Column(name = "modified_by", length = 50)
  private String modifiedBy;

  @Column(name = "modified_date", nullable = true)
  private Timestamp modifiedDate;

  @Column(nullable = false, length = 20)
  private String language;

  @Column(length = 50)
  private String title;

  @Column(name = "tenant_id")
  private String tenantId;

  @Transient
  private String preview;

  @Transient
  private int smsTotal;

}
