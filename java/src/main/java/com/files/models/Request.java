
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Request
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Request(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Request ID
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
     * Source filename, if applicable
     */
    @Getter
    @Setter
    public String source;

    /**
     * Destination filename
     */
    @Getter
    @Setter
    public String destination;

    /**
     * ID of automation that created request
     */
    @Getter
    @Setter
    public String automationId;

    /**
     * User making the request (if applicable)
     */
    @Getter
    @Setter
    public String userDisplayName;

    /**
     * A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
     */
    @Getter
    @Setter
    public String userIds;

    /**
     * A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
     */
    @Getter
    @Setter
    public String groupIds;

    /**
     * List Requests
     *
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
     */
    public Request folders(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }


    public void save()
    {
        if (this.attributes.get("path") != null)
        {
        throw new UnsupportedOperationException("The Request Object doesn't support updates.");
        }
        else
        {
        //var newObj = Request.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
     *   path - string - Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
     */
    // TODO: Use types for path_and_primary_params
    public static Request list(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("mine") && !(parameters.get("mine") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: mine must be of type boolean parameters[\"mine\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Request all(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(path, parameters, options);
    }
    /**
     * List Requests
     *
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
     */
    // TODO: Use types for path_and_primary_params
    public static Request folders(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("mine") && !(parameters.get("mine") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: mine must be of type boolean parameters[\"mine\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   path (required) - string - Folder path on which to request the file.
     *   destination (required) - string - Destination filename (without extension) to request.
     *   user_ids - string - A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
     *   group_ids - string - A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
     */
    // TODO: Use types for path_and_primary_params
    public static Request create(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("destination") && !(parameters.get("destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination must be of type String parameters[\"destination\"]");
        }
        if (parameters.containsKey("user_ids") && !(parameters.get("user_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_ids must be of type String parameters[\"user_ids\"]");
        }
        if (parameters.containsKey("group_ids") && !(parameters.get("group_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_ids must be of type String parameters[\"group_ids\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("destination") || parameters.get("destination") == null)
        {
            throw new NullPointerException("Parameter missing: destination parameters[\"destination\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   id (required) - integer - Request ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Request delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Request destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


