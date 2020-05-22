
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class As2Key
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public As2Key(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * AS2 Key ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * AS2 Partnership Name
     */
    @Getter
    @Setter
    public String as2PartnershipName;

    /**
     * AS2 Key created at date/time
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Public key fingerprint
     */
    @Getter
    @Setter
    public String fingerprint;

    /**
     * User ID.  Provide a value of `0` to operate the current session's user.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Actual contents of Public key.
     */
    @Getter
    @Setter
    public String publicKey;

    /**
     * Parameters:
     *   as2_partnership_name (required) - string - AS2 Partnership Name
     */
    public As2Key update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public As2Key delete(HashMap<String, Object> parameters)
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
        //var newObj = As2Key.create(this.attributes, this.options);
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
    public static As2Key list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static As2Key all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - As2 Key ID.
     */
    // TODO: Use types for path_and_primary_params
    public static As2Key find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static As2Key get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   as2_partnership_name (required) - string - AS2 Partnership Name
     *   public_key (required) - string - Actual contents of Public key.
     */
    // TODO: Use types for path_and_primary_params
    public static As2Key create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("as2_partnership_name") && !(parameters.get("as2_partnership_name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: as2_partnership_name must be of type String parameters[\"as2_partnership_name\"]");
        }
        if (parameters.containsKey("public_key") && !(parameters.get("public_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: public_key must be of type String parameters[\"public_key\"]");
        }
        if (!parameters.containsKey("as2_partnership_name") || parameters.get("as2_partnership_name") == null)
        {
            throw new NullPointerException("Parameter missing: as2_partnership_name parameters[\"as2_partnership_name\"]");
        }
        if (!parameters.containsKey("public_key") || parameters.get("public_key") == null)
        {
            throw new NullPointerException("Parameter missing: public_key parameters[\"public_key\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   as2_partnership_name (required) - string - AS2 Partnership Name
     */
    // TODO: Use types for path_and_primary_params
    public static As2Key update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("as2_partnership_name") && !(parameters.get("as2_partnership_name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: as2_partnership_name must be of type String parameters[\"as2_partnership_name\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        if (!parameters.containsKey("as2_partnership_name") || parameters.get("as2_partnership_name") == null)
        {
            throw new NullPointerException("Parameter missing: as2_partnership_name parameters[\"as2_partnership_name\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static As2Key delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static As2Key destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


