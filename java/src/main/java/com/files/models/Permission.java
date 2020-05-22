
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Permission
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Permission(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Permission ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * User ID
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * User's username
     */
    @Getter
    @Setter
    public String username;

    /**
     * Group ID
     */
    @Getter
    @Setter
    public Long groupId;

    /**
     * Group name if applicable
     */
    @Getter
    @Setter
    public String groupName;

    /**
     * Permission type
     */
    @Getter
    @Setter
    public String permission;

    /**
     * Does this permission apply to subfolders?
     */
    @Getter
    @Setter
    public boolean recursive;


    public void save()
    {
        if (this.attributes.get("path") != null)
        {
        throw new UnsupportedOperationException("The Permission Object doesn't support updates.");
        }
        else
        {
        //var newObj = Permission.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   path - string - Permission path.  If provided, will scope permissions to this path.
     *   group_id - string - Group ID.  If provided, will scope permissions to this group.
     *   user_id - string - User ID.  If provided, will scope permissions to this user.
     *   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?
     */
    // TODO: Use types for path_and_primary_params
    public static Permission list(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
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
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type String parameters[\"group_id\"]");
        }
        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type String parameters[\"user_id\"]");
        }
        if (parameters.containsKey("include_groups") && !(parameters.get("include_groups") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: include_groups must be of type boolean parameters[\"include_groups\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Permission all(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(path, parameters, options);
    }
    /**
     * Parameters:
     *   group_id - integer - Group ID
     *   path - string - Folder path
     *   permission - string -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
     *   recursive - boolean - Apply to subfolders recursively?
     *   user_id - integer - User ID.  Provide `username` or `user_id`
     *   username - string - User username.  Provide `username` or `user_id`
     */
    // TODO: Use types for path_and_primary_params
    public static Permission create(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("permission") && !(parameters.get("permission") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: permission must be of type String parameters[\"permission\"]");
        }
        if (parameters.containsKey("recursive") && !(parameters.get("recursive") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: recursive must be of type boolean parameters[\"recursive\"]");
        }
        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   id (required) - integer - Permission ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Permission delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Permission destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


