package com.files.exception;

import com.actionverb.files.ftp.FtpMessages;

public class ApiReportedRuntimeException extends RuntimeException {

    private final int apiFailureStatus;
    private final String apiFailureAction;
    private final String apiFailureReason;

    public ApiReportedRuntimeException(int status, String action) {
        this.apiFailureStatus = status;
        this.apiFailureAction = action;
        this.apiFailureReason = "";
    }

    public ApiReportedRuntimeException(int status, String action, String message) {
        this.apiFailureStatus = status;
        this.apiFailureAction = action;
        this.apiFailureReason = message;
    }

    public int apiFailureStatus() {
        return apiFailureStatus;
    }

    public String apiFailureAction() {
        return apiFailureAction;
    }

    public String apiFailureReason() {
        return apiFailureReason;
    }

    public String getMessage() {
        // TODO: Get map of message codes ported from FtpMessage
        return (new String());
    }

    public String getBrickMessage() {
        return apiFailureStatus + "." + apiFailureAction + "=" + apiFailureReason;
    }

}
