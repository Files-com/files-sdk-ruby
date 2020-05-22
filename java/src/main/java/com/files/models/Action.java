
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Action
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Action(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Action ID
     */
    @Getter
    public Long id;

    /**
     * Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    public String path;

    /**
     * Action occurrence date/time
     */
    @Getter
    public LocalDateTime when;

    /**
     * The destination path for this action, if applicable
     */
    @Getter
    public String destination;

    /**
     * Friendly displayed output
     */
    @Getter
    public String display;

    /**
     * IP Address that performed this action
     */
    @Getter
    public String ip;

    /**
     * The source path for this action, if applicable
     */
    @Getter
    public String source;

    /**
     * Targets
     */
    @Getter
    public Object[] targets;

    /**
     * User ID
     */
    @Getter
    public Long userId;

    /**
     * Username
     */
    @Getter
    public String username;

    /**
     * Type of action
     */
    @Getter
    public String action;

    /**
     * Failure type.  If action was a user login or session failure, why did it fail?
     */
    @Getter
    public String failureType;

    /**
     * Interface on which this action occurred.
     */
    @Getter
    public String interfaceName;



}


