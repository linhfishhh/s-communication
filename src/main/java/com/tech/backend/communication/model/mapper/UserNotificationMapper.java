package com.tech.backend.communication.model.mapper;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tech.backend.communication.model.entity.UserNotification;
import com.tech.backend.communication.model.response.UserNotificationDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;
import org.springframework.data.domain.Page;

import java.lang.reflect.Type;
import java.util.Map;

/**
 * @author nguyen.tam.thi at 14:46 2020-04-21
 */
@Mapper(uses = CommonMapper.class)
public interface UserNotificationMapper {
    UserNotificationMapper INSTANCE = Mappers.getMapper(UserNotificationMapper.class);

    @Mappings({
            @Mapping(source = "title", target = "title"),
            @Mapping(source = "message", target = "message"),
            @Mapping(source = "params", target = "params", qualifiedByName = "convertParamsToMap"),
            @Mapping(source = "createdDate", target = "createdDate"),
            @Mapping(source = "read", target = "read"),
            @Mapping(source = "userNotificationId", target = "userNotificationId"),
            @Mapping(source = "image", target = "image"),
            @Mapping(source = "url", target = "url"),
    })
    UserNotificationDto toDto(UserNotification userNotification);
    default Page<UserNotificationDto> toDtos(Page<UserNotification> userNotifications) {
        return userNotifications.map(notification -> toDto(notification));
    }

    static Map<String, Object> convertParamsToMap(String params) {
        Type type = new TypeToken<Map<String, Object>>() {}.getType();
        return new Gson().fromJson(params, type);
    }
}
