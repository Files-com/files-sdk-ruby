package com.files.exception;

public class ApiForbiddenException extends ApiCheckedException {

    private final String apiFailureReason;

    public ApiForbiddenException(String apiFailureReason) {
        super(apiFailureReason);
        this.apiFailureReason = apiFailureReason;
    }

    public String getAPIFailureReason() {
        return apiFailureReason;
    }

}
