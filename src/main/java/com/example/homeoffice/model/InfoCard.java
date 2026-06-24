package com.example.homeoffice.model;

import java.io.Serializable;

public class InfoCard implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String title;
    private final String detail;
    private final String value;

    public InfoCard(String title, String detail, String value) {
        this.title = title;
        this.detail = detail;
        this.value = value;
    }

    public String getTitle() {
        return title;
    }

    public String getDetail() {
        return detail;
    }

    public String getValue() {
        return value;
    }
}
