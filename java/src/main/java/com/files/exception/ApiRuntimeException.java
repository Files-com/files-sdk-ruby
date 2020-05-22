package com.files.exception;

public class ApiRuntimeException extends RuntimeException {
    private static final long serialVersionUID = 2665759897774399981L;

    public ApiRuntimeException() {
        super();
    }

    public ApiRuntimeException(String s) {
        super(s);
    }

    public ApiRuntimeException(String s, String hb) {
        super(s);
    }

    public ApiRuntimeException(String s, Throwable hb) {
        super(s);
    }

    public ApiRuntimeException(Exception e) {
        super(e);;
    }

    public ApiRuntimeException(boolean report) {
        super();
    }
}
