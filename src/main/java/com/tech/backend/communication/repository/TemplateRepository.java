package com.tech.backend.communication.repository;

import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.repository.custom.TemplateRepositoryCustom;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by chautn on 7/22/2017.
 */
@Repository
public interface TemplateRepository extends JpaRepository<Template, Long>, TemplateRepositoryCustom {
  List<Template> findByCodeAndType(String code, String type);

  Template findByCodeAndTypeAndLanguage(String code, String type, String language);

  Template findByTenantIdAndCodeAndTypeAndLanguage(String tenantId, String code, String type, String language);
}
