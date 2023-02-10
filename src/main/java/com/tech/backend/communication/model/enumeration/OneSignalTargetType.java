package com.tech.backend.communication.model.enumeration;

/**
 * Created by thanhtrung on 9/30/19
 */
public enum OneSignalTargetType {

    SEGMENTS,
    EXTERNAL_USER_IDS,
    FILTER;

    public static OneSignalTargetType targetType(String type) {
        for (OneSignalTargetType targetType: values()) {
            if (targetType.toString().equalsIgnoreCase(type)) {
                return targetType;
            }
        }
        return null;
    }
}
