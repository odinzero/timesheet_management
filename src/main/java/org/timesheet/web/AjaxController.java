package org.timesheet.web;

import java.util.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.forms.TaskForm;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.service.dao.TaskDao;
import org.timesheet.web.editors.ManagerEditor;
import org.timesheet.web.exceptions.TaskDeleteException;
import org.springframework.validation.ValidationUtils;
import org.timesheet.forms.TaskFormAjax;

@Controller
@RequestMapping("/task_ajax")
public class AjaxController {

    static final Logger logger = Logger.getLogger(TaskController.class);

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

    //======================== UPDATE AJAX =========================================
    // http://localhost:8083/timesheet/task_ajax/description
    @RequestMapping(value = "/description", method = RequestMethod.POST)
    @ResponseBody
    public String getDescription(@RequestParam Long id) {
        Task task = taskDao.find(id);

        String description = task.getDescription();

        return description;
    }

    // http://localhost:8083/timesheet/task_ajax/managers
    @RequestMapping(value = "/managers", method = RequestMethod.POST)
    @ResponseBody
    public String getManagers(@RequestParam Long id) {
        Task task = taskDao.find(id);

        // list of managers to choose from DROPDOWN LIST =MANAGERS=
        List<Manager> managers = managerDao.list();
        // set selected value in DROPDOWN LIST =MANAGERS=
        Manager manager = task.getManager();
        Long manager_id = manager.getId();
        
        return managers.toString() + ":" + manager_id;
    }

    // http://localhost:8083/timesheet/task_ajax/completed
    @RequestMapping(value = "/completed", method = RequestMethod.POST)
    @ResponseBody
    public String getCompleted(@RequestParam Long id) {
        Task task = taskDao.find(id);

        // get CHECKBOX state
        String bool = Boolean.toString(task.isCompleted());

        return bool;
    }

    // http://localhost:8083/timesheet/task_ajax/assignedEmployees
    @RequestMapping(value = "/assignedEmployees", method = RequestMethod.POST)
    @ResponseBody
    public String getAssignedEmployees(@RequestParam Long id) {
        Task task = taskDao.find(id);

        List<Employee> assignedEmployees = task.getAssignedEmployees();

        return assignedEmployees.toString();
    }

    // http://localhost:8083/timesheet/task_ajax/unassignedEmployees
    @RequestMapping(value = "/unassignedEmployees", method = RequestMethod.POST)
    @ResponseBody
    public String getUnassignedEmployees(@RequestParam Long id) {
        Task task = taskDao.find(id);

        // add all remaining employees
        List<Employee> employees = employeeDao.list();
        Set<Employee> unassignedEmployees = new HashSet<Employee>();

        for (Employee employee : employees) {
            if (!task.getAssignedEmployees().contains(employee)) {
                unassignedEmployees.add(employee);
            }
        }

        return unassignedEmployees.toString();
    }

    // http://localhost:8083/timesheet/task_ajax/{id}?updateAjax
    @RequestMapping(value = "/{id}", params = "updateAjax", method = RequestMethod.GET)
    public String updateTaskFormAjax(@PathVariable("id") long id, Model model) {

        logger.info("=== TaskController === method:updateTaskFormAjax --- start");

        Task task = taskDao.find(id);
        model.addAttribute("task", task);

        // list of managers to choose from DROPDOWN LIST =MANAGERS=
        List<Manager> managers = managerDao.list();
        model.addAttribute("managers", managers);

        // set selected value in DROPDOWN LIST =MANAGERS=
        Manager manager = task.getManager();
        Long manager_id = manager.getId();
        // set selected value in DROPDOWN LIST =MANAGERS=
        model.addAttribute("selectedManId", manager_id);

        List<Employee> assignedEmployees = task.getAssignedEmployees();
        model.addAttribute("assignedEmployees", assignedEmployees);

        // add all remaining employees
        List<Employee> employees = employeeDao.list();
        Set<Employee> unassignedEmployees = new HashSet<Employee>();

        for (Employee employee : employees) {
            if (!task.getAssignedEmployees().contains(employee)) {
                unassignedEmployees.add(employee);
            }
        }

        model.addAttribute("unassignedEmployees", unassignedEmployees);

        logger.info("=== TaskController === method:updateTaskFormAjax --- end");
        
        model.addAttribute("view", "tasks/updateAjax");

        return "layout/content";
        //return "tasks/updateAjax";
        //return new ModelAndView("tasks/update", "command", new TaskForm());
    }

    /**
     * Updates task with specified ID
     *
     * @param id Task's ID
     * @param task Task to update (bounded from HTML form)
     * @return redirects to tasks
     */
    // http://localhost:8083/timesheet/task_ajax/updateTask
    @RequestMapping(value = "/updateTask", method = RequestMethod.POST)
    @ResponseBody
    public String updateTaskAjax(
            // @ModelAttribute("taskUpdateAjax") @Validated TaskForm taskFormAjax,
            @RequestParam Long id,
            @RequestParam String description,
            @RequestParam String manager_id,
            @RequestParam boolean completed,
            @RequestParam(value = "assignedEmployees[]") List<String> assignedEmployees
    ) {
//        logger.info("=== AjaxController === method:updateTaskAjax --- start");
        Task task = taskDao.find(id);
        task.setId(id);
        task.setDescription(description);
        task.setCompleted(completed);

        if (manager_id == "undefined" || manager_id == null || manager_id == "" ) {
            manager_id = "";
        } else if (manager_id != "undefined" || manager_id != null || manager_id != "" ) {
            Long man_id = Long.parseLong(manager_id);
            Manager manager = managerDao.find(man_id);
            task.setManager(manager);
        }

        List<Employee> assignEmployees = new ArrayList<Employee>();
        
           if(!assignedEmployees.isEmpty()) {
            for (Iterator<String> it = assignedEmployees.iterator(); it.hasNext();) {
                String emp_id = it.next();

                Long aemployee_id = Long.parseLong(emp_id);
                Employee aemployee = employeeDao.find(aemployee_id);
                assignEmployees.add(aemployee);
            }
            task.setAssignedEmployees(assignEmployees);
           }
        

        String val_description;
        if (description == "") {
            val_description = "false";
        } else {
            val_description = "true";
        }

        String val_managerId;
        if (manager_id == "undefined" || manager_id == null || manager_id == "") {
            val_managerId = "false";
        } else {
            val_managerId = "true";
        }

        String val_assignEmployees;
        if (assignEmployees.isEmpty()) {
            val_assignEmployees = "false";
        } else {
            val_assignEmployees = "true";
        }

        if (val_description == "true" && val_managerId == "true" && val_assignEmployees == "true") {

           taskDao.update(task);
        }

        return "" + val_description + "|" + val_managerId + "|" + val_assignEmployees;

        //  return "redirect:/tasks";
        //   return "tasks/newjsp";
        // return  "0";
        //"id :" + id
        //+ " description:" + task.getDescription()
        // " assignedEmployees:" + assignedEmployees.get(0) 
        // " assignedEmployees:" +  Long.parseLong(assignedEmployees[0])  + " | " + Long.parseLong(assignedEmployees[1])
        // " manager:" + task.getManager().toString() + 
        // " completed:" + Boolean.toString(task.isCompleted()) + 
        //" assignedEmployees:" + task.getAssignedEmployees().toString();
    }

}
