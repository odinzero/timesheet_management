package org.timesheet.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.service.TimesheetService;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.web.editors.EmployeeEditor;
import org.timesheet.web.editors.ManagerEditor;

import java.util.List;
import org.apache.log4j.Logger;

@Controller
@RequestMapping("/timesheet-service")
public class TimesheetServiceController {
    
    static final Logger logger = Logger.getLogger(TimesheetServiceController.class);

    private TimesheetService service;
    private EmployeeDao employeeDao;
    private ManagerDao managerDao;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        
        logger.info("=== TimesheetServiceController === method:initBinder --- start");
        
        binder.registerCustomEditor(Employee.class, new EmployeeEditor(employeeDao));
        binder.registerCustomEditor(Manager.class, new ManagerEditor(managerDao));
        
        logger.info("=== TimesheetServiceController === method:initBinder --- end");
    }

    @Autowired
    public void setService(TimesheetService service) {
        this.service = service;
    }

    @Autowired
    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    @Autowired
    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    /**
     * Shows menu of timesheet service:
     * that contains busiest task and employees and managers to
     * look for their assigned tasks.
     * @param model Model to put data to
     * @return timesheet-service/list
     */
    // http://localhost:8083/timesheet/timesheet-service
    @RequestMapping(method = RequestMethod.GET)
    public String showMenu(Model model) {
        
        logger.info("=== TimesheetServiceController === method:showMenu --- start");
        
        model.addAttribute("busiestTask", service.busiestTask());
        model.addAttribute("employees", employeeDao.list());
        model.addAttribute("managers", managerDao.list());
        // see file 'content.jsp'
        model.addAttribute("view", "timesheet-service/menu");
        
        logger.info("=== TimesheetServiceController === method:showMenu --- end");

        //return "timesheet-service/menu";
        return "layout/content";
    }

    /**
     * Returns tasks for given manager
     * @param id ID of manager
     * @param model Model to put tasks and manager
     * @return timesheet-service/manager-tasks
     */
    // http://localhost:8083/timesheet/timesheet-service/manager-tasks/{id}
    @RequestMapping(value = "/manager-tasks/{id}", method = RequestMethod.GET)
    public String showManagerTasks(@PathVariable("id") long id, Model model) {
        
        logger.info("=== TimesheetServiceController === method:showManagerTasks --- start");
        
        Manager manager = managerDao.find(id);
        List<Task> tasks = service.tasksForManager(manager);

        model.addAttribute("manager", manager);
        model.addAttribute("tasks", tasks);
        // see file 'content.jsp'
        model.addAttribute("view", "timesheet-service/manager-tasks");
        
        logger.info("=== TimesheetServiceController === method:showManagerTasks --- end");

        //return "timesheet-service/manager-tasks";
        return "layout/content";
    }

    /**
     * Returns tasks for given employee
     * @param id ID of employee
     * @param model Model to put tasks and employee
     * @return timesheet-service/employee-tasks
     */
    // http://localhost:8083/timesheet/timesheet-service/employee-tasks/{id}
    @RequestMapping(value = "/employee-tasks/{id}", method = RequestMethod.GET)
    public String showEmployeeTasks(@PathVariable("id") long id, Model model) {
        
        logger.info("=== TimesheetServiceController === method:showEmployeeTasks --- start");

        Employee employee = employeeDao.find(id);
        List<Task> tasks = service.tasksForEmployee(employee);

        model.addAttribute("employee", employee);
        model.addAttribute("tasks", tasks);
        // see file 'content.jsp'
        model.addAttribute("view", "timesheet-service/employee-tasks");
        
        logger.info("=== TimesheetServiceController === method:showEmployeeTasks --- end");

        //return "timesheet-service/employee-tasks";
        return "layout/content";
    }
}
