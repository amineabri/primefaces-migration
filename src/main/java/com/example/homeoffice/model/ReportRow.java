package com.example.homeoffice.model;

import java.io.Serializable;

public class ReportRow implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String reference;
    private final String title;
    private final String owner;
    private final String status;
    private final String dueDate;

    public ReportRow(String reference, String title, String owner, String status, String dueDate) {
        this.reference = reference;
        this.title = title;
        this.owner = owner;
        this.status = status;
        this.dueDate = dueDate;
    }

    public String getReference() {
        return reference;
    }

    public String getTitle() {
        return title;
    }

    public String getOwner() {
        return owner;
    }

    public String getStatus() {
        return status;
    }

    public String getDueDate() {
        return dueDate;
    }
}
