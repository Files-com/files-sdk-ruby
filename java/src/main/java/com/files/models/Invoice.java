
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class Invoice
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public Invoice(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Line item Id
     */
    @Getter
    public Long id;

    /**
     * Line item amount
     */
    @Getter
    public double amount;

    /**
     * Line item balance
     */
    @Getter
    public double balance;

    /**
     * Line item created at
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Line item currency
     */
    @Getter
    public String currency;

    /**
     * Line item download uri
     */
    @Getter
    public String downloadUri;

    /**
     * Associated invoice line items
     */
    @Getter
    public Object[] invoiceLineItems;

    /**
     * Line item payment method
     */
    @Getter
    public String method;

    /**
     * Associated payment line items
     */
    @Getter
    public Object[] paymentLineItems;

    /**
     * Date/time payment was reversed if applicable
     */
    @Getter
    public LocalDateTime paymentReversedAt;

    /**
     * Type of payment if applicable
     */
    @Getter
    public String paymentType;

    /**
     * Site name this line item is for
     */
    @Getter
    public String siteName;

    /**
     * Type of line item, either payment or invoice
     */
    @Getter
    public String type;

    /**
     * Line item updated at
     */
    @Getter
    public LocalDateTime updatedAt;



    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static Invoice list( HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Invoice all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Invoice ID.
     */
    // TODO: Use types for path_and_primary_params
    public static Invoice find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
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

    public static Invoice get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
}


