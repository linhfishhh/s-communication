package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.Sms;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author nguyen.tam.thi at 11:02 2020-10-12
 */
public interface SmsRepository extends JpaRepository<Sms, Long> {
  Sms findFirstById(Long smsId);
}
