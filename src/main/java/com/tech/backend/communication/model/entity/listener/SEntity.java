package com.tech.backend.communication.model.entity.listener;

import java.sql.Timestamp;

/**
 * Author: chautn on 6/11/2018 11:42 AM
 */
public interface SEntity {

  void setModifiedDate(Timestamp modifiedDate);

  void setModifiedBy(String modifiedBy);

  void setCreatedBy(String createdBy);

  void setCreatedDate(Timestamp createdDate);
}
