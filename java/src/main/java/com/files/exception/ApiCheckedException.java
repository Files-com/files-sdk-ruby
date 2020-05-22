package com.files.exception;

public class ApiCheckedException extends Exception {

    public ApiCheckedException() {
        super();
    }

    public ApiCheckedException(String s) {
        super(s);
    }

    public ApiCheckedException(Exception e) {
        super(e);
    }
}
