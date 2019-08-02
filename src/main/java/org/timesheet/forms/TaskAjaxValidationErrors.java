package org.timesheet.forms;

// see Ajax2Controller
import java.util.Map;

public class TaskAjaxValidationErrors {

    private Map<String, String> errorMessages;

    public void setErrorMessages(Map<String, String> errorMessages) {
        this.errorMessages = errorMessages;
    }

    public Map<String, String> getErrorMessages() {
        return errorMessages;
    }
}
