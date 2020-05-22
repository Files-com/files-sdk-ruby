
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class UserCipherUse
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public UserCipherUse(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * UserCipherUse ID
     */
    @Getter
    public Long id;

    /**
     * The protocol and cipher employed
     */
    @Getter
    public String protocolCipher;

    /**
     * The earliest recorded use of this combination of interface and protocol and cipher (for this user)
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * The interface accessed
     */
    @Getter
    public String interfaceName;

    /**
     * The most recent use of this combination of interface and protocol and cipher (for this user)
     */
    @Getter
    public LocalDateTime updatedAt;

    /**
     * ID of the user who performed this access
     */
    @Getter
    public Long userId;



    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static UserCipherUse list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static UserCipherUse all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
}


