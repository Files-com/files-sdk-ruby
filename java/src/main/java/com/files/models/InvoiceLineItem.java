
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class InvoiceLineItem
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public InvoiceLineItem(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Invoice line item amount
     */
    @Getter
    public double amount;

    /**
     * Invoice line item created at date/time
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Invoice line item description
     */
    @Getter
    public String description;

    /**
     * Invoice line item type
     */
    @Getter
    public String type;

    /**
     * Invoice line item service end date/time
     */
    @Getter
    public LocalDateTime serviceEndAt;

    /**
     * Invoice line item service start date/time
     */
    @Getter
    public LocalDateTime serviceStartAt;

    /**
     * Invoice line item updated date/time
     */
    @Getter
    public LocalDateTime updatedAt;

    /**
     * Plan name
     */
    @Getter
    public String plan;

    /**
     * Site name
     */
    @Getter
    public String site;



}


