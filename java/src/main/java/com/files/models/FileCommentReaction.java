
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class FileCommentReaction
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public FileCommentReaction(HashMap<String, Object> attributes, HashMap<String, Object> options)
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
     * ID of file comment to attach reaction to.
     */
    @Getter
    @Setter
    public Long fileCommentId;

    /**
     */
    public FileCommentReaction delete(HashMap<String, Object> parameters)
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
        throw new UnsupportedOperationException("The FileCommentReaction Object doesn't support updates.");
        }
        else
        {
        //var newObj = FileCommentReaction.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
     *   file_comment_id (required) - integer - ID of file comment to attach reaction to.
     *   emoji (required) - string - Emoji to react with.
     */
    // TODO: Use types for path_and_primary_params
    public static FileCommentReaction create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("user_id") && !(parameters.get("user_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: user_id must be of type Long parameters[\"user_id\"]");
        }
        if (parameters.containsKey("file_comment_id") && !(parameters.get("file_comment_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: file_comment_id must be of type Long parameters[\"file_comment_id\"]");
        }
        if (parameters.containsKey("emoji") && !(parameters.get("emoji") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: emoji must be of type String parameters[\"emoji\"]");
        }
        if (!parameters.containsKey("file_comment_id") || parameters.get("file_comment_id") == null)
        {
            throw new NullPointerException("Parameter missing: file_comment_id parameters[\"file_comment_id\"]");
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
    public static FileCommentReaction delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static FileCommentReaction destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


