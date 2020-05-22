package com.files.exception;

public class ApiAuthenticationException extends ApiCheckedException {
    private final String apiFailureReason;

    public ApiAuthenticationException(String apiFailureReason) {
        super(apiFailureReason);
        this.apiFailureReason = apiFailureReason;
    }

    public String getAPIFailureReason() {
        return apiFailureReason;
    }

}
