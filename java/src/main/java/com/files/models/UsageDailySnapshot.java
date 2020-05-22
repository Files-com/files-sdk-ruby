
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class UsageDailySnapshot
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public UsageDailySnapshot(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * ID of the usage record
     */
    @Getter
    public Long id;

    /**
     * The date of this usage record
     */
    @Getter
    public LocalDate date;

    /**
     * The quantity of storage held for this site
     */
    @Getter
    public Long currentStorage;

    /**
     * Usage broken down by each top-level folder
     */
    @Getter
    public Object[] usageByTopLevelDir;



    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static UsageDailySnapshot list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static UsageDailySnapshot all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
}


