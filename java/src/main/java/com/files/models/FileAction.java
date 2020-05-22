
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class FileAction
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public FileAction(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Copy file/folder
     *
     * Parameters:
     *   destination (required) - string - Copy destination path.
     */
    public FileAction copy(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Move file/folder
     *
     * Parameters:
     *   destination (required) - string - Move destination path.
     */
    public FileAction move(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Begin file upload
     *
     * Parameters:
     *   mkdir_parents - boolean - Create parent directories if they do not exist?
     *   part - integer - Part if uploading a part.
     *   parts - integer - How many parts to fetch?
     *   ref - string -
     *   restart - integer - File byte offset to restart from.
     *   with_rename - boolean - Allow file rename instead of overwrite?
     */
    public FileAction beginUpload(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }



    /**
     * Copy file/folder
     *
     * Parameters:
     *   destination (required) - string - Copy destination path.
     */
    // TODO: Use types for path_and_primary_params
    public static FileAction copy(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("destination") && !(parameters.get("destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination must be of type String parameters[\"destination\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("destination") || parameters.get("destination") == null)
        {
            throw new NullPointerException("Parameter missing: destination parameters[\"destination\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Move file/folder
     *
     * Parameters:
     *   destination (required) - string - Move destination path.
     */
    // TODO: Use types for path_and_primary_params
    public static FileAction move(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("destination") && !(parameters.get("destination") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: destination must be of type String parameters[\"destination\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        if (!parameters.containsKey("destination") || parameters.get("destination") == null)
        {
            throw new NullPointerException("Parameter missing: destination parameters[\"destination\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Begin file upload
     *
     * Parameters:
     *   mkdir_parents - boolean - Create parent directories if they do not exist?
     *   part - integer - Part if uploading a part.
     *   parts - integer - How many parts to fetch?
     *   ref - string -
     *   restart - integer - File byte offset to restart from.
     *   with_rename - boolean - Allow file rename instead of overwrite?
     */
    // TODO: Use types for path_and_primary_params
    public static FileAction beginUpload(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("mkdir_parents") && !(parameters.get("mkdir_parents") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: mkdir_parents must be of type boolean parameters[\"mkdir_parents\"]");
        }
        if (parameters.containsKey("part") && !(parameters.get("part") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: part must be of type Long parameters[\"part\"]");
        }
        if (parameters.containsKey("parts") && !(parameters.get("parts") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: parts must be of type Long parameters[\"parts\"]");
        }
        if (parameters.containsKey("ref") && !(parameters.get("ref") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ref must be of type String parameters[\"ref\"]");
        }
        if (parameters.containsKey("restart") && !(parameters.get("restart") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: restart must be of type Long parameters[\"restart\"]");
        }
        if (parameters.containsKey("with_rename") && !(parameters.get("with_rename") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: with_rename must be of type boolean parameters[\"with_rename\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

}


