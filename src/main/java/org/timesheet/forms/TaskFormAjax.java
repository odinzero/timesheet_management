
package org.timesheet.forms;

import java.util.List;
import java.util.Map;
import org.hibernate.validator.constraints.NotEmpty;
import org.timesheet.domain.Manager;

public class TaskFormAjax {
    
    private Long id;
    
    private String result = null;
    
    // CHECKBOX 'COMPLETED'
    private boolean completed;
    
    @NotEmpty(message="Enter description of task.")
    private String description;
    
    // DROPDOWN LIST "MANAGERS"
    @NotEmpty(message="Select manager for task.")
    private String managers;
    
    private Manager manager;
    
    // DROPDOWN LIST "ASSIGNED EMPLOYEES"
    @NotEmpty(message="Select employees for task.")
    private String[] assignedEmployees;
    
    // DROPDOWN LIST "UNASSIGNED EMPLOYEES"
    private String[] unassignedEmployees;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }

    public Manager getManager() {
        return manager;
    } 

    public void setManagers(String managers) {
        this.managers = managers;
    }

    public String getManagers() {
        return managers;
    }

    public void setAssignedEmployees(String[] assignedEmployees) {
        this.assignedEmployees = assignedEmployees;
    }

    public String[] getAssignedEmployees() {
        return assignedEmployees;
    }

    public void setUnassignedEmployees(String[] unassignedEmployees) {
        this.unassignedEmployees = unassignedEmployees;
    }

    public String[] getUnassignedEmployees() {
        return unassignedEmployees;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getResult() {
        return result;
    }
    
}
