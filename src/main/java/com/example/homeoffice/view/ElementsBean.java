package com.example.homeoffice.view;

import com.example.homeoffice.model.ElementRecord;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Named;

@Named
@SessionScoped
public class ElementsBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private final List<ElementRecord> records = Collections.unmodifiableList(Arrays.asList(
            new ElementRecord("EL-001", "Passport operations", "Operations", "Active", "Daily casework review for document processing."),
            new ElementRecord("EL-002", "People services", "People Services", "Ready", "Internal staffing summary prepared for line managers."),
            new ElementRecord("EL-003", "Finance checks", "Finance", "Pending", "Budget validation queue awaiting review."),
            new ElementRecord("EL-004", "Governance pack", "Governance", "Draft", "Monthly board pack assembled from static sample data.")
    ));

    private final List<String> departments = Collections.unmodifiableList(Arrays.asList(
            "Operations", "People Services", "Finance", "Governance", "Technology"
    ));

    private final List<String> regions = Collections.unmodifiableList(Arrays.asList(
            "London", "North West", "West Midlands", "Scotland", "Wales"
    ));

    private String serviceName = "Internal service review";
    private String department = "Operations";
    private boolean urgent;
    private Date reviewDate = new Date();
    private String notes = "Use clear, concise content for operational teams.";
    private String priority = "Medium";
    private String selectedRegion = "London";
    private List<String> selectedDepartments = new ArrayList<String>(Arrays.asList("Operations", "Governance"));
    private String autocompleteValue;
    private String editorText = "<p>Draft service note for the internal operations team.</p>";
    private transient UploadedFile uploadedFile;
    private String uploadStatus = "No file selected.";
    private int progress = 35;
    private int pollCount;

    public void saveDemo() {
        addMessage(FacesMessage.SEVERITY_INFO, "Saved", "The sample form values were submitted.");
    }

    public void linkAction() {
        addMessage(FacesMessage.SEVERITY_INFO, "Command link", "The command link action completed.");
    }

    public void confirmedAction() {
        addMessage(FacesMessage.SEVERITY_INFO, "Confirmed", "The confirmation action completed.");
    }

    public void resetDemo() {
        serviceName = "Internal service review";
        department = "Operations";
        urgent = false;
        reviewDate = new Date();
        notes = "Use clear, concise content for operational teams.";
        priority = "Medium";
        selectedRegion = "London";
        selectedDepartments = new ArrayList<String>(Arrays.asList("Operations", "Governance"));
        autocompleteValue = null;
        editorText = "<p>Draft service note for the internal operations team.</p>";
        uploadedFile = null;
        uploadStatus = "No file selected.";
        progress = 35;
        pollCount = 0;
        addMessage(FacesMessage.SEVERITY_INFO, "Reset", "The sample form was reset.");
    }

    public void handleUpload(FileUploadEvent event) {
        uploadedFile = event.getFile();
        uploadStatus = uploadedFile.getFileName() + " selected (" + uploadedFile.getSize() + " bytes).";
        addMessage(FacesMessage.SEVERITY_INFO, "File upload", uploadStatus);
    }

    public List<String> completeDepartment(String query) {
        List<String> results = new ArrayList<String>();
        String filter = query == null ? "" : query.toLowerCase();
        for (String item : departments) {
            if (item.toLowerCase().contains(filter)) {
                results.add(item);
            }
        }
        return results;
    }

    public void pollProgress() {
        pollCount++;
        progress = progress >= 100 ? 0 : progress + 5;
    }

    private void addMessage(FacesMessage.Severity severity, String summary, String detail) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(severity, summary, detail));
    }

    public List<ElementRecord> getRecords() {
        return records;
    }

    public List<String> getDepartments() {
        return departments;
    }

    public List<String> getRegions() {
        return regions;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public boolean isUrgent() {
        return urgent;
    }

    public void setUrgent(boolean urgent) {
        this.urgent = urgent;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getSelectedRegion() {
        return selectedRegion;
    }

    public void setSelectedRegion(String selectedRegion) {
        this.selectedRegion = selectedRegion;
    }

    public List<String> getSelectedDepartments() {
        return selectedDepartments;
    }

    public void setSelectedDepartments(List<String> selectedDepartments) {
        this.selectedDepartments = selectedDepartments;
    }

    public String getAutocompleteValue() {
        return autocompleteValue;
    }

    public void setAutocompleteValue(String autocompleteValue) {
        this.autocompleteValue = autocompleteValue;
    }

    public String getEditorText() {
        return editorText;
    }

    public void setEditorText(String editorText) {
        this.editorText = editorText;
    }

    public UploadedFile getUploadedFile() {
        return uploadedFile;
    }

    public void setUploadedFile(UploadedFile uploadedFile) {
        this.uploadedFile = uploadedFile;
    }

    public String getUploadStatus() {
        return uploadStatus;
    }

    public int getProgress() {
        return progress;
    }

    public int getPollCount() {
        return pollCount;
    }
}
