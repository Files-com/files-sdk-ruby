
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class MessageCommentReaction
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public MessageCommentReaction(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Reaction ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Emoji used in the reaction.
     */
    @Getter
    @Setter
    public String emoji;

    /**
     * User ID.  Provide a value of `0` to operate the current session's user.
     */
    @Getter
    @Setter
    public Long userId;

    /**
     */
    public MessageCommentReaction delete(HashMap<String, Object> parameters)
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
        throw new UnsupportedOperationException("The MessageCommentReaction Object doesn't support updates.");
        }
        else
        {
        //var newObj = MessageCommentReaction.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   message_comment_id (required) - integer - Message comment to return reactions for.
     */
    // TODO: Use types for path_and_primary_params
    public static MessageCommentReaction list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("message_comment_id") && !(parameters.get("message_comment_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: message_comment_id must be of type Long parameters[\"message_comment_id\"]");
        }
        if (!parameters.containsKey("message_comment_id") || parameters.get("message_comment_id") == null)
        {
            throw new NullPointerException("Parameter missing: message_comment_id parameters[\"message_comment_id\"]");
        }
        // TODO: Send request
        return null;
    }

    public static MessageCommentReaction all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Message Comment Reaction ID.
     */
    // TODO: Use types for path_and_primary_params
    public static MessageCommentReaction find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static MessageCommentReaction get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   emoji (required) - string - Emoji to react with.
     */
    // TODO: Use types for path_and_primary_params
    public static MessageCommentReaction create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("emoji") && !(parameters.get("emoji") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: emoji must be of type String parameters[\"emoji\"]");
        }
        if (!parameters.containsKey("emoji") || parameters.get("emoji") == null)
        {
            throw new NullPointerException("Parameter missing: emoji parameters[\"emoji\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static MessageCommentReaction delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static MessageCommentReaction destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


