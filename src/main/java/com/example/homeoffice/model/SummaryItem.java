package com.example.homeoffice.model;

import java.io.Serializable;

public class SummaryItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String label;
    private final String value;
    private final String note;

    public SummaryItem(String label, String value, String note) {
        this.label = label;
        this.value = value;
        this.note = note;
    }

    public String getLabel() {
        return label;
    }

    public String getValue() {
        return value;
    }

    public String getNote() {
        return note;
    }
}
