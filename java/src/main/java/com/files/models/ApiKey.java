
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class ApiKey
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public ApiKey(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * API Key ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Unique label that describes this API key.  Useful for external systems where you may have API keys from multiple accounts and want a human-readable label for each key.
     */
    @Getter
    @Setter
    public String descriptiveLabel;

    /**
     * Time which API Key was created
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * API Key expiration date
     */
    @Getter
    @Setter
    public LocalDateTime expiresAt;

    /**
     * API Key actual key string
     */
    @Getter
    @Setter
    public String key;

    /**
     * API Key last used - note this value is only updated once per 3 hour period, so the 'actual' time of last use may be up to 3 hours later than this timestamp.
     */
    @Getter
    @Setter
    public LocalDateTime lastUseAt;

    /**
     * Internal name for the API Key.  For your use.
     */
    @Getter
    @Setter
    public String name;

    /**
     * Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations.)  We hope to offer additional permission sets in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
     */
    @Getter
    @Setter
    public String permissionSet;

    /**
     * If this API key represents a Desktop app, what platform was it created on?
     */
    @Getter
    @Setter
    public String platform;

    /**
     * User ID for the owner of this API Key.  May be blank for Site-wide API Keys.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Parameters:
     *   name - string - Internal name for key.  For your reference only.
     *   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
     *   expires_at - string - Have the key expire at this date/time.
     */
    public ApiKey update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public ApiKey delete(HashMap<String, Object> parameters)
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
        if (this.attributes.get("id") != null)
        {
        update(this.attributes);
        }
        else
        {
        //var newObj = ApiKey.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey list( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
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

    public static ApiKey all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey findCurrent( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   id (required) - integer - Api Key ID.
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static ApiKey get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   name - string - Internal name for key.  For your reference only.
     *   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
     *   expires_at - string - Have the key expire at this date/time.
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("permission_set") && !(parameters.get("permission_set") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: permission_set must be of type String parameters[\"permission_set\"]");
        }
        if (parameters.containsKey("expires_at") && !(parameters.get("expires_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: expires_at must be of type String parameters[\"expires_at\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   name - string - Internal name for key.  For your reference only.
     *   permission_set - string - Leave blank, or set to `desktop_app` to restrict the key to only desktop app functions.
     *   expires_at - string - Have the key expire at this date/time.
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey updateCurrent( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("permission_set") && !(parameters.get("permission_set") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: permission_set must be of type String parameters[\"permission_set\"]");
        }
        if (parameters.containsKey("expires_at") && !(parameters.get("expires_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: expires_at must be of type String parameters[\"expires_at\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   name - string - Internal name for key.  For your reference only.
     *   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
     *   expires_at - string - Have the key expire at this date/time.
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("permission_set") && !(parameters.get("permission_set") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: permission_set must be of type String parameters[\"permission_set\"]");
        }
        if (parameters.containsKey("expires_at") && !(parameters.get("expires_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: expires_at must be of type String parameters[\"expires_at\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey deleteCurrent( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static ApiKey delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static ApiKey destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


