
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Automation
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Automation(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Automation ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Automation type
     */
    @Getter
    @Setter
    public String automation;

    /**
     * Source Path
     */
    @Getter
    @Setter
    public String source;

    /**
     * Destination Path
     */
    @Getter
    @Setter
    public String destination;

    /**
     * If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
     */
    @Getter
    @Setter
    public String destinationReplaceFrom;

    /**
     * If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
     */
    @Getter
    @Setter
    public String destinationReplaceTo;

    /**
     * How often to run this automation?  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
     */
    @Getter
    @Setter
    public String interval;

    /**
     * Date this automation will next run.
     */
    @Getter
    @Setter
    public String nextProcessOn;

    /**
     * Path on which this Automation runs.  Supports globs. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * Does this automation run in real time?  This is a read-only property based on automation type.
     */
    @Getter
    @Setter
    public boolean realtime;

    /**
     * User ID of the Automation's creator.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * IDs of Users for the Automation (i.e. who to Request File from)
     */
    @Getter
    @Setter
    public Object[] userIds;

    /**
     * IDs of Groups for the Automation (i.e. who to Request File from)
     */
    @Getter
    @Setter
    public Object[] groupIds;

    /**
     * Parameters:
     *   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
     *   source - string - Source Path
     *   destination - string - Destination Path
     *   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
     *   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
     *   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
     *   path - string - Path on which this Automation runs.  Supports globs.
     *   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     *   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     */
    public Automation update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Automation delete(HashMap<String, Object> parameters)
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
        //var newObj = Automation.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   automation - string - Type of automation to filter by.
     */
    // TODO: Use types for path_and_primary_params
    public static Automation list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("automation") && !(parameters.get("automation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: automation must be of type String parameters[\"automation\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Automation all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Automation ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Automation find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Automation get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
     *   source - string - Source Path
     *   destination - string - Destination Path
     *   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
     *   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
     *   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
     *   path - string - Path on which this Automation runs.  Supports globs.
     *   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     *   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     */
    // TODO: Use types for path_and_primary_params
    public static Automation create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("automation") && !(parameters.get("automation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: automation must be of type String parameters[\"automation\"]");
        }
        if (parameters.containsKey("source") && !(parameters.get("source") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: source must be of type String parameters[\"source\"]");
        }
        if (parameters.containsKey("destination") && !(parameters.get("destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination must be of type String parameters[\"destination\"]");
        }
        if (parameters.containsKey("destination_replace_from") && !(parameters.get("destination_replace_from") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination_replace_from must be of type String parameters[\"destination_replace_from\"]");
        }
        if (parameters.containsKey("destination_replace_to") && !(parameters.get("destination_replace_to") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination_replace_to must be of type String parameters[\"destination_replace_to\"]");
        }
        if (parameters.containsKey("interval") && !(parameters.get("interval") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: interval must be of type String parameters[\"interval\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("user_ids") && !(parameters.get("user_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_ids must be of type String parameters[\"user_ids\"]");
        }
        if (parameters.containsKey("group_ids") && !(parameters.get("group_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_ids must be of type String parameters[\"group_ids\"]");
        }
        if (!parameters.containsKey("automation") || parameters.get("automation") == null)
        {
            throw new NullPointerException("Parameter missing: automation parameters[\"automation\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
     *   source - string - Source Path
     *   destination - string - Destination Path
     *   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
     *   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
     *   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
     *   path - string - Path on which this Automation runs.  Supports globs.
     *   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     *   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
     */
    // TODO: Use types for path_and_primary_params
    public static Automation update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("automation") && !(parameters.get("automation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: automation must be of type String parameters[\"automation\"]");
        }
        if (parameters.containsKey("source") && !(parameters.get("source") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: source must be of type String parameters[\"source\"]");
        }
        if (parameters.containsKey("destination") && !(parameters.get("destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination must be of type String parameters[\"destination\"]");
        }
        if (parameters.containsKey("destination_replace_from") && !(parameters.get("destination_replace_from") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination_replace_from must be of type String parameters[\"destination_replace_from\"]");
        }
        if (parameters.containsKey("destination_replace_to") && !(parameters.get("destination_replace_to") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination_replace_to must be of type String parameters[\"destination_replace_to\"]");
        }
        if (parameters.containsKey("interval") && !(parameters.get("interval") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: interval must be of type String parameters[\"interval\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("user_ids") && !(parameters.get("user_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_ids must be of type String parameters[\"user_ids\"]");
        }
        if (parameters.containsKey("group_ids") && !(parameters.get("group_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_ids must be of type String parameters[\"group_ids\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        if (!parameters.containsKey("automation") || parameters.get("automation") == null)
        {
            throw new NullPointerException("Parameter missing: automation parameters[\"automation\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static Automation delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Automation destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


