package com.tech.backend.communication.model.mapper;

import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.response.TemplateDTO;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author chuanlh on 2020-12-10
 */
@Mapper(uses = CommonMapper.class)
public interface TemplateMapper {

  TemplateMapper INSTANCE = Mappers.getMapper(TemplateMapper.class);

  TemplateDTO toEmailTemplateDto(Template template);

  List<TemplateDTO> toEmailTemplateDtos(List<Template> templates);
}
