package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.Email;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by chautn on 8/11/2017.
 */
@Repository
public interface EmailRepository extends JpaRepository<Email, Long> {
}
