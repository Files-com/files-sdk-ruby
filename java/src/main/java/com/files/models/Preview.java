
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Preview
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Preview(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Preview ID
     */
    @Getter
    public Long id;

    /**
     * Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
     */
    @Getter
    public String status;

    /**
     * Link to download preview
     */
    @Getter
    public String downloadUri;

    /**
     * Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
     */
    @Getter
    public String type;

    /**
     * Preview size
     */
    @Getter
    public Long size;



}


