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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.forms.TaskAjaxValidationErrors;
import org.timesheet.forms.TaskForm;
import org.timesheet.forms.TaskFormAjax;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.service.dao.TaskDao;

@Controller
@RequestMapping("/task_ajax2")
public class Ajax2Controller {

    static final Logger logger = Logger.getLogger(Ajax2Controller.class);

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

    // http://localhost:8083/timesheet/task_ajax2/loaddata
    @RequestMapping(value = "/loaddata", method = RequestMethod.POST)
    @ResponseBody
    public String loadData(@RequestParam Long id) {
        Task task = taskDao.find(id);
        // get Description
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

        return description + "&&" + managers.toString() + "&&" + bool + "&&"
                + assignedEmployees.toString() + "&&" + unassignedEmployees.toString() +
                "&&" + selectedManager_id;
    }

    //@GetMapping("/")
    // http://localhost:8083/timesheet/task_ajax2/{id}?updateAjaxForm
    @RequestMapping(value = "/{id}", params = "updateAjax2", method = RequestMethod.GET)
    public String updateTaskAjax2(@PathVariable("id") long id, Model model) {

        model.addAttribute("id", id);
        
        model.addAttribute("view", "tasks/updateAjax2");

        //return "tasks/updateAjax2";
        return "layout/content";
    }

    // http://localhost:8083/timesheet/task_ajax2/updateTask2
    @RequestMapping(value = "/updateTask2", method = RequestMethod.POST
    //  produces =  MediaType.APPLICATION_JSON_VALUE 
    )
    @ResponseBody
    public TaskFormAjax updateTaskAjax(@RequestBody TaskFormAjax tfa) {

        String val_description;
        if (tfa.getDescription() == "") {
            val_description = "false";
        } else {
            val_description = "true";
        }

        String val_manager;
        if (tfa.getManagers() == "" || tfa.getManagers() == null || tfa.getManagers() == "") {
            val_manager = "false";
        } else {
            val_manager = "true";
        }

        String val_assignedEmployees;
        String[] s = tfa.getAssignedEmployees();
        if (s[0] == "") {
            val_assignedEmployees = "false";
        } else {
            val_assignedEmployees = "true";
        }

        if (val_description == "true" && val_manager == "true" && val_assignedEmployees == "true") {

            Task task = taskDao.find(tfa.getId());
            task.setId(tfa.getId());
            // DESCRIPTION
            task.setDescription(tfa.getDescription());
            // CHECKBOX "COMPLETED"
            task.setCompleted(tfa.isCompleted());
            
            Long man_id = Long.parseLong(tfa.getManagers());
            Manager manager = managerDao.find(man_id);
            task.setManager(manager);
        
            
            List<Employee> assignEmployees = new ArrayList<Employee>();
            
            logger.info("=== Ajax2Controller!!! === method:updateTaskAjax --- length: " + tfa.getAssignedEmployees().length);

            String[] assignedEmployees = tfa.getAssignedEmployees();
            
            for (int i = 0; i < assignedEmployees.length; i++) {
                String employee_id = assignedEmployees[i];
                
                Long aemployee_id = Long.parseLong(employee_id);
                
                Employee aemployee = employeeDao.find(aemployee_id);
                assignEmployees.add(aemployee);
            }
            // DROPDOWN LIST "ASSIGNED EMPLOYEES"
            task.setAssignedEmployees(assignEmployees); 
            
            logger.info("=== Ajax2Controller!!! === method:updateTaskAjax --- end: " + task.getAssignedEmployees());

            taskDao.update(task);
            // set successful result ! see  'updateAjax2.jsp'
            tfa.setResult("OK"); 
        }

        return tfa;

    }

}
