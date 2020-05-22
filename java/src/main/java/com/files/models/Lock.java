
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Lock
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Lock(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * Lock timeout
     */
    @Getter
    @Setter
    public Long timeout;

    /**
     * Lock depth (0 or infinity)
     */
    @Getter
    @Setter
    public String depth;

    /**
     * Owner of lock.  This can be any arbitrary string.
     */
    @Getter
    @Setter
    public String owner;

    /**
     * Lock scope(shared or exclusive)
     */
    @Getter
    @Setter
    public String scope;

    /**
     * Lock token.  Use to release lock.
     */
    @Getter
    @Setter
    public String token;

    /**
     * Lock type
     */
    @Getter
    @Setter
    public String type;

    /**
     * Lock creator user ID
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Lock creator username
     */
    @Getter
    @Setter
    public String username;

    /**
     * Parameters:
     *   token (required) - string - Lock token
     */
    public Lock delete(HashMap<String, Object> parameters)
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
        if (this.attributes.get("path") != null)
        {
        throw new UnsupportedOperationException("The Lock Object doesn't support updates.");
        }
        else
        {
        //var newObj = Lock.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   path (required) - string - Path to operate on.
     *   include_children - boolean - Include locks from children objects?
     */
    // TODO: Use types for path_and_primary_params
    public static Lock listFor(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("page") && !(parameters.get("page") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: page must be of type Long parameters[\"page\"]");
        }
        if (parameters.containsKey("per_page") && !(parameters.get("per_page") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: per_page must be of type Long parameters[\"per_page\"]");
        }
        if (parameters.containsKey("action") && !(parameters.get("action") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: action must be of type String parameters[\"action\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("include_children") && !(parameters.get("include_children") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: include_children must be of type boolean parameters[\"include_children\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   path (required) - string - Path
     *   timeout - integer - Lock timeout length
     */
    // TODO: Use types for path_and_primary_params
    public static Lock create(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("timeout") && !(parameters.get("timeout") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: timeout must be of type Long parameters[\"timeout\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   token (required) - string - Lock token
     */
    // TODO: Use types for path_and_primary_params
    public static Lock delete(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("token") && !(parameters.get("token") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: token must be of type String parameters[\"token\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("token") || parameters.get("token") == null)
        {
            throw new NullPointerException("Parameter missing: token parameters[\"token\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Lock destroy(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(path, parameters, options);
    }
}


