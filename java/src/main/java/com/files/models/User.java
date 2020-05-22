
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class User
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public User(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * User ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * User's username
     */
    @Getter
    @Setter
    public String username;

    /**
     * List of group IDs of which this user is an administrator
     */
    @Getter
    @Setter
    public Object[] adminGroupIds;

    /**
     * A list of allowed IPs if applicable.  Newline delimited
     */
    @Getter
    @Setter
    public String allowedIps;

    /**
     * Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
     */
    @Getter
    @Setter
    public boolean attachmentsPermission;

    /**
     * Number of api keys associated with this user
     */
    @Getter
    @Setter
    public Long apiKeysCount;

    /**
     * Scheduled Date/Time at which user will be deactivated
     */
    @Getter
    @Setter
    public LocalDateTime authenticateUntil;

    /**
     * How is this user authenticated?
     */
    @Getter
    @Setter
    public String authenticationMethod;

    /**
     * URL holding the user's avatar
     */
    @Getter
    @Setter
    public String avatarUrl;

    /**
     * Allow this user to perform operations on the account, payments, and invoices?
     */
    @Getter
    @Setter
    public boolean billingPermission;

    /**
     * Allow this user to skip site-wide IP blacklists?
     */
    @Getter
    @Setter
    public boolean bypassSiteAllowedIps;

    /**
     * Exempt this user from being disabled based on inactivity?
     */
    @Getter
    @Setter
    public boolean bypassInactiveDisable;

    /**
     * When this user was created
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Can the user connect with WebDAV?
     */
    @Getter
    @Setter
    public boolean davPermission;

    /**
     * Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
     */
    @Getter
    @Setter
    public boolean disabled;

    /**
     * User email address
     */
    @Getter
    @Setter
    public String email;

    /**
     * Can the user access with FTP/FTPS?
     */
    @Getter
    @Setter
    public boolean ftpPermission;

    /**
     * Comma-separated list of group IDs of which this user is a member
     */
    @Getter
    @Setter
    public Object[] groupIds;

    /**
     * Preferred language
     */
    @Getter
    @Setter
    public String language;

    /**
     * User's last login time
     */
    @Getter
    @Setter
    public LocalDateTime lastLoginAt;

    /**
     * The last protocol and cipher used
     */
    @Getter
    @Setter
    public String lastProtocolCipher;

    /**
     * Time in the future that the user will no longer be locked out if applicable
     */
    @Getter
    @Setter
    public LocalDateTime lockoutExpires;

    /**
     * User's full name
     */
    @Getter
    @Setter
    public String name;

    /**
     * Any internal notes on the user
     */
    @Getter
    @Setter
    public String notes;

    /**
     * Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
     */
    @Getter
    @Setter
    public Long notificationDailySendTime;

    /**
     * Last time the user's password was set
     */
    @Getter
    @Setter
    public LocalDateTime passwordSetAt;

    /**
     * Number of days to allow user to use the same password
     */
    @Getter
    @Setter
    public Long passwordValidityDays;

    /**
     * Number of public keys associated with this user
     */
    @Getter
    @Setter
    public Long publicKeysCount;

    /**
     * Should the user receive admin alerts such a certificate expiration notifications and overages?
     */
    @Getter
    @Setter
    public boolean receiveAdminAlerts;

    /**
     * Is 2fa required to sign in?
     */
    @Getter
    @Setter
    public boolean require2fa;

    /**
     * Is a password change required upon next user login?
     */
    @Getter
    @Setter
    public boolean requirePasswordChange;

    /**
     * Can this user access the REST API?
     */
    @Getter
    @Setter
    public boolean restapiPermission;

    /**
     * Does this user manage it's own credentials or is it a shared/bot user?
     */
    @Getter
    @Setter
    public boolean selfManaged;

    /**
     * Can the user access with SFTP?
     */
    @Getter
    @Setter
    public boolean sftpPermission;

    /**
     * Is the user an administrator for this site?
     */
    @Getter
    @Setter
    public boolean siteAdmin;

    /**
     * Skip Welcome page in the UI?
     */
    @Getter
    @Setter
    public boolean skipWelcomeScreen;

    /**
     * SSL required setting
     */
    @Getter
    @Setter
    public String sslRequired;

    /**
     * SSO (Single Sign On) strategy ID for the user, if applicable.
     */
    @Getter
    @Setter
    public Long ssoStrategyId;

    /**
     * Is the user subscribed to the newsletter?
     */
    @Getter
    @Setter
    public boolean subscribeToNewsletter;

    /**
     * Is this user managed by an external source (such as LDAP)?
     */
    @Getter
    @Setter
    public boolean externallyManaged;

    /**
     * User time zone
     */
    @Getter
    @Setter
    public String timeZone;

    /**
     * Type(s) of 2FA methods in use.  Will be either `sms`, `totp`, `u2f`, `yubi`, or multiple values sorted alphabetically and joined by an underscore.
     */
    @Getter
    @Setter
    public String typeOf2fa;

    /**
     * Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
     */
    @Getter
    @Setter
    public String userRoot;

    /**
     * An image file for your user avatar.
     */
    @Getter
    @Setter
    public byte[] avatarFile;

    /**
     * If true, the avatar will be deleted.
     */
    @Getter
    @Setter
    public boolean avatarDelete;

    /**
     * Used for changing a password on an existing user.
     */
    @Getter
    @Setter
    public String changePassword;

    /**
     * Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
     */
    @Getter
    @Setter
    public String changePasswordConfirmation;

    /**
     * Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
     */
    @Getter
    @Setter
    public String grantPermission;

    /**
     * Group ID to associate this user with.
     */
    @Getter
    @Setter
    public Long groupId;

    /**
     * User password.
     */
    @Getter
    @Setter
    public String password;

    /**
     * Optional, but if provided, we will ensure that it matches the value sent in `password`.
     */
    @Getter
    @Setter
    public String passwordConfirmation;

    /**
     * Signifies that the user has read all the announcements in the UI.
     */
    @Getter
    @Setter
    public boolean announcementsRead;

    /**
     * Unlock user who has been locked out due to failed logins
     */
    public User unlock(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Resend user welcome email
     */
    public User resendWelcomeEmail(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
     */
    public User user2faReset(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     * Parameters:
     *   avatar_file - file - An image file for your user avatar.
     *   avatar_delete - boolean - If true, the avatar will be deleted.
     *   change_password - string - Used for changing a password on an existing user.
     *   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
     *   email - string - User's email.
     *   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
     *   group_id - integer - Group ID to associate this user with.
     *   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
     *   password - string - User password.
     *   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
     *   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
     *   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
     *   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
     *   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
     *   authentication_method - string - How is this user authenticated?
     *   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
     *   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
     *   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
     *   dav_permission - boolean - Can the user connect with WebDAV?
     *   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
     *   ftp_permission - boolean - Can the user access with FTP/FTPS?
     *   language - string - Preferred language
     *   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
     *   name - string - User's full name
     *   notes - string - Any internal notes on the user
     *   password_validity_days - integer - Number of days to allow user to use the same password
     *   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
     *   require_password_change - boolean - Is a password change required upon next user login?
     *   restapi_permission - boolean - Can this user access the REST API?
     *   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
     *   sftp_permission - boolean - Can the user access with SFTP?
     *   site_admin - boolean - Is the user an administrator for this site?
     *   skip_welcome_screen - boolean - Skip Welcome page in the UI?
     *   ssl_required - string - SSL required setting
     *   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
     *   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
     *   time_zone - string - User time zone
     *   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
     *   username - string - User's username
     */
    public User update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public User delete(HashMap<String, Object> parameters)
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
        //var newObj = User.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     *   q[username] - string - List users matching username.
     *   q[email] - string - List users matching email.
     *   q[notes] - string - List users matching notes field.
     *   q[admin] - string - If `true`, list only admin users.
     *   q[allowed_ips] - string - If set, list only users with overridden allowed IP setting.
     *   q[password_validity_days] - string - If set, list only users with overridden password validity days setting.
     *   q[ssl_required] - string - If set, list only users with overridden SSL required setting.
     *   search - string - Searches for partial matches of name, username, or email.
     */
    // TODO: Use types for path_and_primary_params
    public static User list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        if (parameters.containsKey("search") && !(parameters.get("search") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: search must be of type String parameters[\"search\"]");
        }
        // TODO: Send request
        return null;
    }

    public static User all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - User ID.
     */
    // TODO: Use types for path_and_primary_params
    public static User find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static User get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   avatar_file - file - An image file for your user avatar.
     *   avatar_delete - boolean - If true, the avatar will be deleted.
     *   change_password - string - Used for changing a password on an existing user.
     *   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
     *   email - string - User's email.
     *   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
     *   group_id - integer - Group ID to associate this user with.
     *   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
     *   password - string - User password.
     *   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
     *   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
     *   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
     *   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
     *   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
     *   authentication_method - string - How is this user authenticated?
     *   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
     *   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
     *   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
     *   dav_permission - boolean - Can the user connect with WebDAV?
     *   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
     *   ftp_permission - boolean - Can the user access with FTP/FTPS?
     *   language - string - Preferred language
     *   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
     *   name - string - User's full name
     *   notes - string - Any internal notes on the user
     *   password_validity_days - integer - Number of days to allow user to use the same password
     *   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
     *   require_password_change - boolean - Is a password change required upon next user login?
     *   restapi_permission - boolean - Can this user access the REST API?
     *   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
     *   sftp_permission - boolean - Can the user access with SFTP?
     *   site_admin - boolean - Is the user an administrator for this site?
     *   skip_welcome_screen - boolean - Skip Welcome page in the UI?
     *   ssl_required - string - SSL required setting
     *   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
     *   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
     *   time_zone - string - User time zone
     *   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
     *   username - string - User's username
     */
    // TODO: Use types for path_and_primary_params
    public static User create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("avatar_file") && !(parameters.get("avatar_file") instanceof byte[] ))
        {
            throw new IllegalArgumentException("Bad parameter: avatar_file must be of type byte[] parameters[\"avatar_file\"]");
        }
        if (parameters.containsKey("avatar_delete") && !(parameters.get("avatar_delete") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: avatar_delete must be of type boolean parameters[\"avatar_delete\"]");
        }
        if (parameters.containsKey("change_password") && !(parameters.get("change_password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: change_password must be of type String parameters[\"change_password\"]");
        }
        if (parameters.containsKey("change_password_confirmation") && !(parameters.get("change_password_confirmation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: change_password_confirmation must be of type String parameters[\"change_password_confirmation\"]");
        }
        if (parameters.containsKey("email") && !(parameters.get("email") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: email must be of type String parameters[\"email\"]");
        }
        if (parameters.containsKey("grant_permission") && !(parameters.get("grant_permission") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: grant_permission must be of type String parameters[\"grant_permission\"]");
        }
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        if (parameters.containsKey("group_ids") && !(parameters.get("group_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_ids must be of type String parameters[\"group_ids\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("password_confirmation") && !(parameters.get("password_confirmation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password_confirmation must be of type String parameters[\"password_confirmation\"]");
        }
        if (parameters.containsKey("announcements_read") && !(parameters.get("announcements_read") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: announcements_read must be of type boolean parameters[\"announcements_read\"]");
        }
        if (parameters.containsKey("allowed_ips") && !(parameters.get("allowed_ips") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: allowed_ips must be of type String parameters[\"allowed_ips\"]");
        }
        if (parameters.containsKey("attachments_permission") && !(parameters.get("attachments_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: attachments_permission must be of type boolean parameters[\"attachments_permission\"]");
        }
        if (parameters.containsKey("authenticate_until") && !(parameters.get("authenticate_until") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: authenticate_until must be of type String parameters[\"authenticate_until\"]");
        }
        if (parameters.containsKey("authentication_method") && !(parameters.get("authentication_method") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: authentication_method must be of type String parameters[\"authentication_method\"]");
        }
        if (parameters.containsKey("billing_permission") && !(parameters.get("billing_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: billing_permission must be of type boolean parameters[\"billing_permission\"]");
        }
        if (parameters.containsKey("bypass_inactive_disable") && !(parameters.get("bypass_inactive_disable") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: bypass_inactive_disable must be of type boolean parameters[\"bypass_inactive_disable\"]");
        }
        if (parameters.containsKey("bypass_site_allowed_ips") && !(parameters.get("bypass_site_allowed_ips") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: bypass_site_allowed_ips must be of type boolean parameters[\"bypass_site_allowed_ips\"]");
        }
        if (parameters.containsKey("dav_permission") && !(parameters.get("dav_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: dav_permission must be of type boolean parameters[\"dav_permission\"]");
        }
        if (parameters.containsKey("disabled") && !(parameters.get("disabled") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: disabled must be of type boolean parameters[\"disabled\"]");
        }
        if (parameters.containsKey("ftp_permission") && !(parameters.get("ftp_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: ftp_permission must be of type boolean parameters[\"ftp_permission\"]");
        }
        if (parameters.containsKey("language") && !(parameters.get("language") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: language must be of type String parameters[\"language\"]");
        }
        if (parameters.containsKey("notification_daily_send_time") && !(parameters.get("notification_daily_send_time") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: notification_daily_send_time must be of type Long parameters[\"notification_daily_send_time\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("notes") && !(parameters.get("notes") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: notes must be of type String parameters[\"notes\"]");
        }
        if (parameters.containsKey("password_validity_days") && !(parameters.get("password_validity_days") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: password_validity_days must be of type Long parameters[\"password_validity_days\"]");
        }
        if (parameters.containsKey("receive_admin_alerts") && !(parameters.get("receive_admin_alerts") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: receive_admin_alerts must be of type boolean parameters[\"receive_admin_alerts\"]");
        }
        if (parameters.containsKey("require_password_change") && !(parameters.get("require_password_change") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: require_password_change must be of type boolean parameters[\"require_password_change\"]");
        }
        if (parameters.containsKey("restapi_permission") && !(parameters.get("restapi_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: restapi_permission must be of type boolean parameters[\"restapi_permission\"]");
        }
        if (parameters.containsKey("self_managed") && !(parameters.get("self_managed") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: self_managed must be of type boolean parameters[\"self_managed\"]");
        }
        if (parameters.containsKey("sftp_permission") && !(parameters.get("sftp_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: sftp_permission must be of type boolean parameters[\"sftp_permission\"]");
        }
        if (parameters.containsKey("site_admin") && !(parameters.get("site_admin") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: site_admin must be of type boolean parameters[\"site_admin\"]");
        }
        if (parameters.containsKey("skip_welcome_screen") && !(parameters.get("skip_welcome_screen") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: skip_welcome_screen must be of type boolean parameters[\"skip_welcome_screen\"]");
        }
        if (parameters.containsKey("ssl_required") && !(parameters.get("ssl_required") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ssl_required must be of type String parameters[\"ssl_required\"]");
        }
        if (parameters.containsKey("sso_strategy_id") && !(parameters.get("sso_strategy_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: sso_strategy_id must be of type Long parameters[\"sso_strategy_id\"]");
        }
        if (parameters.containsKey("subscribe_to_newsletter") && !(parameters.get("subscribe_to_newsletter") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: subscribe_to_newsletter must be of type boolean parameters[\"subscribe_to_newsletter\"]");
        }
        if (parameters.containsKey("time_zone") && !(parameters.get("time_zone") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: time_zone must be of type String parameters[\"time_zone\"]");
        }
        if (parameters.containsKey("user_root") && !(parameters.get("user_root") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_root must be of type String parameters[\"user_root\"]");
        }
        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Unlock user who has been locked out due to failed logins
     */
    // TODO: Use types for path_and_primary_params
    public static User unlock(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    /**
     * Resend user welcome email
     */
    // TODO: Use types for path_and_primary_params
    public static User resendWelcomeEmail(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    /**
     * Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
     */
    // TODO: Use types for path_and_primary_params
    public static User user2faReset(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    /**
     * Parameters:
     *   avatar_file - file - An image file for your user avatar.
     *   avatar_delete - boolean - If true, the avatar will be deleted.
     *   change_password - string - Used for changing a password on an existing user.
     *   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
     *   email - string - User's email.
     *   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
     *   group_id - integer - Group ID to associate this user with.
     *   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
     *   password - string - User password.
     *   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
     *   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
     *   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
     *   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
     *   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
     *   authentication_method - string - How is this user authenticated?
     *   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
     *   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
     *   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
     *   dav_permission - boolean - Can the user connect with WebDAV?
     *   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
     *   ftp_permission - boolean - Can the user access with FTP/FTPS?
     *   language - string - Preferred language
     *   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
     *   name - string - User's full name
     *   notes - string - Any internal notes on the user
     *   password_validity_days - integer - Number of days to allow user to use the same password
     *   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
     *   require_password_change - boolean - Is a password change required upon next user login?
     *   restapi_permission - boolean - Can this user access the REST API?
     *   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
     *   sftp_permission - boolean - Can the user access with SFTP?
     *   site_admin - boolean - Is the user an administrator for this site?
     *   skip_welcome_screen - boolean - Skip Welcome page in the UI?
     *   ssl_required - string - SSL required setting
     *   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
     *   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
     *   time_zone - string - User time zone
     *   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
     *   username - string - User's username
     */
    // TODO: Use types for path_and_primary_params
    public static User update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("avatar_file") && !(parameters.get("avatar_file") instanceof byte[] ))
        {
            throw new IllegalArgumentException("Bad parameter: avatar_file must be of type byte[] parameters[\"avatar_file\"]");
        }
        if (parameters.containsKey("avatar_delete") && !(parameters.get("avatar_delete") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: avatar_delete must be of type boolean parameters[\"avatar_delete\"]");
        }
        if (parameters.containsKey("change_password") && !(parameters.get("change_password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: change_password must be of type String parameters[\"change_password\"]");
        }
        if (parameters.containsKey("change_password_confirmation") && !(parameters.get("change_password_confirmation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: change_password_confirmation must be of type String parameters[\"change_password_confirmation\"]");
        }
        if (parameters.containsKey("email") && !(parameters.get("email") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: email must be of type String parameters[\"email\"]");
        }
        if (parameters.containsKey("grant_permission") && !(parameters.get("grant_permission") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: grant_permission must be of type String parameters[\"grant_permission\"]");
        }
        if (parameters.containsKey("group_id") && !(parameters.get("group_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: group_id must be of type Long parameters[\"group_id\"]");
        }
        if (parameters.containsKey("group_ids") && !(parameters.get("group_ids") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: group_ids must be of type String parameters[\"group_ids\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("password_confirmation") && !(parameters.get("password_confirmation") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password_confirmation must be of type String parameters[\"password_confirmation\"]");
        }
        if (parameters.containsKey("announcements_read") && !(parameters.get("announcements_read") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: announcements_read must be of type boolean parameters[\"announcements_read\"]");
        }
        if (parameters.containsKey("allowed_ips") && !(parameters.get("allowed_ips") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: allowed_ips must be of type String parameters[\"allowed_ips\"]");
        }
        if (parameters.containsKey("attachments_permission") && !(parameters.get("attachments_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: attachments_permission must be of type boolean parameters[\"attachments_permission\"]");
        }
        if (parameters.containsKey("authenticate_until") && !(parameters.get("authenticate_until") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: authenticate_until must be of type String parameters[\"authenticate_until\"]");
        }
        if (parameters.containsKey("authentication_method") && !(parameters.get("authentication_method") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: authentication_method must be of type String parameters[\"authentication_method\"]");
        }
        if (parameters.containsKey("billing_permission") && !(parameters.get("billing_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: billing_permission must be of type boolean parameters[\"billing_permission\"]");
        }
        if (parameters.containsKey("bypass_inactive_disable") && !(parameters.get("bypass_inactive_disable") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: bypass_inactive_disable must be of type boolean parameters[\"bypass_inactive_disable\"]");
        }
        if (parameters.containsKey("bypass_site_allowed_ips") && !(parameters.get("bypass_site_allowed_ips") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: bypass_site_allowed_ips must be of type boolean parameters[\"bypass_site_allowed_ips\"]");
        }
        if (parameters.containsKey("dav_permission") && !(parameters.get("dav_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: dav_permission must be of type boolean parameters[\"dav_permission\"]");
        }
        if (parameters.containsKey("disabled") && !(parameters.get("disabled") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: disabled must be of type boolean parameters[\"disabled\"]");
        }
        if (parameters.containsKey("ftp_permission") && !(parameters.get("ftp_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: ftp_permission must be of type boolean parameters[\"ftp_permission\"]");
        }
        if (parameters.containsKey("language") && !(parameters.get("language") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: language must be of type String parameters[\"language\"]");
        }
        if (parameters.containsKey("notification_daily_send_time") && !(parameters.get("notification_daily_send_time") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: notification_daily_send_time must be of type Long parameters[\"notification_daily_send_time\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("notes") && !(parameters.get("notes") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: notes must be of type String parameters[\"notes\"]");
        }
        if (parameters.containsKey("password_validity_days") && !(parameters.get("password_validity_days") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: password_validity_days must be of type Long parameters[\"password_validity_days\"]");
        }
        if (parameters.containsKey("receive_admin_alerts") && !(parameters.get("receive_admin_alerts") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: receive_admin_alerts must be of type boolean parameters[\"receive_admin_alerts\"]");
        }
        if (parameters.containsKey("require_password_change") && !(parameters.get("require_password_change") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: require_password_change must be of type boolean parameters[\"require_password_change\"]");
        }
        if (parameters.containsKey("restapi_permission") && !(parameters.get("restapi_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: restapi_permission must be of type boolean parameters[\"restapi_permission\"]");
        }
        if (parameters.containsKey("self_managed") && !(parameters.get("self_managed") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: self_managed must be of type boolean parameters[\"self_managed\"]");
        }
        if (parameters.containsKey("sftp_permission") && !(parameters.get("sftp_permission") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: sftp_permission must be of type boolean parameters[\"sftp_permission\"]");
        }
        if (parameters.containsKey("site_admin") && !(parameters.get("site_admin") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: site_admin must be of type boolean parameters[\"site_admin\"]");
        }
        if (parameters.containsKey("skip_welcome_screen") && !(parameters.get("skip_welcome_screen") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: skip_welcome_screen must be of type boolean parameters[\"skip_welcome_screen\"]");
        }
        if (parameters.containsKey("ssl_required") && !(parameters.get("ssl_required") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ssl_required must be of type String parameters[\"ssl_required\"]");
        }
        if (parameters.containsKey("sso_strategy_id") && !(parameters.get("sso_strategy_id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: sso_strategy_id must be of type Long parameters[\"sso_strategy_id\"]");
        }
        if (parameters.containsKey("subscribe_to_newsletter") && !(parameters.get("subscribe_to_newsletter") instanceof boolean ))
        {
            throw new IllegalArgumentException("Bad parameter: subscribe_to_newsletter must be of type boolean parameters[\"subscribe_to_newsletter\"]");
        }
        if (parameters.containsKey("time_zone") && !(parameters.get("time_zone") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: time_zone must be of type String parameters[\"time_zone\"]");
        }
        if (parameters.containsKey("user_root") && !(parameters.get("user_root") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: user_root must be of type String parameters[\"user_root\"]");
        }
        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
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
    public static User delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static User destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


