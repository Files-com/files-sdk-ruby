
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Project
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Project(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Project ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Global access settings
     */
    @Getter
    @Setter
    public String globalAccess;

    /**
     * Parameters:
     *   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
     */
    public Project update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Project delete(HashMap<String, Object> parameters)
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
        //var newObj = Project.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static Project list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        // TODO: Send request
        return null;
    }

    public static Project all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Project ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Project find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Project get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
     */
    // TODO: Use types for path_and_primary_params
    public static Project create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("global_access") && !(parameters.get("global_access") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: global_access must be of type String parameters[\"global_access\"]");
        }
        if (!parameters.containsKey("global_access") || parameters.get("global_access") == null)
        {
            throw new NullPointerException("Parameter missing: global_access parameters[\"global_access\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
     */
    // TODO: Use types for path_and_primary_params
    public static Project update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("global_access") && !(parameters.get("global_access") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: global_access must be of type String parameters[\"global_access\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        if (!parameters.containsKey("global_access") || parameters.get("global_access") == null)
        {
            throw new NullPointerException("Parameter missing: global_access parameters[\"global_access\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static Project delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Project destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


