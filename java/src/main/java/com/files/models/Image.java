
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Image
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Image(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Image name
     */
    @Getter
    public String name;

    /**
     * Image URI
     */
    @Getter
    public String uri;



}


