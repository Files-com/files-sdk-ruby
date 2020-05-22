
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class GroupUser
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public GroupUser(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Group name
     */
    @Getter
    @Setter
    public String name;

    /**
     * Group ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Is this user an administrator of this group?
     */
    @Getter
    @Setter
    public boolean admin;

    /**
     * A list of usernames for users in this group
     */
    @Getter
    @Setter
    public Object[] usernames;

    /**
     * Group ID to add user to.
     */
    @Getter
    @Setter
    public Long groupId;

    /**
     * User ID to add to group.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Parameters:
     *   group_id (required) - integer - Group ID to add user to.
     *   user_id (required) - integer - User ID to add to group.
     *   admin - boolean - Is the user a group administrator?
     */
    public GroupUser update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public GroupUser delete(HashMap<String, Object> parameters)
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
     *   user_id - integer - User ID.  If provided, will return groups of which this user is a member.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   group_id - integer - Group ID.  If provided, will return members of this group.
     */
    // TODO: Use types for path_and_primary_params
    public static GroupUser list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        // TODO: Send request
        return null;
    }

    public static GroupUser all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   group_id (required) - integer - Group ID to add user to.
     *   user_id (required) - integer - User ID to add to group.
     *   admin - boolean - Is the user a group administrator?
     */
    // TODO: Use types for path_and_primary_params
    public static GroupUser update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("admin") && !(parameters.get("admin") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: admin must be of type boolean parameters[\"admin\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        if (!parameters.containsKey("group_id") || parameters.get("group_id") == null)
        {
            throw new NullPointerException("Parameter missing: group_id parameters[\"group_id\"]");
        }
        if (!parameters.containsKey("user_id") || parameters.get("user_id") == null)
        {
            throw new NullPointerException("Parameter missing: user_id parameters[\"user_id\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static GroupUser delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static GroupUser destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


