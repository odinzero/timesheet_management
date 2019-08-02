
package org.timesheet.forms;

import java.util.List;
import java.util.Map;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Manager;

public class TaskForm {
    
    private Long id;
    
    // CHECKBOX 'COMPLETED'
    private boolean completed;
    
    @NotEmpty
    private String description;
    
    // DROPDOWN LIST "MANAGERS"
    @NotEmpty
    private String managers;
    
    private Manager manager;
    
    // DROPDOWN LIST "ASSIGNED EMPLOYEES"
    @NotEmpty
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
  
    
    
}
