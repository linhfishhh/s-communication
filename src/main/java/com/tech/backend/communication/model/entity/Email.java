package com.tech.backend.communication.model.entity;

import com.tech.backend.communication.model.entity.listener.SEntity;
import com.tech.backend.communication.model.entity.listener.SEntityListener;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

/**
 * Created by chautn on 8/11/2017.
 */
@Entity
@Table(name = "email")
@NamedQuery(name = "Email.findAll", query = "SELECT e FROM Email e")
@Getter
@Setter
@EntityListeners(SEntityListener.class)
public class Email implements Serializable, SEntity {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY, generator = "emailIdSeq")
  @SequenceGenerator(name = "emailIdSeq", sequenceName = "email_id_seq", allocationSize = 1)
  @Column(name = "email_id", unique = true, nullable = false)
  private Long emailId;

  @Column(name = "profile_id")
  private Long profileId;

  @Column(name = "profile_type", length = 50)
  private String profileType;

  @Column(name = "email", length = 500)
  private String email;

  @Column(name = "status", length = 50)
  private String status;

  @Column(name = "result", length = 1000)
  private String result;

  @Column(name = "delivery_time")
  private Timestamp deliveryTime;

  @Column(name = "cc", length = 500)
  private String cc;

  @Column(name = "bcc", length = 500)
  private String bcc;

  @Column(name = "from_name", length = 100)
  private String fromName;

  @Column(name = "tenant_id", length = 100)
  private String tenantId;

  @Column(name = "reply_to", length = 100)
  private String replyTo;

  //bi-directional many-to-one association to MUser
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "template_id", referencedColumnName = "template_id")
  private Template template;

  @Column(name = "content_params", length = 500)
  private String contentParams;

  @Column(name = "created_by", length = 100)
  private String createdBy = "SYSTEM";

  @Column(name = "created_date", nullable = true)
  private Timestamp createdDate = new Timestamp(Calendar.getInstance().getTimeInMillis());

  @Column(name = "modified_by", length = 50)
  private String modifiedBy = "SYSTEM";

  @Column(name = "modified_date", nullable = true)
  private Timestamp modifiedDate = new Timestamp(Calendar.getInstance().getTimeInMillis());
}
