package com.tech.backend.communication.repository.custom;

import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.request.TemplateFilterRequest;
import java.util.List;

/**
 * @author nguyen.tam.thi at 11:14 2020-10-12
 */
public interface TemplateRepositoryCustom {
  List<Template> filter(TemplateFilterRequest request);
}
