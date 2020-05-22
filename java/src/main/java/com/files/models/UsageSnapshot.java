
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class UsageSnapshot
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public UsageSnapshot(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Site usage ID
     */
    @Getter
    public Long id;

    /**
     * Site usage report start date/time
     */
    @Getter
    public LocalDateTime startAt;

    /**
     * Site usage report end date/time
     */
    @Getter
    public LocalDateTime endAt;

    /**
     * Site usage report created at date/time
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Current site usage as of report
     */
    @Getter
    public double currentStorage;

    /**
     * Site usage report highest usage in time period
     */
    @Getter
    public double highWaterStorage;

    /**
     * Number of downloads in report time period
     */
    @Getter
    public Long totalDownloads;

    /**
     * Number of uploads in time period
     */
    @Getter
    public Long totalUploads;

    /**
     * The last time this site usage report was updated
     */
    @Getter
    public LocalDateTime updatedAt;

    /**
     * A map of root folders to their total usage
     */
    @Getter
    public Object usageByTopLevelDir;

    /**
     * Usage for root folder
     */
    @Getter
    public double rootStorage;

    /**
     * Usage for files that are deleted but uploaded within last 30 days
     */
    @Getter
    public double deletedFilesCountedInMinimum;

    /**
     * Usage for files that are deleted but retained as backups
     */
    @Getter
    public double deletedFilesStorage;



    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static UsageSnapshot list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static UsageSnapshot all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
}


