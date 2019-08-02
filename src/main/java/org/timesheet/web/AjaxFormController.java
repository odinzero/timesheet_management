package org.timesheet.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import javax.validation.Valid;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.domain.Employee;
import org.timesheet.forms.TaskAjaxValidationErrors;
import org.timesheet.forms.TaskFormAjax;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.service.dao.TaskDao;

@Controller
@RequestMapping("/task_ajaxform")
public class AjaxFormController {

    static final Logger logger = Logger.getLogger(AjaxFormController.class);

    private TaskDao taskDao;
    private EmployeeDao employeeDao;
    private ManagerDao managerDao;

    @Autowired
    public void setTaskDao(TaskDao taskDao) {
        this.taskDao = taskDao;
    }

    @Autowired
    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    @Autowired
    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    public EmployeeDao getEmployeeDao() {
        return employeeDao;
    }

    public TaskDao getTaskDao() {
        return taskDao;
    }

    public ManagerDao getManagerDao() {
        return managerDao;
    }
    
    // http://localhost:8083/timesheet/task_ajaxform/loaddata
    @RequestMapping(value = "/loaddata", method = RequestMethod.POST)
    @ResponseBody
    public String loadFormData(@RequestParam Long id) {
        Task task = taskDao.find(id);

        String description = task.getDescription();
        // list of managers to choose from DROPDOWN LIST =MANAGERS=
        List<Manager> managers = managerDao.list();
        // set selected value in DROPDOWN LIST =MANAGERS=
        Manager manager = task.getManager();
        Long selectedManager_id = manager.getId();
        
        // get CHECKBOX state
        String bool = Boolean.toString(task.isCompleted());
        
        List<org.timesheet.domain.Employee> assignedEmployees = task.getAssignedEmployees();
         
        // add all remaining employees
        List<org.timesheet.domain.Employee> employees = employeeDao.list();
        Set<org.timesheet.domain.Employee> unassignedEmployees = new HashSet<org.timesheet.domain.Employee>();

        for (org.timesheet.domain.Employee employee : employees) {
            if (!task.getAssignedEmployees().contains(employee)) {
                unassignedEmployees.add(employee);
            }
        } 

        return description + "&&" + managers.toString() + "&&" + bool + "&&" + 
               assignedEmployees.toString() + "&&" + unassignedEmployees.toString() + 
               "&&" + selectedManager_id;
    }

    //@GetMapping("/")
    // http://localhost:8083/timesheet/task_ajaxform/{id}?updateAjaxForm
    @RequestMapping(value = "/{id}",  params = "updateAjaxForm", method = RequestMethod.GET)
    public String updateTaskForm(@PathVariable("id") long id, Model model) {
        
        model.addAttribute("id", id);
        
        model.addAttribute("view", "tasks/updateAjaxForm");
        
        //return "tasks/updateAjaxForm";
        return "layout/content";
    }

    // http://localhost:8083/timesheet/task_ajaxform/updateTask2
    @RequestMapping(value = "/updateTask2", method = RequestMethod.POST
           // produces =  MediaType.APPLICATION_JSON_VALUE 
    )
    @ResponseBody
    public String updateTaskAjax2(@ModelAttribute @Valid TaskFormAjax tfa,
            BindingResult result) {

        TaskAjaxValidationErrors validationErrors = new TaskAjaxValidationErrors();
        
        logger.info("=== Ajax2Controller === method:updateTaskAjax2 --- start:" + result.toString());

        if (result.hasErrors()) {

            //Get error messages
            Map<String, String> errors = new HashMap<String, String>();

            List<FieldError> fieldErrors = result.getFieldErrors();

            for (FieldError fieldError : fieldErrors) {
                errors.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            
            validationErrors.setErrorMessages(errors);
            
            logger.info("=== Ajax2Controller === method:updateTaskAjax2 --- errors:"
                    + validationErrors.getErrorMessages());
            
             return validationErrors.getErrorMessages().toString();
        } 
        else {
            // Implement business logic to update task in database
            //..
            Task task = taskDao.find(tfa.getId());
            task.setId(tfa.getId());
            task.setDescription(tfa.getDescription());
            
            boolean completed = Boolean.valueOf(tfa.isCompleted());
            task.setCompleted(completed);
            // One value from  DROPDOWN LIST "MANAGERS"
            Long manager_id = Long.parseLong(tfa.getManagers());
            Manager manager = managerDao.find(manager_id);
            task.setManager(manager);
            
            List<Employee> assignEmployees = new ArrayList<Employee>();
            //  
            String[] assignedEmployees = tfa.getAssignedEmployees();
           
            for (int i = 0; i < assignedEmployees.length; i++) {
                String emp_id = assignedEmployees[i];

                Long aemployee_id = Long.parseLong(emp_id);
                Employee aemployee = employeeDao.find(aemployee_id);
                assignEmployees.add(aemployee);
            }
            task.setAssignedEmployees(assignEmployees);
           
            taskDao.update(task);
           
           return "OK"; // + |tfa.isCompleted()
        }
        
       // logger.info("=== Ajax2Controller === method:updateTaskAjax2 --- end:" + tfa);
       // return validationErrors.getErrorMessages().toString();
    }
}
