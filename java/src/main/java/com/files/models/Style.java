
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Style
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Style(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Style ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * Logo
     */
    @Getter
    @Setter
    public Object logo;

    /**
     * Logo thumbnail
     */
    @Getter
    @Setter
    public Object thumbnail;

    /**
     * Logo for custom branding.
     */
    @Getter
    @Setter
    public byte[] file;

    /**
     * Parameters:
     *   file (required) - file - Logo for custom branding.
     */
    public Style update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Style delete(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    public void destroy(HashMap<String, Object> parameters)
    {
        delete(parameters);
    }

    public void save()
    {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              pdate(this.attributes);
    }


    /**
     * Parameters:
     *   path (required) - string - Style path.
     */
    // TODO: Use types for path_and_primary_params
    public static Style list(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Style all(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(path, parameters, options);
    }
    /**
     * Parameters:
     *   file (required) - file - Logo for custom branding.
     */
    // TODO: Use types for path_and_primary_params
    public static Style update(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("file") && !(parameters.get("file") instanceof byte[] ))
        {
            throw new IllegalArgumentException("Bad parameter: file must be of type byte[] parameters[\"file\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("file") || parameters.get("file") == null)
        {
            throw new NullPointerException("Parameter missing: file parameters[\"file\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static Style delete(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Style destroy(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(path, parameters, options);
    }
}


