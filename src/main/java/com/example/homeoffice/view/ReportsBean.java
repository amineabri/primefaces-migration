package com.example.homeoffice.view;

import com.example.homeoffice.model.ReportRow;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;

@Named
@ApplicationScoped
public class ReportsBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private final List<ReportRow> reports = Collections.unmodifiableList(Arrays.asList(
            new ReportRow("RPT-001", "Monthly Service Summary", "Operations", "Ready", "30 Jun 2026"),
            new ReportRow("RPT-002", "Employee Movement Review", "People Services", "Draft", "03 Jul 2026"),
            new ReportRow("RPT-003", "Budget Position", "Finance", "Ready", "05 Jul 2026"),
            new ReportRow("RPT-004", "Risk Register Update", "Governance", "In review", "10 Jul 2026")
    ));

    public List<ReportRow> getReports() {
        return reports;
    }
}
