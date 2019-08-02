
package org.timesheet.forms;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;
import org.timesheet.domain.Task;

public class TimesheetForm {
    
    private Long id;
    
    @NotNull
    @Range(min = 1, message = "Hours must be 1 or greater")
    private Integer hours;
    
    // SELECT FROM DROPDOWN LIST "EMPLOYEES"
    @NotEmpty
    private String who;
    
    // SELECT FROM DROPDOWN LIST "TASKS"
    @NotEmpty
    private String tasks;
    
    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public Integer getHours() {
        return hours;
    }

    public void setWho(String who) {
        this.who = who;
    }

    public String getWho() {
        return who;
    }

    public void setTasks(String tasks) {
        this.tasks = tasks;
    }

    public String getTasks() {
        return tasks;
    }
    
    
    
    
}
