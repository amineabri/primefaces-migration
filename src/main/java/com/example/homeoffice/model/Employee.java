package com.example.homeoffice.model;

import java.io.Serializable;

public class Employee implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String employeeId;
    private final String name;
    private final String department;
    private final String location;
    private final String status;

    public Employee(String employeeId, String name, String department, String location, String status) {
        this.employeeId = employeeId;
        this.name = name;
        this.department = department;
        this.location = location;
        this.status = status;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }

    public String getLocation() {
        return location;
    }

    public String getStatus() {
        return status;
    }
}
