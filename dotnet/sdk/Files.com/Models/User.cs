
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class User
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public User()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("username", null);
            this.attributes.Add("admin_group_ids", new object[0]);
            this.attributes.Add("allowed_ips", null);
            this.attributes.Add("attachments_permission", false);
            this.attributes.Add("api_keys_count", null);
            this.attributes.Add("authenticate_until", null);
            this.attributes.Add("authentication_method", null);
            this.attributes.Add("avatar_url", null);
            this.attributes.Add("billing_permission", false);
            this.attributes.Add("bypass_site_allowed_ips", false);
            this.attributes.Add("bypass_inactive_disable", false);
            this.attributes.Add("created_at", null);
            this.attributes.Add("dav_permission", false);
            this.attributes.Add("disabled", false);
            this.attributes.Add("email", "");
            this.attributes.Add("ftp_permission", false);
            this.attributes.Add("group_ids", new object[0]);
            this.attributes.Add("language", null);
            this.attributes.Add("last_login_at", null);
            this.attributes.Add("last_protocol_cipher", null);
            this.attributes.Add("lockout_expires", null);
            this.attributes.Add("name", null);
            this.attributes.Add("notes", null);
            this.attributes.Add("notification_daily_send_time", null);
            this.attributes.Add("password_set_at", null);
            this.attributes.Add("password_validity_days", null);
            this.attributes.Add("public_keys_count", null);
            this.attributes.Add("receive_admin_alerts", false);
            this.attributes.Add("require_2fa", false);
            this.attributes.Add("require_password_change", false);
            this.attributes.Add("restapi_permission", false);
            this.attributes.Add("self_managed", false);
            this.attributes.Add("sftp_permission", false);
            this.attributes.Add("site_admin", false);
            this.attributes.Add("skip_welcome_screen", false);
            this.attributes.Add("ssl_required", null);
            this.attributes.Add("sso_strategy_id", null);
            this.attributes.Add("subscribe_to_newsletter", false);
            this.attributes.Add("externally_managed", false);
            this.attributes.Add("time_zone", null);
            this.attributes.Add("type_of_2fa", null);
            this.attributes.Add("user_root", null);
            this.attributes.Add("avatar_file", null);
            this.attributes.Add("avatar_delete", false);
            this.attributes.Add("change_password", null);
            this.attributes.Add("change_password_confirmation", null);
            this.attributes.Add("grant_permission", null);
            this.attributes.Add("group_id", null);
            this.attributes.Add("password", null);
            this.attributes.Add("password_confirmation", null);
            this.attributes.Add("announcements_read", false);
        }

        public User(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// User ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// User's username
        /// </summary>
        [JsonPropertyName("username")]
        public string Username
        {
            get { return (string) attributes["username"]; }
            set { attributes["username"] = value; }
        }

        /// <summary>
        /// List of group IDs of which this user is an administrator
        /// </summary>
        [JsonPropertyName("admin_group_ids")]
        public object[] AdminGroupIds
        {
            get { return (object[]) attributes["admin_group_ids"]; }
            set { attributes["admin_group_ids"] = value; }
        }

        /// <summary>
        /// A list of allowed IPs if applicable.  Newline delimited
        /// </summary>
        [JsonPropertyName("allowed_ips")]
        public string AllowedIps
        {
            get { return (string) attributes["allowed_ips"]; }
            set { attributes["allowed_ips"] = value; }
        }

        /// <summary>
        /// Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
        /// </summary>
        [JsonPropertyName("attachments_permission")]
        public bool AttachmentsPermission
        {
            get { return (bool) attributes["attachments_permission"]; }
            set { attributes["attachments_permission"] = value; }
        }

        /// <summary>
        /// Number of api keys associated with this user
        /// </summary>
        [JsonPropertyName("api_keys_count")]
        public Nullable<Int64> ApiKeysCount
        {
            get { return (Nullable<Int64>) attributes["api_keys_count"]; }
            set { attributes["api_keys_count"] = value; }
        }

        /// <summary>
        /// Scheduled Date/Time at which user will be deactivated
        /// </summary>
        [JsonPropertyName("authenticate_until")]
        public Nullable<DateTime> AuthenticateUntil
        {
            get { return (Nullable<DateTime>) attributes["authenticate_until"]; }
            set { attributes["authenticate_until"] = value; }
        }

        /// <summary>
        /// How is this user authenticated?
        /// </summary>
        [JsonPropertyName("authentication_method")]
        public string AuthenticationMethod
        {
            get { return (string) attributes["authentication_method"]; }
            set { attributes["authentication_method"] = value; }
        }

        /// <summary>
        /// URL holding the user's avatar
        /// </summary>
        [JsonPropertyName("avatar_url")]
        public string AvatarUrl
        {
            get { return (string) attributes["avatar_url"]; }
            set { attributes["avatar_url"] = value; }
        }

        /// <summary>
        /// Allow this user to perform operations on the account, payments, and invoices?
        /// </summary>
        [JsonPropertyName("billing_permission")]
        public bool BillingPermission
        {
            get { return (bool) attributes["billing_permission"]; }
            set { attributes["billing_permission"] = value; }
        }

        /// <summary>
        /// Allow this user to skip site-wide IP blacklists?
        /// </summary>
        [JsonPropertyName("bypass_site_allowed_ips")]
        public bool BypassSiteAllowedIps
        {
            get { return (bool) attributes["bypass_site_allowed_ips"]; }
            set { attributes["bypass_site_allowed_ips"] = value; }
        }

        /// <summary>
        /// Exempt this user from being disabled based on inactivity?
        /// </summary>
        [JsonPropertyName("bypass_inactive_disable")]
        public bool BypassInactiveDisable
        {
            get { return (bool) attributes["bypass_inactive_disable"]; }
            set { attributes["bypass_inactive_disable"] = value; }
        }

        /// <summary>
        /// When this user was created
        /// </summary>
        [JsonPropertyName("created_at")]
        public Nullable<DateTime> CreatedAt
        {
            get { return (Nullable<DateTime>) attributes["created_at"]; }
        }

        /// <summary>
        /// Can the user connect with WebDAV?
        /// </summary>
        [JsonPropertyName("dav_permission")]
        public bool DavPermission
        {
            get { return (bool) attributes["dav_permission"]; }
            set { attributes["dav_permission"] = value; }
        }

        /// <summary>
        /// Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
        /// </summary>
        [JsonPropertyName("disabled")]
        public bool Disabled
        {
            get { return (bool) attributes["disabled"]; }
            set { attributes["disabled"] = value; }
        }

        /// <summary>
        /// User email address
        /// </summary>
        [JsonPropertyName("email")]
        public string Email
        {
            get { return (string) attributes["email"]; }
            set { attributes["email"] = value; }
        }

        /// <summary>
        /// Can the user access with FTP/FTPS?
        /// </summary>
        [JsonPropertyName("ftp_permission")]
        public bool FtpPermission
        {
            get { return (bool) attributes["ftp_permission"]; }
            set { attributes["ftp_permission"] = value; }
        }

        /// <summary>
        /// Comma-separated list of group IDs of which this user is a member
        /// </summary>
        [JsonPropertyName("group_ids")]
        public object[] GroupIds
        {
            get { return (object[]) attributes["group_ids"]; }
            set { attributes["group_ids"] = value; }
        }

        /// <summary>
        /// Preferred language
        /// </summary>
        [JsonPropertyName("language")]
        public string Language
        {
            get { return (string) attributes["language"]; }
            set { attributes["language"] = value; }
        }

        /// <summary>
        /// User's last login time
        /// </summary>
        [JsonPropertyName("last_login_at")]
        public Nullable<DateTime> LastLoginAt
        {
            get { return (Nullable<DateTime>) attributes["last_login_at"]; }
            set { attributes["last_login_at"] = value; }
        }

        /// <summary>
        /// The last protocol and cipher used
        /// </summary>
        [JsonPropertyName("last_protocol_cipher")]
        public string LastProtocolCipher
        {
            get { return (string) attributes["last_protocol_cipher"]; }
            set { attributes["last_protocol_cipher"] = value; }
        }

        /// <summary>
        /// Time in the future that the user will no longer be locked out if applicable
        /// </summary>
        [JsonPropertyName("lockout_expires")]
        public Nullable<DateTime> LockoutExpires
        {
            get { return (Nullable<DateTime>) attributes["lockout_expires"]; }
            set { attributes["lockout_expires"] = value; }
        }

        /// <summary>
        /// User's full name
        /// </summary>
        [JsonPropertyName("name")]
        public string Name
        {
            get { return (string) attributes["name"]; }
            set { attributes["name"] = value; }
        }

        /// <summary>
        /// Any internal notes on the user
        /// </summary>
        [JsonPropertyName("notes")]
        public string Notes
        {
            get { return (string) attributes["notes"]; }
            set { attributes["notes"] = value; }
        }

        /// <summary>
        /// Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
        /// </summary>
        [JsonPropertyName("notification_daily_send_time")]
        public Nullable<Int64> NotificationDailySendTime
        {
            get { return (Nullable<Int64>) attributes["notification_daily_send_time"]; }
            set { attributes["notification_daily_send_time"] = value; }
        }

        /// <summary>
        /// Last time the user's password was set
        /// </summary>
        [JsonPropertyName("password_set_at")]
        public Nullable<DateTime> PasswordSetAt
        {
            get { return (Nullable<DateTime>) attributes["password_set_at"]; }
            set { attributes["password_set_at"] = value; }
        }

        /// <summary>
        /// Number of days to allow user to use the same password
        /// </summary>
        [JsonPropertyName("password_validity_days")]
        public Nullable<Int64> PasswordValidityDays
        {
            get { return (Nullable<Int64>) attributes["password_validity_days"]; }
            set { attributes["password_validity_days"] = value; }
        }

        /// <summary>
        /// Number of public keys associated with this user
        /// </summary>
        [JsonPropertyName("public_keys_count")]
        public Nullable<Int64> PublicKeysCount
        {
            get { return (Nullable<Int64>) attributes["public_keys_count"]; }
            set { attributes["public_keys_count"] = value; }
        }

        /// <summary>
        /// Should the user receive admin alerts such a certificate expiration notifications and overages?
        /// </summary>
        [JsonPropertyName("receive_admin_alerts")]
        public bool ReceiveAdminAlerts
        {
            get { return (bool) attributes["receive_admin_alerts"]; }
            set { attributes["receive_admin_alerts"] = value; }
        }

        /// <summary>
        /// Is 2fa required to sign in?
        /// </summary>
        [JsonPropertyName("require_2fa")]
        public bool Require2fa
        {
            get { return (bool) attributes["require_2fa"]; }
            set { attributes["require_2fa"] = value; }
        }

        /// <summary>
        /// Is a password change required upon next user login?
        /// </summary>
        [JsonPropertyName("require_password_change")]
        public bool RequirePasswordChange
        {
            get { return (bool) attributes["require_password_change"]; }
            set { attributes["require_password_change"] = value; }
        }

        /// <summary>
        /// Can this user access the REST API?
        /// </summary>
        [JsonPropertyName("restapi_permission")]
        public bool RestapiPermission
        {
            get { return (bool) attributes["restapi_permission"]; }
            set { attributes["restapi_permission"] = value; }
        }

        /// <summary>
        /// Does this user manage it's own credentials or is it a shared/bot user?
        /// </summary>
        [JsonPropertyName("self_managed")]
        public bool SelfManaged
        {
            get { return (bool) attributes["self_managed"]; }
            set { attributes["self_managed"] = value; }
        }

        /// <summary>
        /// Can the user access with SFTP?
        /// </summary>
        [JsonPropertyName("sftp_permission")]
        public bool SftpPermission
        {
            get { return (bool) attributes["sftp_permission"]; }
            set { attributes["sftp_permission"] = value; }
        }

        /// <summary>
        /// Is the user an administrator for this site?
        /// </summary>
        [JsonPropertyName("site_admin")]
        public bool SiteAdmin
        {
            get { return (bool) attributes["site_admin"]; }
            set { attributes["site_admin"] = value; }
        }

        /// <summary>
        /// Skip Welcome page in the UI?
        /// </summary>
        [JsonPropertyName("skip_welcome_screen")]
        public bool SkipWelcomeScreen
        {
            get { return (bool) attributes["skip_welcome_screen"]; }
            set { attributes["skip_welcome_screen"] = value; }
        }

        /// <summary>
        /// SSL required setting
        /// </summary>
        [JsonPropertyName("ssl_required")]
        public string SslRequired
        {
            get { return (string) attributes["ssl_required"]; }
            set { attributes["ssl_required"] = value; }
        }

        /// <summary>
        /// SSO (Single Sign On) strategy ID for the user, if applicable.
        /// </summary>
        [JsonPropertyName("sso_strategy_id")]
        public Nullable<Int64> SsoStrategyId
        {
            get { return (Nullable<Int64>) attributes["sso_strategy_id"]; }
            set { attributes["sso_strategy_id"] = value; }
        }

        /// <summary>
        /// Is the user subscribed to the newsletter?
        /// </summary>
        [JsonPropertyName("subscribe_to_newsletter")]
        public bool SubscribeToNewsletter
        {
            get { return (bool) attributes["subscribe_to_newsletter"]; }
            set { attributes["subscribe_to_newsletter"] = value; }
        }

        /// <summary>
        /// Is this user managed by an external source (such as LDAP)?
        /// </summary>
        [JsonPropertyName("externally_managed")]
        public bool ExternallyManaged
        {
            get { return (bool) attributes["externally_managed"]; }
            set { attributes["externally_managed"] = value; }
        }

        /// <summary>
        /// User time zone
        /// </summary>
        [JsonPropertyName("time_zone")]
        public string TimeZone
        {
            get { return (string) attributes["time_zone"]; }
            set { attributes["time_zone"] = value; }
        }

        /// <summary>
        /// Type(s) of 2FA methods in use.  Will be either `sms`, `totp`, `u2f`, `yubi`, or multiple values sorted alphabetically and joined by an underscore.
        /// </summary>
        [JsonPropertyName("type_of_2fa")]
        public string TypeOf2fa
        {
            get { return (string) attributes["type_of_2fa"]; }
            set { attributes["type_of_2fa"] = value; }
        }

        /// <summary>
        /// Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
        /// </summary>
        [JsonPropertyName("user_root")]
        public string UserRoot
        {
            get { return (string) attributes["user_root"]; }
            set { attributes["user_root"] = value; }
        }

        /// <summary>
        /// An image file for your user avatar.
        /// </summary>
        [JsonPropertyName("avatar_file")]
        public System.Net.Http.ByteArrayContent AvatarFile
        {
            get { return (System.Net.Http.ByteArrayContent) attributes["avatar_file"]; }
            set { attributes["avatar_file"] = value; }
        }

        /// <summary>
        /// If true, the avatar will be deleted.
        /// </summary>
        [JsonPropertyName("avatar_delete")]
        public bool AvatarDelete
        {
            get { return (bool) attributes["avatar_delete"]; }
            set { attributes["avatar_delete"] = value; }
        }

        /// <summary>
        /// Used for changing a password on an existing user.
        /// </summary>
        [JsonPropertyName("change_password")]
        public string ChangePassword
        {
            get { return (string) attributes["change_password"]; }
            set { attributes["change_password"] = value; }
        }

        /// <summary>
        /// Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
        /// </summary>
        [JsonPropertyName("change_password_confirmation")]
        public string ChangePasswordConfirmation
        {
            get { return (string) attributes["change_password_confirmation"]; }
            set { attributes["change_password_confirmation"] = value; }
        }

        /// <summary>
        /// Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
        /// </summary>
        [JsonPropertyName("grant_permission")]
        public string GrantPermission
        {
            get { return (string) attributes["grant_permission"]; }
            set { attributes["grant_permission"] = value; }
        }

        /// <summary>
        /// Group ID to associate this user with.
        /// </summary>
        [JsonPropertyName("group_id")]
        public Nullable<Int64> GroupId
        {
            get { return (Nullable<Int64>) attributes["group_id"]; }
            set { attributes["group_id"] = value; }
        }

        /// <summary>
        /// User password.
        /// </summary>
        [JsonPropertyName("password")]
        public string Password
        {
            get { return (string) attributes["password"]; }
            set { attributes["password"] = value; }
        }

        /// <summary>
        /// Optional, but if provided, we will ensure that it matches the value sent in `password`.
        /// </summary>
        [JsonPropertyName("password_confirmation")]
        public string PasswordConfirmation
        {
            get { return (string) attributes["password_confirmation"]; }
            set { attributes["password_confirmation"] = value; }
        }

        /// <summary>
        /// Signifies that the user has read all the announcements in the UI.
        /// </summary>
        [JsonPropertyName("announcements_read")]
        public bool AnnouncementsRead
        {
            get { return (bool) attributes["announcements_read"]; }
            set { attributes["announcements_read"] = value; }
        }

        /// <summary>
        /// Unlock user who has been locked out due to failed logins
        /// </summary>
        public async Task<User> Unlock(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// Resend user welcome email
        /// </summary>
        public async Task<User> ResendWelcomeEmail(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
        /// </summary>
        public async Task<User> User2faReset(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// Parameters:
        ///   avatar_file - file - An image file for your user avatar.
        ///   avatar_delete - boolean - If true, the avatar will be deleted.
        ///   change_password - string - Used for changing a password on an existing user.
        ///   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
        ///   email - string - User's email.
        ///   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
        ///   group_id - integer - Group ID to associate this user with.
        ///   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
        ///   password - string - User password.
        ///   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
        ///   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
        ///   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
        ///   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
        ///   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
        ///   authentication_method - string - How is this user authenticated?
        ///   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
        ///   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
        ///   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
        ///   dav_permission - boolean - Can the user connect with WebDAV?
        ///   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
        ///   ftp_permission - boolean - Can the user access with FTP/FTPS?
        ///   language - string - Preferred language
        ///   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
        ///   name - string - User's full name
        ///   notes - string - Any internal notes on the user
        ///   password_validity_days - integer - Number of days to allow user to use the same password
        ///   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
        ///   require_password_change - boolean - Is a password change required upon next user login?
        ///   restapi_permission - boolean - Can this user access the REST API?
        ///   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
        ///   sftp_permission - boolean - Can the user access with SFTP?
        ///   site_admin - boolean - Is the user an administrator for this site?
        ///   skip_welcome_screen - boolean - Skip Welcome page in the UI?
        ///   ssl_required - string - SSL required setting
        ///   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
        ///   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
        ///   time_zone - string - User time zone
        ///   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
        ///   username - string - User's username
        /// </summary>
        public async Task<User> Update(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// </summary>
        public async Task<User> Delete(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }

        public async void Destroy(Dictionary<string, object> parameters)
        {
            Delete(parameters);
        }


        public async Task Save()
        {
            if (this.attributes["id"] != null)
            {
                await this.Update(this.attributes);
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (User) await User.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   q[username] - string - List users matching username.
        ///   q[email] - string - List users matching email.
        ///   q[notes] - string - List users matching notes field.
        ///   q[admin] - string - If `true`, list only admin users.
        ///   q[allowed_ips] - string - If set, list only users with overridden allowed IP setting.
        ///   q[password_validity_days] - string - If set, list only users with overridden password validity days setting.
        ///   q[ssl_required] - string - If set, list only users with overridden SSL required setting.
        ///   search - string - Searches for partial matches of name, username, or email.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> List(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            if (parameters.ContainsKey("page") && !(parameters["page"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: page must be of type Nullable<Int64>", "parameters[\"page\"]");
            }
            if (parameters.ContainsKey("per_page") && !(parameters["per_page"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: per_page must be of type Nullable<Int64>", "parameters[\"per_page\"]");
            }
            if (parameters.ContainsKey("action") && !(parameters["action"] is string ))
            {
                throw new ArgumentException("Bad parameter: action must be of type string", "parameters[\"action\"]");
            }
            if (parameters.ContainsKey("search") && !(parameters["search"] is string ))
            {
                throw new ArgumentException("Bad parameter: search must be of type string", "parameters[\"search\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<User[]>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> All(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await List(parameters, options);
        }

        /// <summary>
        /// Parameters:
        ///   id (required) - integer - User ID.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Find(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<User>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Get(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await Find(id, parameters, options);
        }

        /// <summary>
        /// Parameters:
        ///   avatar_file - file - An image file for your user avatar.
        ///   avatar_delete - boolean - If true, the avatar will be deleted.
        ///   change_password - string - Used for changing a password on an existing user.
        ///   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
        ///   email - string - User's email.
        ///   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
        ///   group_id - integer - Group ID to associate this user with.
        ///   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
        ///   password - string - User password.
        ///   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
        ///   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
        ///   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
        ///   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
        ///   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
        ///   authentication_method - string - How is this user authenticated?
        ///   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
        ///   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
        ///   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
        ///   dav_permission - boolean - Can the user connect with WebDAV?
        ///   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
        ///   ftp_permission - boolean - Can the user access with FTP/FTPS?
        ///   language - string - Preferred language
        ///   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
        ///   name - string - User's full name
        ///   notes - string - Any internal notes on the user
        ///   password_validity_days - integer - Number of days to allow user to use the same password
        ///   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
        ///   require_password_change - boolean - Is a password change required upon next user login?
        ///   restapi_permission - boolean - Can this user access the REST API?
        ///   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
        ///   sftp_permission - boolean - Can the user access with SFTP?
        ///   site_admin - boolean - Is the user an administrator for this site?
        ///   skip_welcome_screen - boolean - Skip Welcome page in the UI?
        ///   ssl_required - string - SSL required setting
        ///   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
        ///   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
        ///   time_zone - string - User time zone
        ///   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
        ///   username - string - User's username
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Create(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            if (parameters.ContainsKey("avatar_file") && !(parameters["avatar_file"] is System.Net.Http.ByteArrayContent ))
            {
                throw new ArgumentException("Bad parameter: avatar_file must be of type System.Net.Http.ByteArrayContent", "parameters[\"avatar_file\"]");
            }
            if (parameters.ContainsKey("avatar_delete") && !(parameters["avatar_delete"] is bool ))
            {
                throw new ArgumentException("Bad parameter: avatar_delete must be of type bool", "parameters[\"avatar_delete\"]");
            }
            if (parameters.ContainsKey("change_password") && !(parameters["change_password"] is string ))
            {
                throw new ArgumentException("Bad parameter: change_password must be of type string", "parameters[\"change_password\"]");
            }
            if (parameters.ContainsKey("change_password_confirmation") && !(parameters["change_password_confirmation"] is string ))
            {
                throw new ArgumentException("Bad parameter: change_password_confirmation must be of type string", "parameters[\"change_password_confirmation\"]");
            }
            if (parameters.ContainsKey("email") && !(parameters["email"] is string ))
            {
                throw new ArgumentException("Bad parameter: email must be of type string", "parameters[\"email\"]");
            }
            if (parameters.ContainsKey("grant_permission") && !(parameters["grant_permission"] is string ))
            {
                throw new ArgumentException("Bad parameter: grant_permission must be of type string", "parameters[\"grant_permission\"]");
            }
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type Nullable<Int64>", "parameters[\"group_id\"]");
            }
            if (parameters.ContainsKey("group_ids") && !(parameters["group_ids"] is string ))
            {
                throw new ArgumentException("Bad parameter: group_ids must be of type string", "parameters[\"group_ids\"]");
            }
            if (parameters.ContainsKey("password") && !(parameters["password"] is string ))
            {
                throw new ArgumentException("Bad parameter: password must be of type string", "parameters[\"password\"]");
            }
            if (parameters.ContainsKey("password_confirmation") && !(parameters["password_confirmation"] is string ))
            {
                throw new ArgumentException("Bad parameter: password_confirmation must be of type string", "parameters[\"password_confirmation\"]");
            }
            if (parameters.ContainsKey("announcements_read") && !(parameters["announcements_read"] is bool ))
            {
                throw new ArgumentException("Bad parameter: announcements_read must be of type bool", "parameters[\"announcements_read\"]");
            }
            if (parameters.ContainsKey("allowed_ips") && !(parameters["allowed_ips"] is string ))
            {
                throw new ArgumentException("Bad parameter: allowed_ips must be of type string", "parameters[\"allowed_ips\"]");
            }
            if (parameters.ContainsKey("attachments_permission") && !(parameters["attachments_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: attachments_permission must be of type bool", "parameters[\"attachments_permission\"]");
            }
            if (parameters.ContainsKey("authenticate_until") && !(parameters["authenticate_until"] is string ))
            {
                throw new ArgumentException("Bad parameter: authenticate_until must be of type string", "parameters[\"authenticate_until\"]");
            }
            if (parameters.ContainsKey("authentication_method") && !(parameters["authentication_method"] is string ))
            {
                throw new ArgumentException("Bad parameter: authentication_method must be of type string", "parameters[\"authentication_method\"]");
            }
            if (parameters.ContainsKey("billing_permission") && !(parameters["billing_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: billing_permission must be of type bool", "parameters[\"billing_permission\"]");
            }
            if (parameters.ContainsKey("bypass_inactive_disable") && !(parameters["bypass_inactive_disable"] is bool ))
            {
                throw new ArgumentException("Bad parameter: bypass_inactive_disable must be of type bool", "parameters[\"bypass_inactive_disable\"]");
            }
            if (parameters.ContainsKey("bypass_site_allowed_ips") && !(parameters["bypass_site_allowed_ips"] is bool ))
            {
                throw new ArgumentException("Bad parameter: bypass_site_allowed_ips must be of type bool", "parameters[\"bypass_site_allowed_ips\"]");
            }
            if (parameters.ContainsKey("dav_permission") && !(parameters["dav_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: dav_permission must be of type bool", "parameters[\"dav_permission\"]");
            }
            if (parameters.ContainsKey("disabled") && !(parameters["disabled"] is bool ))
            {
                throw new ArgumentException("Bad parameter: disabled must be of type bool", "parameters[\"disabled\"]");
            }
            if (parameters.ContainsKey("ftp_permission") && !(parameters["ftp_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: ftp_permission must be of type bool", "parameters[\"ftp_permission\"]");
            }
            if (parameters.ContainsKey("language") && !(parameters["language"] is string ))
            {
                throw new ArgumentException("Bad parameter: language must be of type string", "parameters[\"language\"]");
            }
            if (parameters.ContainsKey("notification_daily_send_time") && !(parameters["notification_daily_send_time"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: notification_daily_send_time must be of type Nullable<Int64>", "parameters[\"notification_daily_send_time\"]");
            }
            if (parameters.ContainsKey("name") && !(parameters["name"] is string ))
            {
                throw new ArgumentException("Bad parameter: name must be of type string", "parameters[\"name\"]");
            }
            if (parameters.ContainsKey("notes") && !(parameters["notes"] is string ))
            {
                throw new ArgumentException("Bad parameter: notes must be of type string", "parameters[\"notes\"]");
            }
            if (parameters.ContainsKey("password_validity_days") && !(parameters["password_validity_days"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: password_validity_days must be of type Nullable<Int64>", "parameters[\"password_validity_days\"]");
            }
            if (parameters.ContainsKey("receive_admin_alerts") && !(parameters["receive_admin_alerts"] is bool ))
            {
                throw new ArgumentException("Bad parameter: receive_admin_alerts must be of type bool", "parameters[\"receive_admin_alerts\"]");
            }
            if (parameters.ContainsKey("require_password_change") && !(parameters["require_password_change"] is bool ))
            {
                throw new ArgumentException("Bad parameter: require_password_change must be of type bool", "parameters[\"require_password_change\"]");
            }
            if (parameters.ContainsKey("restapi_permission") && !(parameters["restapi_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: restapi_permission must be of type bool", "parameters[\"restapi_permission\"]");
            }
            if (parameters.ContainsKey("self_managed") && !(parameters["self_managed"] is bool ))
            {
                throw new ArgumentException("Bad parameter: self_managed must be of type bool", "parameters[\"self_managed\"]");
            }
            if (parameters.ContainsKey("sftp_permission") && !(parameters["sftp_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: sftp_permission must be of type bool", "parameters[\"sftp_permission\"]");
            }
            if (parameters.ContainsKey("site_admin") && !(parameters["site_admin"] is bool ))
            {
                throw new ArgumentException("Bad parameter: site_admin must be of type bool", "parameters[\"site_admin\"]");
            }
            if (parameters.ContainsKey("skip_welcome_screen") && !(parameters["skip_welcome_screen"] is bool ))
            {
                throw new ArgumentException("Bad parameter: skip_welcome_screen must be of type bool", "parameters[\"skip_welcome_screen\"]");
            }
            if (parameters.ContainsKey("ssl_required") && !(parameters["ssl_required"] is string ))
            {
                throw new ArgumentException("Bad parameter: ssl_required must be of type string", "parameters[\"ssl_required\"]");
            }
            if (parameters.ContainsKey("sso_strategy_id") && !(parameters["sso_strategy_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: sso_strategy_id must be of type Nullable<Int64>", "parameters[\"sso_strategy_id\"]");
            }
            if (parameters.ContainsKey("subscribe_to_newsletter") && !(parameters["subscribe_to_newsletter"] is bool ))
            {
                throw new ArgumentException("Bad parameter: subscribe_to_newsletter must be of type bool", "parameters[\"subscribe_to_newsletter\"]");
            }
            if (parameters.ContainsKey("time_zone") && !(parameters["time_zone"] is string ))
            {
                throw new ArgumentException("Bad parameter: time_zone must be of type string", "parameters[\"time_zone\"]");
            }
            if (parameters.ContainsKey("user_root") && !(parameters["user_root"] is string ))
            {
                throw new ArgumentException("Bad parameter: user_root must be of type string", "parameters[\"user_root\"]");
            }
            if (parameters.ContainsKey("username") && !(parameters["username"] is string ))
            {
                throw new ArgumentException("Bad parameter: username must be of type string", "parameters[\"username\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<User>(responseJson);
        }


        /// <summary>
        /// Unlock user who has been locked out due to failed logins
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Unlock(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}/unlock", HttpMethod.Post, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }


        /// <summary>
        /// Resend user welcome email
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> ResendWelcomeEmail(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}/resend_welcome_email", HttpMethod.Post, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }


        /// <summary>
        /// Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> User2faReset(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}/2fa/reset", HttpMethod.Post, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }


        /// <summary>
        /// Parameters:
        ///   avatar_file - file - An image file for your user avatar.
        ///   avatar_delete - boolean - If true, the avatar will be deleted.
        ///   change_password - string - Used for changing a password on an existing user.
        ///   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
        ///   email - string - User's email.
        ///   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
        ///   group_id - integer - Group ID to associate this user with.
        ///   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
        ///   password - string - User password.
        ///   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
        ///   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
        ///   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
        ///   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
        ///   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
        ///   authentication_method - string - How is this user authenticated?
        ///   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
        ///   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
        ///   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
        ///   dav_permission - boolean - Can the user connect with WebDAV?
        ///   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
        ///   ftp_permission - boolean - Can the user access with FTP/FTPS?
        ///   language - string - Preferred language
        ///   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
        ///   name - string - User's full name
        ///   notes - string - Any internal notes on the user
        ///   password_validity_days - integer - Number of days to allow user to use the same password
        ///   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
        ///   require_password_change - boolean - Is a password change required upon next user login?
        ///   restapi_permission - boolean - Can this user access the REST API?
        ///   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
        ///   sftp_permission - boolean - Can the user access with SFTP?
        ///   site_admin - boolean - Is the user an administrator for this site?
        ///   skip_welcome_screen - boolean - Skip Welcome page in the UI?
        ///   ssl_required - string - SSL required setting
        ///   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
        ///   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
        ///   time_zone - string - User time zone
        ///   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
        ///   username - string - User's username
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Update(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (parameters.ContainsKey("avatar_file") && !(parameters["avatar_file"] is System.Net.Http.ByteArrayContent ))
            {
                throw new ArgumentException("Bad parameter: avatar_file must be of type System.Net.Http.ByteArrayContent", "parameters[\"avatar_file\"]");
            }
            if (parameters.ContainsKey("avatar_delete") && !(parameters["avatar_delete"] is bool ))
            {
                throw new ArgumentException("Bad parameter: avatar_delete must be of type bool", "parameters[\"avatar_delete\"]");
            }
            if (parameters.ContainsKey("change_password") && !(parameters["change_password"] is string ))
            {
                throw new ArgumentException("Bad parameter: change_password must be of type string", "parameters[\"change_password\"]");
            }
            if (parameters.ContainsKey("change_password_confirmation") && !(parameters["change_password_confirmation"] is string ))
            {
                throw new ArgumentException("Bad parameter: change_password_confirmation must be of type string", "parameters[\"change_password_confirmation\"]");
            }
            if (parameters.ContainsKey("email") && !(parameters["email"] is string ))
            {
                throw new ArgumentException("Bad parameter: email must be of type string", "parameters[\"email\"]");
            }
            if (parameters.ContainsKey("grant_permission") && !(parameters["grant_permission"] is string ))
            {
                throw new ArgumentException("Bad parameter: grant_permission must be of type string", "parameters[\"grant_permission\"]");
            }
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type Nullable<Int64>", "parameters[\"group_id\"]");
            }
            if (parameters.ContainsKey("group_ids") && !(parameters["group_ids"] is string ))
            {
                throw new ArgumentException("Bad parameter: group_ids must be of type string", "parameters[\"group_ids\"]");
            }
            if (parameters.ContainsKey("password") && !(parameters["password"] is string ))
            {
                throw new ArgumentException("Bad parameter: password must be of type string", "parameters[\"password\"]");
            }
            if (parameters.ContainsKey("password_confirmation") && !(parameters["password_confirmation"] is string ))
            {
                throw new ArgumentException("Bad parameter: password_confirmation must be of type string", "parameters[\"password_confirmation\"]");
            }
            if (parameters.ContainsKey("announcements_read") && !(parameters["announcements_read"] is bool ))
            {
                throw new ArgumentException("Bad parameter: announcements_read must be of type bool", "parameters[\"announcements_read\"]");
            }
            if (parameters.ContainsKey("allowed_ips") && !(parameters["allowed_ips"] is string ))
            {
                throw new ArgumentException("Bad parameter: allowed_ips must be of type string", "parameters[\"allowed_ips\"]");
            }
            if (parameters.ContainsKey("attachments_permission") && !(parameters["attachments_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: attachments_permission must be of type bool", "parameters[\"attachments_permission\"]");
            }
            if (parameters.ContainsKey("authenticate_until") && !(parameters["authenticate_until"] is string ))
            {
                throw new ArgumentException("Bad parameter: authenticate_until must be of type string", "parameters[\"authenticate_until\"]");
            }
            if (parameters.ContainsKey("authentication_method") && !(parameters["authentication_method"] is string ))
            {
                throw new ArgumentException("Bad parameter: authentication_method must be of type string", "parameters[\"authentication_method\"]");
            }
            if (parameters.ContainsKey("billing_permission") && !(parameters["billing_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: billing_permission must be of type bool", "parameters[\"billing_permission\"]");
            }
            if (parameters.ContainsKey("bypass_inactive_disable") && !(parameters["bypass_inactive_disable"] is bool ))
            {
                throw new ArgumentException("Bad parameter: bypass_inactive_disable must be of type bool", "parameters[\"bypass_inactive_disable\"]");
            }
            if (parameters.ContainsKey("bypass_site_allowed_ips") && !(parameters["bypass_site_allowed_ips"] is bool ))
            {
                throw new ArgumentException("Bad parameter: bypass_site_allowed_ips must be of type bool", "parameters[\"bypass_site_allowed_ips\"]");
            }
            if (parameters.ContainsKey("dav_permission") && !(parameters["dav_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: dav_permission must be of type bool", "parameters[\"dav_permission\"]");
            }
            if (parameters.ContainsKey("disabled") && !(parameters["disabled"] is bool ))
            {
                throw new ArgumentException("Bad parameter: disabled must be of type bool", "parameters[\"disabled\"]");
            }
            if (parameters.ContainsKey("ftp_permission") && !(parameters["ftp_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: ftp_permission must be of type bool", "parameters[\"ftp_permission\"]");
            }
            if (parameters.ContainsKey("language") && !(parameters["language"] is string ))
            {
                throw new ArgumentException("Bad parameter: language must be of type string", "parameters[\"language\"]");
            }
            if (parameters.ContainsKey("notification_daily_send_time") && !(parameters["notification_daily_send_time"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: notification_daily_send_time must be of type Nullable<Int64>", "parameters[\"notification_daily_send_time\"]");
            }
            if (parameters.ContainsKey("name") && !(parameters["name"] is string ))
            {
                throw new ArgumentException("Bad parameter: name must be of type string", "parameters[\"name\"]");
            }
            if (parameters.ContainsKey("notes") && !(parameters["notes"] is string ))
            {
                throw new ArgumentException("Bad parameter: notes must be of type string", "parameters[\"notes\"]");
            }
            if (parameters.ContainsKey("password_validity_days") && !(parameters["password_validity_days"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: password_validity_days must be of type Nullable<Int64>", "parameters[\"password_validity_days\"]");
            }
            if (parameters.ContainsKey("receive_admin_alerts") && !(parameters["receive_admin_alerts"] is bool ))
            {
                throw new ArgumentException("Bad parameter: receive_admin_alerts must be of type bool", "parameters[\"receive_admin_alerts\"]");
            }
            if (parameters.ContainsKey("require_password_change") && !(parameters["require_password_change"] is bool ))
            {
                throw new ArgumentException("Bad parameter: require_password_change must be of type bool", "parameters[\"require_password_change\"]");
            }
            if (parameters.ContainsKey("restapi_permission") && !(parameters["restapi_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: restapi_permission must be of type bool", "parameters[\"restapi_permission\"]");
            }
            if (parameters.ContainsKey("self_managed") && !(parameters["self_managed"] is bool ))
            {
                throw new ArgumentException("Bad parameter: self_managed must be of type bool", "parameters[\"self_managed\"]");
            }
            if (parameters.ContainsKey("sftp_permission") && !(parameters["sftp_permission"] is bool ))
            {
                throw new ArgumentException("Bad parameter: sftp_permission must be of type bool", "parameters[\"sftp_permission\"]");
            }
            if (parameters.ContainsKey("site_admin") && !(parameters["site_admin"] is bool ))
            {
                throw new ArgumentException("Bad parameter: site_admin must be of type bool", "parameters[\"site_admin\"]");
            }
            if (parameters.ContainsKey("skip_welcome_screen") && !(parameters["skip_welcome_screen"] is bool ))
            {
                throw new ArgumentException("Bad parameter: skip_welcome_screen must be of type bool", "parameters[\"skip_welcome_screen\"]");
            }
            if (parameters.ContainsKey("ssl_required") && !(parameters["ssl_required"] is string ))
            {
                throw new ArgumentException("Bad parameter: ssl_required must be of type string", "parameters[\"ssl_required\"]");
            }
            if (parameters.ContainsKey("sso_strategy_id") && !(parameters["sso_strategy_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: sso_strategy_id must be of type Nullable<Int64>", "parameters[\"sso_strategy_id\"]");
            }
            if (parameters.ContainsKey("subscribe_to_newsletter") && !(parameters["subscribe_to_newsletter"] is bool ))
            {
                throw new ArgumentException("Bad parameter: subscribe_to_newsletter must be of type bool", "parameters[\"subscribe_to_newsletter\"]");
            }
            if (parameters.ContainsKey("time_zone") && !(parameters["time_zone"] is string ))
            {
                throw new ArgumentException("Bad parameter: time_zone must be of type string", "parameters[\"time_zone\"]");
            }
            if (parameters.ContainsKey("user_root") && !(parameters["user_root"] is string ))
            {
                throw new ArgumentException("Bad parameter: user_root must be of type string", "parameters[\"user_root\"]");
            }
            if (parameters.ContainsKey("username") && !(parameters["username"] is string ))
            {
                throw new ArgumentException("Bad parameter: username must be of type string", "parameters[\"username\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}", HttpMethod.Patch, parameters, options);

            return JsonSerializer.Deserialize<User>(responseJson);
        }


        /// <summary>
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Delete(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/users/{id}", HttpMethod.Delete, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Destroy(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await Delete(id, parameters, options);
        }

    }
}

