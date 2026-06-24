package com.example.homeoffice.model;

import java.io.Serializable;

public class WorkQueueItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String reference;
    private final String team;
    private final String priority;
    private final String status;

    public WorkQueueItem(String reference, String team, String priority, String status) {
        this.reference = reference;
        this.team = team;
        this.priority = priority;
        this.status = status;
    }

    public String getReference() {
        return reference;
    }

    public String getTeam() {
        return team;
    }

    public String getPriority() {
        return priority;
    }

    public String getStatus() {
        return status;
    }
}
