package com.tech.backend.communication.support.onesignal;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by thanhtrung on 11/20/19
 */
@Getter
@Setter
public class OneSignalFilterOperator implements OneSignalFilter {

    @SerializedName("operator")
    private OneSignalOperatorType operator;

    public static OneSignalFilterOperator operatorOR() {
        OneSignalFilterOperator operator = new OneSignalFilterOperator();
        operator.setOperator(OneSignalOperatorType.OR);
        return operator;
    }
}
