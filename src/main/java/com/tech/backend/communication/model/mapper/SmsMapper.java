package com.tech.backend.communication.model.mapper;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tech.backend.communication.model.entity.Sms;
import com.tech.backend.communication.model.response.SmsDto;
import java.lang.reflect.Type;
import java.util.Map;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
import org.springframework.data.domain.Page;

/**
 * @author nguyen.tam.thi at 11:03 2020-10-12
 */

@Mapper(uses = CommonMapper.class)
public interface SmsMapper {
  SmsMapper INSTANCE = Mappers.getMapper(SmsMapper.class);

  SmsDto toDto(Sms sms);

  default Page<SmsDto> toDtos(Page<Sms> sms) {
    return sms.map(this::toDto);
  }

  default Map<String, Object> convertParamsToMap(String params) {
    Type type = new TypeToken<Map<String, Object>>() {}.getType();
    return new Gson().fromJson(params, type);
  }
  default String covertParamsToString(Map<String, Object> params) {
    Type type = new TypeToken<Map<String, Object>>() {}.getType();
    return new Gson().toJson(params);
  }
}
