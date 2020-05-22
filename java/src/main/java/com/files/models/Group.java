
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Group
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Group(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Group ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Group name
     */
    @Getter
    @Setter
    public String name;

    /**
     * List of user IDs who are group administrators (separated by commas)
     */
    @Getter
    @Setter
    public Object[] adminIds;

    /**
     * Notes about this group
     */
    @Getter
    @Setter
    public String notes;

    /**
     * List of user IDs who belong to this group (separated by commas)
     */
    @Getter
    @Setter
    public Object[] userIds;

    /**
     * List of usernames who belong to this group (separated by commas)
     */
    @Getter
    @Setter
    public Object[] usernames;

    /**
     * Parameters:
     *   name - string - Group name.
     *   notes - string - Group notes.
     *   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
     *   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
     */
    public Group update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Group delete(HashMap<String, Object> parameters)
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
        //var newObj = Group.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   ids - string - Comma-separated list of group ids to include in results.
     */
    // TODO: Use types for path_and_primary_params
    public static Group list( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

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
        if (parameters.containsKey("ids") && !(parameters.get("ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ids must be of type String parameters[\"ids\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Group all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Group ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Group find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Group get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   name - string - Group name.
     *   notes - string - Group notes.
     *   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
     *   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
     */
    // TODO: Use types for path_and_primary_params
    public static Group create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("notes") && !(parameters.get("notes") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: notes must be of type String parameters[\"notes\"]");
        }
        if (parameters.containsKey("user_ids") && !(parameters.get("user_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_ids must be of type String parameters[\"user_ids\"]");
        }
        if (parameters.containsKey("admin_ids") && !(parameters.get("admin_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: admin_ids must be of type String parameters[\"admin_ids\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   name - string - Group name.
     *   notes - string - Group notes.
     *   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
     *   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
     */
    // TODO: Use types for path_and_primary_params
    public static Group update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("notes") && !(parameters.get("notes") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: notes must be of type String parameters[\"notes\"]");
        }
        if (parameters.containsKey("user_ids") && !(parameters.get("user_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_ids must be of type String parameters[\"user_ids\"]");
        }
        if (parameters.containsKey("admin_ids") && !(parameters.get("admin_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: admin_ids must be of type String parameters[\"admin_ids\"]");
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
    public static Group delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Group destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


