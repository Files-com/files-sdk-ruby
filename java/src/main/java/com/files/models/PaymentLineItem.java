
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class PaymentLineItem
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public PaymentLineItem(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Payment line item amount
     */
    @Getter
    public double amount;

    /**
     * Payment line item created at date/time
     */
    @Getter
    public LocalDateTime createdAt;

    /**
     * Invoice ID
     */
    @Getter
    public Long invoiceId;

    /**
     * Payment ID
     */
    @Getter
    public Long paymentId;

    /**
     * Payment line item updated at date/time
     */
    @Getter
    public LocalDateTime updatedAt;



}


