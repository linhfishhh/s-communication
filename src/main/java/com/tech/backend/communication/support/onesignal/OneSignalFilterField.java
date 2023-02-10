package com.tech.backend.communication.support.onesignal;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by thanhtrung on 11/20/19
 */
@Getter
@Setter
public class OneSignalFilterField implements OneSignalFilter {

    @SerializedName("field")
    private String field;

    @SerializedName("key")
    private String key;

    @SerializedName("relation")
    private String relation;

    @SerializedName("value")
    private String value;

    public static OneSignalFilterField createFilterFieldForTagUserId(String userId) {
        OneSignalFilterField filterField = new OneSignalFilterField();
        filterField.setField("tag");
        filterField.setKey("user_id"); // map to isalon's tag
        filterField.setRelation("=");
        filterField.setValue(userId);
        return filterField;
    }
}
