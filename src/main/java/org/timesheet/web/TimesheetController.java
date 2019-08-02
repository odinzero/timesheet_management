package org.timesheet.web;

import java.util.List;
import javax.validation.Valid;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Task;
import org.timesheet.domain.Timesheet;
import org.timesheet.forms.TimesheetForm;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.TaskDao;
import org.timesheet.service.dao.TimesheetDao;
import org.timesheet.web.commands.TimesheetCommand;
import org.timesheet.web.editors.EmployeeEditor;
import org.timesheet.web.editors.TaskEditor;

@Controller
@RequestMapping("/timesheets")
public class TimesheetController {

    static final Logger logger = Logger.getLogger(TimesheetController.class);

    private TimesheetDao timesheetDao;
    private TaskDao taskDao;
    private EmployeeDao employeeDao;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        logger.info("=== TimesheetController === method:initBinder --- start");

        binder.registerCustomEditor(Employee.class, new EmployeeEditor(employeeDao));
        binder.registerCustomEditor(Task.class, new TaskEditor(taskDao));

        logger.info("=== TimesheetController === method:initBinder --- start");
    }

    @Autowired
    public void setTimesheetDao(TimesheetDao timesheetDao) {
        this.timesheetDao = timesheetDao;
    }

    @Autowired
    public void setTaskDao(TaskDao taskDao) {
        this.taskDao = taskDao;
    }

    @Autowired
    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    public TimesheetDao getTimesheetDao() {
        return timesheetDao;
    }

    public TaskDao getTaskDao() {
        return taskDao;
    }

    public EmployeeDao getEmployeeDao() {
        return employeeDao;
    }

    /**
     * Retrieves timesheets, puts them in the model and returns corresponding
     * view
     *
     * @param model Model to put timesheets to
     * @return timesheets/list
     */
    // http://localhost:8083/timesheet/timesheets
    @RequestMapping(method = RequestMethod.GET)
    public String showTimesheets(Model model) {

        logger.info("=== TimesheetController === method:showTimesheets --- start");

        List<Timesheet> timesheets = timesheetDao.list();
        model.addAttribute("timesheets", timesheets);
        
        model.addAttribute("view", "timesheets/list");

        logger.info("=== TimesheetController === method:showTimesheets --- end");

        //return "timesheets/list";
        return "layout/content";
    }

    /**
     * Deletes timeshet with specified ID
     *
     * @param id Timesheet's ID
     * @return redirects to timesheets
     */
    // http://localhost:8083/timesheet/timesheets/delete/{id}
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    //@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String deleteTimesheet(@PathVariable("id") long id) {

        logger.info("=== TimesheetController === method:deleteTimesheet --- start");

        Timesheet toDelete = timesheetDao.find(id);
        timesheetDao.remove(toDelete);

        logger.info("=== TimesheetController === method:deleteTimesheet --- end");

        return "redirect:/timesheets";
    }

    /**
     * Returns timesheet with specified ID
     *
     * @param id Timesheet's ID
     * @param model Model to put timesheet to
     * @return timesheets/view
     */
    // http://localhost:8083/timesheet/timesheets/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getTimesheet(@PathVariable("id") long id, Model model) {

        logger.info("=== TimesheetController === method:getTimesheet --- start");

        Timesheet timesheet = timesheetDao.find(id);
        TimesheetCommand tsCommand = new TimesheetCommand(timesheet);
        model.addAttribute("tsCommand", tsCommand);
        // see file content.jsp
        model.addAttribute("view", "timesheets/");

        logger.info("=== TimesheetController === method:getTimesheet --- end");

        //return "timesheets/view";
        return "layout/content";
    }
    
    //========================= UPDATE TIMESHEET ===============================
    @ModelAttribute("tsCommand")
    public TimesheetCommand updateManagerForm() {
        return new TimesheetCommand();
    }
    
    // http://localhost:8083/timesheet/managers/{id}?update
    @RequestMapping(value = "/{id}", params = "update", method = RequestMethod.GET)
    public String updateTimesheetForm(@PathVariable("id") long id, Model model) {

        logger.info("=== TimesheetsController === method:updateTimesheetForm --- start");

        Timesheet timesheet = timesheetDao.find(id);
        TimesheetCommand tsCommand = new TimesheetCommand(timesheet);
        model.addAttribute("tsCommand", tsCommand);
        // see file content.jsp
        model.addAttribute("view", "timesheets/update_get");
        
        logger.info("=== TimesheetsController === method:updateTimesheetForm --- end");

        //return "timesheets/update";
        return "layout/content";
    }
    
    /**
     * Updates timesheet with given ID
     *
     * @param id ID of timesheet to lookup from DB
     * @param tsCommand Lightweight command object with changed hours
     * @return redirects to timesheets
     */
    // http://localhost:8083/timesheet/timesheets/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String updateTimesheet(@PathVariable("id") long id,
            @Valid @ModelAttribute("tsCommand") TimesheetCommand tsCommand,
            BindingResult result, Model model) {

        logger.info("=== TimesheetController === method:updateTimesheet --- start");

        Timesheet timesheet = timesheetDao.find(id);
        if (result.hasErrors()) {
            tsCommand.setTimesheet(timesheet);
            //TimesheetCommand tsc = new TimesheetCommand(timesheet);
            model.addAttribute("tsCommand", tsCommand);
            
            // when button "Update" has been clicked             
            model.addAttribute("try_update", "updated");
            // see file content.jsp
            model.addAttribute("view", "timesheets/update_post");
            
            //return "timesheets/update";
            return "layout/content";
        }

        // no errors, update timesheet
        timesheet.setHours(tsCommand.getHours());
        timesheetDao.update(timesheet);

        logger.info("=== TimesheetController === method:updateTimesheet --- end");

        return "redirect:/timesheets";
    }

    //=======================CREATE TIMESHEET===================================
    @ModelAttribute("timesheetCreate")
    public TimesheetForm createTimesheetForm() {
        return new TimesheetForm();
    }
    
    // for AJAX
    // http://localhost:8083/timesheet/timesheets/assignedEmployees
    @RequestMapping(value = "/assignedEmployees", method = RequestMethod.POST)
    @ResponseBody
    public String getAssignedEmployees(@RequestParam Long id) {
        Task task = taskDao.find(id);

        List<Employee> assignedEmployees = task.getAssignedEmployees();

        return assignedEmployees.toString();
    } 

    /**
     * Creates form for new timesheet
     *
     * @param model Model to bind to HTML form
     * @return timesheets/new
     */
    // http://localhost:8083/timesheet/timesheets?new
    @RequestMapping(params = "new", method = RequestMethod.GET)
    public String createTimesheetForm(Model model) {

        logger.info("=== TimesheetController === method:createTimesheetForm --- start");

        model.addAttribute("timesheet", new TimesheetForm());

        model.addAttribute("tasks", taskDao.list());
        // see file content.jsp
        model.addAttribute("view", "timesheets/create_get");

//        List<Employee> who = employeeDao.list();
//        model.addAttribute("who", who);

        logger.info("=== TimesheetController === method:createTimesheetForm --- end");

        //return "timesheets/new";
        return "layout/content";
    }

    /**
     * Saves new Timesheet to the database
     *
     * @param timesheet Timesheet to save
     * @return redirects to timesheets
     */
    // http://localhost:8083/timesheet/timesheets
    @RequestMapping(method = RequestMethod.POST)
    public String addTimesheet(@ModelAttribute("timesheetCreate") @Validated TimesheetForm timesheetForm,
            BindingResult bindingResult, Model model) {

        logger.info("=== TimesheetController === method:addTimesheet --- start");

        if (bindingResult.hasErrors()) {

            model.addAttribute("timesheet", new TimesheetForm());

            model.addAttribute("tasks", taskDao.list());

            List<Employee> who = employeeDao.list();
            model.addAttribute("who", who);

            // when button "Create" has been clicked             
            model.addAttribute("try_create", "created");
            // see file content.jsp
            model.addAttribute("view", "timesheets/create_post");
            //return "timesheets/new";
            return "layout/content";
        }
        
        Long who_id = Long.parseLong(timesheetForm.getWho());
        Employee who  = employeeDao.find(who_id);
        
        Long task_id = Long.parseLong(timesheetForm.getTasks());
        Task task = taskDao.find(task_id);
                
        Timesheet timesheet = new Timesheet(who, task, timesheetForm.getHours());

        timesheetDao.add(timesheet);
        
        
        logger.info("=== TimesheetController === method:addTimesheet --- end");

        return "redirect:/timesheets";
    }

}
