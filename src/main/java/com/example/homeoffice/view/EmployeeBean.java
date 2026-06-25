package com.example.homeoffice.view;

import com.example.homeoffice.model.Employee;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;

@Named
@ApplicationScoped
public class EmployeeBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private final List<Employee> employees = Collections.unmodifiableList(Arrays.asList(
            new Employee("EMP-1001", "Aisha Khan", "Operations", "London", "Active"),
            new Employee("EMP-1002", "James Walker", "People Services", "Manchester", "Active"),
            new Employee("EMP-1003", "Priya Patel", "Finance", "Birmingham", "Active"),
            new Employee("EMP-1004", "Daniel Hughes", "Governance", "Cardiff", "Seconded"),
            new Employee("EMP-1005", "Sarah Thompson", "Technology", "Leeds", "Active"),
            new Employee("EMP-1006", "Michael Brown", "Operations", "Glasgow", "Active"),
            new Employee("EMP-1007", "Emma Wilson", "People Services", "Bristol", "Leave"),
            new Employee("EMP-1008", "Omar Ali", "Finance", "London", "Active")
    ));

    public List<Employee> getEmployees() {
        return employees;
    }
}
