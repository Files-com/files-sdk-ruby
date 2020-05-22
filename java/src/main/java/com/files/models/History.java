
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class History
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public History(HashMap<String, Object> attributes, HashMap<String, Object> options)
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



    /**
     * Parameters:
     *   start_at - string - Leave blank or set to a date/time to filter earlier entries.
     *   end_at - string - Leave blank or set to a date/time to filter later entries.
     *   display - string - Display format. Leave blank or set to `full` or `parent`.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   path (required) - string - Path to operate on.
     */
    // TODO: Use types for path_and_primary_params
    public static History listForFile(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("display") && !(parameters.get("display") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: display must be of type String parameters[\"display\"]");
        }
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
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   start_at - string - Leave blank or set to a date/time to filter earlier entries.
     *   end_at - string - Leave blank or set to a date/time to filter later entries.
     *   display - string - Display format. Leave blank or set to `full` or `parent`.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   path (required) - string - Path to operate on.
     */
    // TODO: Use types for path_and_primary_params
    public static History listForFolder(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("display") && !(parameters.get("display") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: display must be of type String parameters[\"display\"]");
        }
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
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   start_at - string - Leave blank or set to a date/time to filter earlier entries.
     *   end_at - string - Leave blank or set to a date/time to filter later entries.
     *   display - string - Display format. Leave blank or set to `full` or `parent`.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   user_id (required) - integer - User ID.
     */
    // TODO: Use types for path_and_primary_params
    public static History listForUser(Long user_id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("user_id", user_id);
        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("display") && !(parameters.get("display") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: display must be of type String parameters[\"display\"]");
        }
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
        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (!parameters.containsKey("user_id") || parameters.get("user_id") == null)
        {
            throw new NullPointerException("Parameter missing: user_id parameters[\"user_id\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   start_at - string - Leave blank or set to a date/time to filter earlier entries.
     *   end_at - string - Leave blank or set to a date/time to filter later entries.
     *   display - string - Display format. Leave blank or set to `full` or `parent`.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static History listLogins( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("display") && !(parameters.get("display") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: display must be of type String parameters[\"display\"]");
        }
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
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   start_at - string - Leave blank or set to a date/time to filter earlier entries.
     *   end_at - string - Leave blank or set to a date/time to filter later entries.
     *   display - string - Display format. Leave blank or set to `full` or `parent`.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static History list( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("display") && !(parameters.get("display") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: display must be of type String parameters[\"display\"]");
        }
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
        // TODO: Send request
        return null;
    }

    public static History all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
}


