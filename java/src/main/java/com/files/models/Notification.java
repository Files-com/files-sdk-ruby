
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Notification
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Notification(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Notification ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Folder path to notify on This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * Notification group id
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
     * Trigger notification on notification user actions?
     */
    @Getter
    @Setter
    public boolean notifyUserActions;

    /**
     * Triggers notification when moving or copying files to this path
     */
    @Getter
    @Setter
    public boolean notifyOnCopy;

    /**
     * The time interval that notifications are aggregated to
     */
    @Getter
    @Setter
    public String sendInterval;

    /**
     * Is the user unsubscribed from this notification?
     */
    @Getter
    @Setter
    public boolean unsubscribed;

    /**
     * The reason that the user unsubscribed
     */
    @Getter
    @Setter
    public String unsubscribedReason;

    /**
     * Notification user ID
     */
    @Getter
    @Setter
    public Long userId;

    /**
     * Notification username
     */
    @Getter
    @Setter
    public String username;

    /**
     * If true, it means that the recipient at this user's email address has manually unsubscribed from all emails, or had their email "hard bounce", which means that we are unable to send mail to this user's current email address. Notifications will resume if the user changes their email address.
     */
    @Getter
    @Setter
    public boolean suppressedEmail;

    /**
     * Parameters:
     *   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
     *   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
     *   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
     */
    public Notification update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Notification delete(HashMap<String, Object> parameters)
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
        //var newObj = Notification.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   user_id - integer - Show notifications for this User ID.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   group_id - integer - Show notifications for this Group ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Notification list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Notification all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Notification ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Notification find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Notification get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - The id of the user to notify. Provide `user_id`, `username` or `group_id`.
     *   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
     *   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
     *   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
     *   group_id - integer - The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
     *   path - string - Path
     *   username - string - The username of the user to notify.  Provide `user_id`, `username` or `group_id`.
     */
    // TODO: Use types for path_and_primary_params
    public static Notification create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("notify_on_copy") && !(parameters.get("notify_on_copy") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: notify_on_copy must be of type boolean parameters[\"notify_on_copy\"]");
        }
        if (parameters.containsKey("notify_user_actions") && !(parameters.get("notify_user_actions") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: notify_user_actions must be of type boolean parameters[\"notify_user_actions\"]");
        }
        if (parameters.containsKey("send_interval") && !(parameters.get("send_interval") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: send_interval must be of type String parameters[\"send_interval\"]");
        }
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
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
     *   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
     *   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
     *   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
     */
    // TODO: Use types for path_and_primary_params
    public static Notification update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("notify_on_copy") && !(parameters.get("notify_on_copy") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: notify_on_copy must be of type boolean parameters[\"notify_on_copy\"]");
        }
        if (parameters.containsKey("notify_user_actions") && !(parameters.get("notify_user_actions") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: notify_user_actions must be of type boolean parameters[\"notify_user_actions\"]");
        }
        if (parameters.containsKey("send_interval") && !(parameters.get("send_interval") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: send_interval must be of type String parameters[\"send_interval\"]");
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
    public static Notification delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Notification destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


