
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Errors
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Errors(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * A list of fields where errors occur
     */
    @Getter
    public Object[] fields;

    /**
     * A list of error messages
     */
    @Getter
    public Object[] messages;



}


