
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Session
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Session(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Session ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Session language
     */
    @Getter
    @Setter
    public String language;

    /**
     * Login token. If set, this token will allow your user to log in via browser at the domain in `login_token_domain`.
     */
    @Getter
    @Setter
    public String loginToken;

    /**
     * Domain to use with `login_token`.
     */
    @Getter
    @Setter
    public String loginTokenDomain;

    /**
     * Maximum number of files to retrieve per folder for a directory listing.  This is based on the user's plan.
     */
    @Getter
    @Setter
    public Long maxDirListingSize;

    /**
     * Can access multiple regions?
     */
    @Getter
    @Setter
    public boolean multipleRegions;

    /**
     * Is this session read only?
     */
    @Getter
    @Setter
    public boolean readOnly;

    /**
     * Initial root path to start the user's session in.
     */
    @Getter
    @Setter
    public String rootPath;

    /**
     * Site ID
     */
    @Getter
    @Setter
    public Long siteId;

    /**
     * Is SSL required for this user?  (If so, ensure all your communications with this user use SSL.)
     */
    @Getter
    @Setter
    public boolean sslRequired;

    /**
     * Is strong TLS disabled for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure TLS versions for this user.)
     */
    @Getter
    @Setter
    public boolean tlsDisabled;

    /**
     * If true, this user needs to add a Two Factor Authentication method before performing any further actions.
     */
    @Getter
    @Setter
    public boolean twoFactorSetupNeeded;

    /**
     * Sent only if 2FA setup is needed. Is SMS two factor authentication allowed?
     */
    @Getter
    @Setter
    public boolean allowed2faMethodSms;

    /**
     * Sent only if 2FA setup is needed. Is TOTP two factor authentication allowed?
     */
    @Getter
    @Setter
    public boolean allowed2faMethodTotp;

    /**
     * Sent only if 2FA setup is needed. Is U2F two factor authentication allowed?
     */
    @Getter
    @Setter
    public boolean allowed2faMethodU2f;

    /**
     * Sent only if 2FA setup is needed. Is Yubikey two factor authentication allowed?
     */
    @Getter
    @Setter
    public boolean allowed2faMethodYubi;

    /**
     * Allow the user to provide file/folder modified at dates?  If false, the server will always use the current date/time.
     */
    @Getter
    @Setter
    public boolean useProvidedModifiedAt;

    /**
     * Does this user want to use Windows line-ending emulation?  (CR vs CRLF)
     */
    @Getter
    @Setter
    public boolean windowsModeFtp;

    /**
     * Username to sign in as
     */
    @Getter
    @Setter
    public String username;

    /**
     * Password for sign in
     */
    @Getter
    @Setter
    public String password;

    /**
     * If this user has a 2FA device, provide its OTP or code here.
     */
    @Getter
    @Setter
    public String otp;

    /**
     * Identifier for a partially-completed login
     */
    @Getter
    @Setter
    public String partialSessionId;


    public void save()
    {
        if (this.attributes.get("id") != null)
        {
        throw new UnsupportedOperationException("The Session Object doesn't support updates.");
        }
        else
        {
        //var newObj = Session.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   username - string - Username to sign in as
     *   password - string - Password for sign in
     *   otp - string - If this user has a 2FA device, provide its OTP or code here.
     *   partial_session_id - string - Identifier for a partially-completed login
     */
    // TODO: Use types for path_and_primary_params
    public static Session create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("otp") && !(parameters.get("otp") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: otp must be of type String parameters[\"otp\"]");
        }
        if (parameters.containsKey("partial_session_id") && !(parameters.get("partial_session_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: partial_session_id must be of type String parameters[\"partial_session_id\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static Session delete( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        // TODO: Send request
        return null;
    }

    public static Session destroy(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(parameters, options);
    }
}


