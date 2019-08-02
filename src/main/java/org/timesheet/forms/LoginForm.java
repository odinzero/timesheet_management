
package org.timesheet.forms;


import org.hibernate.validator.constraints.NotEmpty;

public class LoginForm {
    
    @NotEmpty
    String username;
    
    @NotEmpty
    String password;
    
    // CHECKBOX 'Remember me'
   // private boolean remenberMe;

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

//    public void setRemenberMe(boolean remenberMe) {
//        this.remenberMe = remenberMe;
//    }
//
//    public boolean isRemenberMe() {
//        return remenberMe;
//    }
    
    
    
}
