
package org.timesheet.forms;

import org.hibernate.validator.constraints.NotEmpty;

public class ManagerForm {
   
    @NotEmpty
    private String name;
    
    private Long id;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
    
    
}
