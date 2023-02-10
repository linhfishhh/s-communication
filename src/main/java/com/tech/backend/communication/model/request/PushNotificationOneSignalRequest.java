package com.tech.backend.communication.model.request;

import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

/**
 * Created by thanhtrung on 9/30/19
 */

@Getter
@Setter
public class PushNotificationOneSignalRequest {
    private String tenantId;
    private List<Long> profileIds;
    private List<String> targetIds;
    private String targetType;
    private String title;
    private String body;
    private Map<String, Object> data;
    private Boolean isSaved = true;
    private String image;
    private String url;
}
