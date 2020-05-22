
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Bundle
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Bundle(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Bundle ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Bundle code.  This code forms the end part of the Public URL.
     */
    @Getter
    @Setter
    public String code;

    /**
     * Bundle created at date/time
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Public description
     */
    @Getter
    @Setter
    public String description;

    /**
     * Bundle expiration date/time
     */
    @Getter
    @Setter
    public LocalDateTime expiresAt;

    /**
     * A list of paths in this bundle
     */
    @Getter
    @Setter
    public Object[] paths;

    /**
     * Bundle internal note
     */
    @Getter
    @Setter
    public String note;

    /**
     * Is this bundle password protected?
     */
    @Getter
    @Setter
    public boolean passwordProtected;

    /**
     * Public URL of Share Link
     */
    @Getter
    @Setter
    public String url;

    /**
     * Bundle creator user ID
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Bundle creator username
     */
    @Getter
    @Setter
    public String username;

    /**
     * Password for this bundle.
     */
    @Getter
    @Setter
    public String password;

    /**
     * Send email(s) with a link to bundle
     *
     * Parameters:
     *   to (required) - array - A list of email addresses to share this bundle with.
     *   note - string - Note to include in email.
     */
    public Bundle share(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Bundle delete(HashMap<String, Object> parameters)
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
        throw new UnsupportedOperationException("The Bundle Object doesn't support updates.");
        }
        else
        {
        //var newObj = Bundle.create(this.attributes, this.options);
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
    public static Bundle list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Bundle all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Bundle ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Bundle find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Bundle get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   paths (required) - array - A list of paths to include in this bundle.
     *   password - string - Password for this bundle.
     *   expires_at - string - Bundle expiration date/time.
     *   description - string - Bundle public description
     *   note - string - Bundle internal note
     *   code - string - Bundle name
     */
    // TODO: Use types for path_and_primary_params
    public static Bundle create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("paths") && !(parameters.get("paths") instanceof String[] ))
        {
            throw new IllegalArgumentException("Bad parameter: paths must be of type String[] parameters[\"paths\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("expires_at") && !(parameters.get("expires_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: expires_at must be of type String parameters[\"expires_at\"]");
        }
        if (parameters.containsKey("description") && !(parameters.get("description") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: description must be of type String parameters[\"description\"]");
        }
        if (parameters.containsKey("note") && !(parameters.get("note") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: note must be of type String parameters[\"note\"]");
        }
        if (parameters.containsKey("code") && !(parameters.get("code") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: code must be of type String parameters[\"code\"]");
        }
        if (!parameters.containsKey("paths") || parameters.get("paths") == null)
        {
            throw new NullPointerException("Parameter missing: paths parameters[\"paths\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Send email(s) with a link to bundle
     *
     * Parameters:
     *   to (required) - array - A list of email addresses to share this bundle with.
     *   note - string - Note to include in email.
     */
    // TODO: Use types for path_and_primary_params
    public static Bundle share(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("to") && !(parameters.get("to") instanceof String[] ))
        {
            throw new IllegalArgumentException("Bad parameter: to must be of type String[] parameters[\"to\"]");
        }
        if (parameters.containsKey("note") && !(parameters.get("note") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: note must be of type String parameters[\"note\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        if (!parameters.containsKey("to") || parameters.get("to") == null)
        {
            throw new NullPointerException("Parameter missing: to parameters[\"to\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static Bundle delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Bundle destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


