
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class FilePartUpload
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public FilePartUpload(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Content-Type and File to send
     */
    @Getter
    public Object send;

    /**
     * Type of upload
     */
    @Getter
    public String action;

    /**
     * If false, rename conflicting files instead of asking for overwrite confirmation
     */
    @Getter
    public boolean askAboutOverwrites;

    /**
     * Currently unused
     */
    @Getter
    public String availableParts;

    /**
     * Currently unused
     */
    @Getter
    public String expires;

    /**
     * Additional upload headers
     */
    @Getter
    public Object headers;

    /**
     * Upload method, usually POST
     */
    @Getter
    public String httpMethod;

    /**
     * Currently unused
     */
    @Getter
    public String nextPartsize;

    /**
     * Additional upload parameters
     */
    @Getter
    public String parameters;

    /**
     * Currently unused
     */
    @Getter
    public String partNumber;

    /**
     * Currently unused
     */
    @Getter
    public String partsize;

    /**
     * Upload path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    public String path;

    /**
     * Reference name for this upload part
     */
    @Getter
    public String ref;

    /**
     * URI to upload this part to
     */
    @Getter
    public String uploadUri;



}


