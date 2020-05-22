package com.files.exception;


import com.actionverb.files.util.HBClient;
import com.google.common.collect.ImmutableMap;

import java.util.Map;

public class ApiErrorException extends Exception {
    private final int code;
    private final String message;

    public ApiErrorException(int code, String message) {
        this.code = code;
        this.message = message;

        if (this.code < 400 || this.code >= 500) {
            HBClient.getInstance().reportError(this, this.getHashMap());
        }
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public String toString() {
        return "[" + code + "] " + message;
    }

    public Map<String, String> getHashMap() {
        return ImmutableMap.of("code", String.valueOf(code), "message", message);
    }

}
