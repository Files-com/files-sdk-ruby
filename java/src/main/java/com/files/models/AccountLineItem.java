
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class AccountLineItem
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public AccountLineItem(HashMap<String, Object> attributes, HashMap<String, Object> options)
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



}


