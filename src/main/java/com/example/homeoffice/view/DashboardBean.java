package com.example.homeoffice.view;

import com.example.homeoffice.model.SummaryItem;
import com.example.homeoffice.model.WorkQueueItem;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;

@Named
@ApplicationScoped
public class DashboardBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private final List<SummaryItem> summaryItems = Collections.unmodifiableList(Arrays.asList(
            new SummaryItem("Open Cases", "42", "Across all business units"),
            new SummaryItem("Reviews Due", "7", "Scheduled this week"),
            new SummaryItem("Resolved Today", "13", "Closed by operations teams"),
            new SummaryItem("Service Level", "96%", "Within internal target")
    ));

    private final List<WorkQueueItem> workQueue = Collections.unmodifiableList(Arrays.asList(
            new WorkQueueItem("CASE-1042", "Operations", "High", "In progress"),
            new WorkQueueItem("CASE-1043", "People Services", "Medium", "Assigned"),
            new WorkQueueItem("CASE-1044", "Finance", "Low", "Pending review"),
            new WorkQueueItem("CASE-1045", "Governance", "Medium", "In progress"),
            new WorkQueueItem("CASE-1046", "Technology", "High", "Assigned")
    ));

    public List<SummaryItem> getSummaryItems() {
        return summaryItems;
    }

    public List<WorkQueueItem> getWorkQueue() {
        return workQueue;
    }
}
