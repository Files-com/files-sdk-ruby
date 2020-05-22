
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Status
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Status(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Status http code
     */
    @Getter
    public Long code;

    /**
     * Error message
     */
    @Getter
    public String message;

    /**
     * Status message
     */
    @Getter
    public String status;

    /**
       */
    @Getter
    public Object data;

    /**
     * A list of api errors
     */
    @Getter
    public Object[] errors;



}


