package com.tech.backend.communication.model.entity.listener;

import com.tech.backend.communication.config.oauth2.SUserDetails;
import java.sql.Timestamp;
import java.util.Calendar;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Author: chautn on 6/11/2018 11:41 AM
 */
public class SEntityListener {

  @PrePersist
  public void onCreate(SEntity entity) {
    entity.setCreatedBy(getActorId());
    entity.setCreatedDate(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    entity.setModifiedBy(getActorId());
    entity.setModifiedDate(new Timestamp(Calendar.getInstance().getTimeInMillis()));
  }

  @PreUpdate
  public void onUpdate(SEntity entity) {
    entity.setModifiedBy(getActorId());
    entity.setModifiedDate(new Timestamp(Calendar.getInstance().getTimeInMillis()));
  }

  private String getActorId() {
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    if (auth != null && auth.getPrincipal() != null && auth.getPrincipal() instanceof SUserDetails) {
      return ((SUserDetails) auth.getPrincipal()).getName();
    } else {
      return "ANONYMOUS";
    }
  }
}
