package com.tech.backend.communication.support.onesignal;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

/**
 * Created by thanhtrung on 9/30/19
 */
@Getter
@Setter
public class OneSignalNotification {

    @SerializedName("app_id")
    private String appId;

    @SerializedName("included_segments")
    private List<String> includedSegments;

    @SerializedName("include_external_user_ids")
    private List<String> includedExternalIds;

    @SerializedName("filters")
    private List<OneSignalFilter> filters;

    @SerializedName("headings")
    private Map<String, String> titles;

    @SerializedName("contents")
    private Map<String, String> contents;

    @SerializedName("data")
    private Object data;
}
