
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Behavior
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Behavior(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Folder behavior ID
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
     * URL for attached file
     */
    @Getter
    @Setter
    public String attachmentUrl;

    /**
     * Behavior type.
     */
    @Getter
    @Setter
    public String behavior;

    /**
     * Settings for this behavior.  See the section above for an example value to provide here.  Formatting is different for each Behavior type.  May be sent as nested JSON or a single JSON-encoded string.  If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
     */
    @Getter
    @Setter
    public Object value;

    /**
     * Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
     */
    @Getter
    @Setter
    public byte[] attachmentFile;

    /**
     * Parameters:
     *   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
     *   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
     */
    public Behavior update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public Behavior delete(HashMap<String, Object> parameters)
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
        //var newObj = Behavior.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   behavior - string - If set, only shows folder behaviors matching this behavior type.
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("behavior") && !(parameters.get("behavior") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: behavior must be of type String parameters[\"behavior\"]");
        }
        // TODO: Send request
        return null;
    }

    public static Behavior all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   path (required) - string - Path to operate on.
     *   recursive - string - Show behaviors below this path?
     *   behavior - string - If set only shows folder behaviors matching this behavior type.
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior listFor(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("recursive") && !(parameters.get("recursive") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: recursive must be of type String parameters[\"recursive\"]");
        }
        if (parameters.containsKey("behavior") && !(parameters.get("behavior") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: behavior must be of type String parameters[\"behavior\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   id (required) - integer - Behavior ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Behavior get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
     *   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
     *   path (required) - string - Folder behaviors path.
     *   behavior (required) - string - Behavior type.
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("value") && !(parameters.get("value") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: value must be of type String parameters[\"value\"]");
        }
        if (parameters.containsKey("attachment_file") && !(parameters.get("attachment_file") instanceof byte[] ))
        {
            throw new IllegalArgumentException("Bad parameter: attachment_file must be of type byte[] parameters[\"attachment_file\"]");
        }
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("behavior") && !(parameters.get("behavior") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: behavior must be of type String parameters[\"behavior\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("behavior") || parameters.get("behavior") == null)
        {
            throw new NullPointerException("Parameter missing: behavior parameters[\"behavior\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   url (required) - string - URL for testing the webhook.
     *   method - string - HTTP method(GET or POST).
     *   encoding - string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior webhookTest( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("url") && !(parameters.get("url") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: url must be of type String parameters[\"url\"]");
        }
        if (parameters.containsKey("method") && !(parameters.get("method") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: method must be of type String parameters[\"method\"]");
        }
        if (parameters.containsKey("encoding") && !(parameters.get("encoding") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: encoding must be of type String parameters[\"encoding\"]");
        }
        if (!parameters.containsKey("url") || parameters.get("url") == null)
        {
            throw new NullPointerException("Parameter missing: url parameters[\"url\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
     *   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
     */
    // TODO: Use types for path_and_primary_params
    public static Behavior update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("value") && !(parameters.get("value") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: value must be of type String parameters[\"value\"]");
        }
        if (parameters.containsKey("attachment_file") && !(parameters.get("attachment_file") instanceof byte[] ))
        {
            throw new IllegalArgumentException("Bad parameter: attachment_file must be of type byte[] parameters[\"attachment_file\"]");
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
    public static Behavior delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Behavior destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


