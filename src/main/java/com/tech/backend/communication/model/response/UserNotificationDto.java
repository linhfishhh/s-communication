package com.tech.backend.communication.model.response;

import lombok.Data;

import java.util.Map;

/**
 * @author nguyen.tam.thi at 14:47 2020-04-21
 */
@Data
public class UserNotificationDto {
    private Long userNotificationId;
    private String title;
    private String message;
    private Map<String, Object> params;
    private Long createdDate;
    private Boolean read;
    private String image;
    private String url;
    private String type;
}
