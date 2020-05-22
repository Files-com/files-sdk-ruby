
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class HistoryExport
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public HistoryExport(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * History Export ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Start date/time of export range.
     */
    @Getter
    @Setter
    public LocalDateTime startAt;

    /**
     * End date/time of export range.
     */
    @Getter
    @Setter
    public LocalDateTime endAt;

    /**
     * Status of export.  Will be: `building` or `ready`
     */
    @Getter
    @Setter
    public String status;

    /**
     * Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
     */
    @Getter
    @Setter
    public String queryAction;

    /**
     * Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
     */
    @Getter
    @Setter
    public String queryInterface;

    /**
     * Return results that are actions performed by the user indiciated by this User ID
     */
    @Getter
    @Setter
    public Long queryUserId;

    /**
     * Return results that are file actions related to the file indicated by this File ID
     */
    @Getter
    @Setter
    public Long queryFileId;

    /**
     * Return results that are file actions inside the parent folder specified by this folder ID
     */
    @Getter
    @Setter
    public Long queryParentId;

    /**
     * Return results that are file actions related to this path.
     */
    @Getter
    @Setter
    public String queryPath;

    /**
     * Return results that are file actions related to files or folders inside this folder path.
     */
    @Getter
    @Setter
    public String queryFolder;

    /**
     * Return results that are file moves originating from this path.
     */
    @Getter
    @Setter
    public String querySrc;

    /**
     * Return results that are file moves with this path as destination.
     */
    @Getter
    @Setter
    public String queryDestination;

    /**
     * Filter results by this IP address.
     */
    @Getter
    @Setter
    public String queryIp;

    /**
     * Filter results by this username.
     */
    @Getter
    @Setter
    public String queryUsername;

    /**
     * If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
     */
    @Getter
    @Setter
    public String queryFailureType;

    /**
     * If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
     */
    @Getter
    @Setter
    public Long queryTargetId;

    /**
     * If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
     */
    @Getter
    @Setter
    public String queryTargetName;

    /**
     * If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
     */
    @Getter
    @Setter
    public String queryTargetPermission;

    /**
     * If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
     */
    @Getter
    @Setter
    public Long queryTargetUserId;

    /**
     * If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
     */
    @Getter
    @Setter
    public String queryTargetUsername;

    /**
     * If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
     */
    @Getter
    @Setter
    public String queryTargetPlatform;

    /**
     * If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
     */
    @Getter
    @Setter
    public String queryTargetPermissionSet;

    /**
     * User ID.  Provide a value of `0` to operate the current session's user.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     */
    public HistoryExport delete(HashMap<String, Object> parameters)
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
        throw new UnsupportedOperationException("The HistoryExport Object doesn't support updates.");
        }
        else
        {
        //var newObj = HistoryExport.create(this.attributes, this.options);
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
    public static HistoryExport list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static HistoryExport all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - History Export ID.
     */
    // TODO: Use types for path_and_primary_params
    public static HistoryExport find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static HistoryExport get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   start_at - string - Start date/time of export range.
     *   end_at - string - End date/time of export range.
     *   query_action - string - Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
     *   query_interface - string - Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
     *   query_user_id - integer - Return results that are actions performed by the user indiciated by this User ID
     *   query_file_id - integer - Return results that are file actions related to the file indicated by this File ID
     *   query_parent_id - integer - Return results that are file actions inside the parent folder specified by this folder ID
     *   query_path - string - Return results that are file actions related to this path.
     *   query_folder - string - Return results that are file actions related to files or folders inside this folder path.
     *   query_src - string - Return results that are file moves originating from this path.
     *   query_destination - string - Return results that are file moves with this path as destination.
     *   query_ip - string - Filter results by this IP address.
     *   query_username - string - Filter results by this username.
     *   query_failure_type - string - If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
     *   query_target_id - integer - If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
     *   query_target_name - string - If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
     *   query_target_permission - string - If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
     *   query_target_user_id - integer - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
     *   query_target_username - string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
     *   query_target_platform - string - If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
     *   query_target_permission_set - string - If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
     */
    // TODO: Use types for path_and_primary_params
    public static HistoryExport create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("start_at") && !(parameters.get("start_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: start_at must be of type String parameters[\"start_at\"]");
        }
        if (parameters.containsKey("end_at") && !(parameters.get("end_at") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: end_at must be of type String parameters[\"end_at\"]");
        }
        if (parameters.containsKey("query_action") && !(parameters.get("query_action") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_action must be of type String parameters[\"query_action\"]");
        }
        if (parameters.containsKey("query_interface") && !(parameters.get("query_interface") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_interface must be of type String parameters[\"query_interface\"]");
        }
        if (parameters.containsKey("query_user_id") && !(parameters.get("query_user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: query_user_id must be of type Long parameters[\"query_user_id\"]");
        }
        if (parameters.containsKey("query_file_id") && !(parameters.get("query_file_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: query_file_id must be of type Long parameters[\"query_file_id\"]");
        }
        if (parameters.containsKey("query_parent_id") && !(parameters.get("query_parent_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: query_parent_id must be of type Long parameters[\"query_parent_id\"]");
        }
        if (parameters.containsKey("query_path") && !(parameters.get("query_path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_path must be of type String parameters[\"query_path\"]");
        }
        if (parameters.containsKey("query_folder") && !(parameters.get("query_folder") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_folder must be of type String parameters[\"query_folder\"]");
        }
        if (parameters.containsKey("query_src") && !(parameters.get("query_src") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_src must be of type String parameters[\"query_src\"]");
        }
        if (parameters.containsKey("query_destination") && !(parameters.get("query_destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_destination must be of type String parameters[\"query_destination\"]");
        }
        if (parameters.containsKey("query_ip") && !(parameters.get("query_ip") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_ip must be of type String parameters[\"query_ip\"]");
        }
        if (parameters.containsKey("query_username") && !(parameters.get("query_username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_username must be of type String parameters[\"query_username\"]");
        }
        if (parameters.containsKey("query_failure_type") && !(parameters.get("query_failure_type") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_failure_type must be of type String parameters[\"query_failure_type\"]");
        }
        if (parameters.containsKey("query_target_id") && !(parameters.get("query_target_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_id must be of type Long parameters[\"query_target_id\"]");
        }
        if (parameters.containsKey("query_target_name") && !(parameters.get("query_target_name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_name must be of type String parameters[\"query_target_name\"]");
        }
        if (parameters.containsKey("query_target_permission") && !(parameters.get("query_target_permission") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_permission must be of type String parameters[\"query_target_permission\"]");
        }
        if (parameters.containsKey("query_target_user_id") && !(parameters.get("query_target_user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_user_id must be of type Long parameters[\"query_target_user_id\"]");
        }
        if (parameters.containsKey("query_target_username") && !(parameters.get("query_target_username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_username must be of type String parameters[\"query_target_username\"]");
        }
        if (parameters.containsKey("query_target_platform") && !(parameters.get("query_target_platform") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_platform must be of type String parameters[\"query_target_platform\"]");
        }
        if (parameters.containsKey("query_target_permission_set") && !(parameters.get("query_target_permission_set") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: query_target_permission_set must be of type String parameters[\"query_target_permission_set\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static HistoryExport delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static HistoryExport destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


