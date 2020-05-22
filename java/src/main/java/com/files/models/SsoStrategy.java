
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class SsoStrategy
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public SsoStrategy(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * SSO Protocol
     */
    @Getter
    public String protocol;

    /**
     * Provider name
     */
    @Getter
    public String provider;

    /**
     * ID
     */
    @Getter
    public Long id;

    /**
     * Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
     */
    @Getter
    public String samlProviderCertFingerprint;

    /**
     * Identity provider issuer url
     */
    @Getter
    public String samlProviderIssuerUrl;

    /**
     * Metadata URL for the SAML identity provider
     */
    @Getter
    public String samlProviderMetadataUrl;

    /**
     * Identity provider SLO endpoint
     */
    @Getter
    public String samlProviderSloTargetUrl;

    /**
     * Identity provider SSO endpoint if saml_provider_metadata_url is not available.
     */
    @Getter
    public String samlProviderSsoTargetUrl;

    /**
     * SCIM authentication type.
     */
    @Getter
    public String scimAuthenticationMethod;

    /**
     * SCIM username.
     */
    @Getter
    public String scimUsername;

    /**
     * Subdomain
     */
    @Getter
    public String subdomain;

    /**
     * Auto-provision users?
     */
    @Getter
    public boolean provisionUsers;

    /**
     * Auto-provision group membership based on group memberships on the SSO side?
     */
    @Getter
    public boolean provisionGroups;

    /**
     * Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
     */
    @Getter
    public String provisionGroupDefault;

    /**
     * Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
     */
    @Getter
    public String provisionGroupExclusion;

    /**
     * Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
     */
    @Getter
    public String provisionGroupInclusion;

    /**
     * Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
     */
    @Getter
    public String provisionGroupRequired;

    /**
     * Auto-provisioned users get Sharing permission?
     */
    @Getter
    public boolean provisionAttachmentsPermission;

    /**
     * Auto-provisioned users get WebDAV permission?
     */
    @Getter
    public boolean provisionDavPermission;

    /**
     * Auto-provisioned users get FTP permission?
     */
    @Getter
    public boolean provisionFtpPermission;

    /**
     * Auto-provisioned users get SFTP permission?
     */
    @Getter
    public boolean provisionSftpPermission;

    /**
     * Default time zone for auto provisioned users.
     */
    @Getter
    public String provisionTimeZone;



    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static SsoStrategy list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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
        // TODO: Send request
        return null;
    }

    public static SsoStrategy all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Sso Strategy ID.
     */
    // TODO: Use types for path_and_primary_params
    public static SsoStrategy find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static SsoStrategy get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
}


