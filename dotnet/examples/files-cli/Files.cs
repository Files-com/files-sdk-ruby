using System.Threading.Tasks;
using Files.com;
using Files.com.Models;

namespace files_cli
{
    class Files
    {
        private static log4net.ILog log;

        static async Task Main(string[] args)
        {
		    log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            log.Info("Starting up");

            FilesClient filesClient = new FilesClient();
            User[] users = (User[]) await User.All();

            foreach(User user in users)
            {
		        log.Debug($"-------- User {user.Id} -----------");
		        log.Debug(user.Id);
		        log.Debug(user.Username);
		        log.Debug(user.AdminGroupIds);
		        log.Debug(user.AllowedIps);
		        log.Debug(user.AttachmentsPermission);
		        log.Debug(user.ApiKeysCount);
		        log.Debug(user.AuthenticateUntil);
		        log.Debug(user.AuthenticationMethod);
		        log.Debug(user.AvatarUrl);
		        log.Debug(user.BillingPermission);
		        log.Debug(user.BypassSiteAllowedIps);
		        log.Debug(user.CreatedAt);
		        log.Debug(user.DavPermission);
		        log.Debug(user.Disabled);
		        log.Debug(user.LastLoginAt);
		        log.Debug(user.LastProtocolCipher);
		        log.Debug(user.LockoutExpires);
		        log.Debug(user.Name);
		        log.Debug(user.Notes);
		        log.Debug(user.NotificationDailySendTime);
		        log.Debug(user.PasswordSetAt);
		        log.Debug(user.PasswordValidityDays);
		        log.Debug(user.PublicKeysCount);
		        log.Debug(user.ReceiveAdminAlerts);
		        log.Debug(user.Require2fa);
		        log.Debug(user.RequirePasswordChange);
		        log.Debug(user.RestapiPermission);
		        log.Debug(user.SelfManaged);
		        log.Debug(user.SftpPermission);
		        log.Debug(user.SiteAdmin);
		        log.Debug(user.SkipWelcomeScreen);
		        log.Debug(user.SslRequired);
		        log.Debug(user.SsoStrategyId);
		        log.Debug(user.SubscribeToNewsletter);
		        log.Debug(user.ExternallyManaged);
		        log.Debug(user.TimeZone);
		        log.Debug(user.TypeOf2fa);
		        log.Debug(user.UserRoot);
	        }

            log.Info("Complete");
        }
    }
}
