package com.tech.backend.communication.repository.custom.impl;

import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.request.TemplateFilterRequest;
import com.tech.backend.communication.repository.BaseRepository;
import com.tech.backend.communication.repository.custom.TemplateRepositoryCustom;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
import org.apache.commons.lang.StringUtils;

/**
 * @author nguyen.tam.thi at 11:16 2020-10-12
 */
public class TemplateRepositoryCustomImpl extends BaseRepository implements TemplateRepositoryCustom {

  @Override
  public List<Template> filter(TemplateFilterRequest request) {
    Query query = createFilterQuery(request);
    return (List<Template>) query.getResultList();
  }

  private Query createFilterQuery(TemplateFilterRequest request) {
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT t ");
    sql.append("FROM Template t ");
    List<String> whereQuery = new ArrayList<>();
    if (StringUtils.isNotEmpty(request.getTenantId())) {
      whereQuery.add("t.tenantId = :tenantId ");
    }
    if (StringUtils.isNotEmpty(request.getLanguage())) {
      whereQuery.add("t.language = :language ");
    }
    if (StringUtils.isNotEmpty(request.getTemplateCode())) {
      whereQuery.add("t.code = :code ");
    }
    if (StringUtils.isNotEmpty(request.getType())) {
      whereQuery.add("t.type = :type ");
    }
    if (!whereQuery.isEmpty()) {
      sql.append("where ");
      sql.append(String.join("and ", whereQuery));
    }

    Query query = entityManager.createQuery(sql.toString());
    if (StringUtils.isNotEmpty(request.getTenantId())) {
      query.setParameter("tenantId", request.getTenantId());
    }
    if (StringUtils.isNotEmpty(request.getLanguage())) {
      query.setParameter("language", request.getLanguage());
    }
    if (StringUtils.isNotEmpty(request.getTemplateCode())) {
      query.setParameter("code", request.getTemplateCode());
    }
    if (StringUtils.isNotEmpty(request.getType())) {
      query.setParameter("type", request.getType());
    }
    return query;
  }
}
