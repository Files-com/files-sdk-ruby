
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Auto
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Auto(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Additional data
     */
    @Getter
    public Object dynamic;



}


