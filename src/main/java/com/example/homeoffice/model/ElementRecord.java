package com.example.homeoffice.model;

import java.io.Serializable;

public class ElementRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String reference;
    private final String service;
    private final String owner;
    private final String status;
    private final String detail;

    public ElementRecord(String reference, String service, String owner, String status, String detail) {
        this.reference = reference;
        this.service = service;
        this.owner = owner;
        this.status = status;
        this.detail = detail;
    }

    public String getReference() {
        return reference;
    }

    public String getService() {
        return service;
    }

    public String getOwner() {
        return owner;
    }

    public String getStatus() {
        return status;
    }

    public String getDetail() {
        return detail;
    }
}
