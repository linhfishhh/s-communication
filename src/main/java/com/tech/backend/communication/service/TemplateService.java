package com.tech.backend.communication.service;

import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.response.TemplateDTO;
import java.util.List;
import java.util.Map;

/**
 * Created by chautn on 7/22/2017.
 */
public interface TemplateService {

  List<Template> getTemplateByCodeAndType(String code, String type);

  Template getTemplateByCodeAndTypeAndLanguage(String code, String type, SupportedLanguage language);

  Template getTemplateByTenantIdAndCodeAndTypeAndLanguage(String tenantId, String code, String type, SupportedLanguage language);

  TemplateDTO getPreviewTemplateByTenantIdAndCodeAndTypeAndLanguage(String tenantId, String code, String type, SupportedLanguage language, Map<String, Object> params);
}
