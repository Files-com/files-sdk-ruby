
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class File
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public File(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * File/Folder ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * File/Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
     */
    @Getter
    @Setter
    public String path;

    /**
     * File/Folder display name
     */
    @Getter
    @Setter
    public String displayName;

    /**
     * Type: `directory` or `file`.
     */
    @Getter
    @Setter
    public String type;

    /**
     * File/Folder size
     */
    @Getter
    @Setter
    public Long size;

    /**
     * File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
     */
    @Getter
    @Setter
    public LocalDateTime mtime;

    /**
     * File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
     */
    @Getter
    @Setter
    public LocalDateTime providedMtime;

    /**
     * File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
     */
    @Getter
    @Setter
    public String crc32;

    /**
     * File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
     */
    @Getter
    @Setter
    public String md5;

    /**
     * MIME Type.  This is determined by the filename extension and is not stored separately internally.
     */
    @Getter
    @Setter
    public String mimeType;

    /**
     * Region location
     */
    @Getter
    @Setter
    public String region;

    /**
     * A short string representing the current user's permissions.  Can be `r`,`w`,`p`, or any combination
     */
    @Getter
    @Setter
    public String permissions;

    /**
     * Are subfolders locked and unable to be modified?
     */
    @Getter
    @Setter
    public boolean subfoldersLocked;

    /**
     * Link to download file. Provided only in response to a download request.
     */
    @Getter
    @Setter
    public String downloadUri;

    /**
     * Bookmark/priority color of file/folder
     */
    @Getter
    @Setter
    public String priorityColor;

    /**
     * File preview ID
     */
    @Getter
    @Setter
    public Long previewId;

    /**
     * File preview
     */
    @Getter
    @Setter
    public Object preview;

    /**
     * The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
     */
    @Getter
    @Setter
    public String action;

    /**
     * Length of file.
     */
    @Getter
    @Setter
    public Long length;

    /**
     * Create parent directories if they do not exist?
     */
    @Getter
    @Setter
    public boolean mkdirParents;

    /**
     * Part if uploading a part.
     */
    @Getter
    @Setter
    public Long part;

    /**
     * How many parts to fetch?
     */
    @Getter
    @Setter
    public Long parts;

    /**
       */
    @Getter
    @Setter
    public String ref;

    /**
     * File byte offset to restart from.
     */
    @Getter
    @Setter
    public Long restart;

    /**
     * If copying folder, copy just the structure?
     */
    @Getter
    @Setter
    public String structure;

    /**
     * Allow file rename instead of overwrite?
     */
    @Getter
    @Setter
    public boolean withRename;

    /**
     * Download file
     *
     * Parameters:
     *   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
     *   id - integer - If provided, lookup the file by id instead of path.
     *   with_previews - boolean - Include file preview information?
     *   with_priority_color - boolean - Include file priority color information?
     */
    public File download(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Parameters:
     *   provided_mtime - string - Modified time of file.
     *   priority_color - string - Priority/Bookmark color of file.
     */
    public File update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Parameters:
     *   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
     */
    public File delete(HashMap<String, Object> parameters)
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
        if (this.attributes.get("path") != null)
        {
        update(this.attributes);
        }
        else
        {
        //var newObj = File.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Download file
     *
     * Parameters:
     *   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
     *   id - integer - If provided, lookup the file by id instead of path.
     *   with_previews - boolean - Include file preview information?
     *   with_priority_color - boolean - Include file priority color information?
     */
    // TODO: Use types for path_and_primary_params
    public static File download(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("action") && !(parameters.get("action") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: action must be of type String parameters[\"action\"]");
        }
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("with_previews") && !(parameters.get("with_previews") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: with_previews must be of type boolean parameters[\"with_previews\"]");
        }
        if (parameters.containsKey("with_priority_color") && !(parameters.get("with_priority_color") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: with_priority_color must be of type boolean parameters[\"with_priority_color\"]");
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
     *   path (required) - string - Path to operate on.
     *   action - string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
     *   etags[etag] (required) - array - etag identifier.
     *   etags[part] (required) - array - Part number.
     *   length - integer - Length of file.
     *   mkdir_parents - boolean - Create parent directories if they do not exist?
     *   part - integer - Part if uploading a part.
     *   parts - integer - How many parts to fetch?
     *   provided_mtime - string - User provided modification time.
     *   ref - string -
     *   restart - integer - File byte offset to restart from.
     *   size - integer - Size of file.
     *   structure - string - If copying folder, copy just the structure?
     *   with_rename - boolean - Allow file rename instead of overwrite?
     */
    // TODO: Use types for path_and_primary_params
    public static File create(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("action") && !(parameters.get("action") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: action must be of type String parameters[\"action\"]");
        }
        if (parameters.containsKey("length") && !(parameters.get("length") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: length must be of type Long parameters[\"length\"]");
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
        if (parameters.containsKey("provided_mtime") && !(parameters.get("provided_mtime") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: provided_mtime must be of type String parameters[\"provided_mtime\"]");
        }
        if (parameters.containsKey("ref") && !(parameters.get("ref") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ref must be of type String parameters[\"ref\"]");
        }
        if (parameters.containsKey("restart") && !(parameters.get("restart") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: restart must be of type Long parameters[\"restart\"]");
        }
        if (parameters.containsKey("size") && !(parameters.get("size") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: size must be of type Long parameters[\"size\"]");
        }
        if (parameters.containsKey("structure") && !(parameters.get("structure") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: structure must be of type String parameters[\"structure\"]");
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

    /**
     * Parameters:
     *   provided_mtime - string - Modified time of file.
     *   priority_color - string - Priority/Bookmark color of file.
     */
    // TODO: Use types for path_and_primary_params
    public static File update(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("provided_mtime") && !(parameters.get("provided_mtime") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: provided_mtime must be of type String parameters[\"provided_mtime\"]");
        }
        if (parameters.containsKey("priority_color") && !(parameters.get("priority_color") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: priority_color must be of type String parameters[\"priority_color\"]");
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
     *   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
     */
    // TODO: Use types for path_and_primary_params
    public static File delete(String path,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("path", path);
        if (parameters.containsKey("path") && !(parameters.get("path") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: path must be of type String parameters[\"path\"]");
        }
        if (parameters.containsKey("recursive") && !(parameters.get("recursive") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: recursive must be of type boolean parameters[\"recursive\"]");
        }
        if (!parameters.containsKey("path") || parameters.get("path") == null)
        {
            throw new NullPointerException("Parameter missing: path parameters[\"path\"]");
        }
        // TODO: Send request
        return null;
    }

    public static File destroy(String path, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(path, parameters, options);
    }
}


