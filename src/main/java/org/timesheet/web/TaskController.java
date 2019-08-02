package org.timesheet.web;

import java.util.*;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.apache.log4j.Level;
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

/**
 * Controller for handling Tasks.
 */
@Controller
@RequestMapping("/tasks")
public class TaskController {

    // private static final Logger logger = LoggerFactory.getLogger(TaskController.class);
    static final Logger logger = Logger.getLogger(TaskController.class);

    private TaskDao taskDao;
    private EmployeeDao employeeDao;
    private ManagerDao managerDao;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        logger.info("=== TaskController === method:initBinder --- start");
        binder.registerCustomEditor(Manager.class, new ManagerEditor(managerDao));
        logger.info("=== TaskController === method:initBinder --- end");
    }

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

    /**
     * Retrieves tasks, puts them in the model and returns corresponding view
     *
     * @param model Model to put tasks to
     * @return tasks/list
     */
    // http://localhost:8083/timesheet/tasks
    @RequestMapping(method = RequestMethod.GET)
    public String showTasks(Model model) {

        //logger.error("This is Error message", new Exception("Testing"));
        logger.info("=== TaskController === method:showTasks --- start");

        model.addAttribute("tasks", taskDao.list());
        //  see file content.jsp
        model.addAttribute("view", "tasks/list");

        logger.info("=== TaskController === method:showTasks --- end");

        //return "tasks/list";
        return "layout/content";
    }

    /**
     * Deletes task with specified ID
     *
     * @param id Task's ID
     * @return redirects to tasks if everything was ok
     * @throws TaskDeleteException When task cannot be deleted
     */
    // http://localhost:8083/timesheet/tasks/delete/{id}
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    // @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
    public String deleteTask(@PathVariable("id") long id)
            throws TaskDeleteException {

        logger.info("=== TaskController === method:deleteTask --- start");

        Task toDelete = taskDao.find(id);
        boolean wasDeleted = taskDao.removeTask(toDelete);

        if (!wasDeleted) {
            throw new TaskDeleteException(toDelete);
        }

        logger.info("=== TaskController === method:deleteTask --- end");

        // everything OK, see remaining tasks
        return "redirect:/tasks";
    }

    /**
     * Handles TaskDeleteException
     *
     * @param e Thrown exception with task that couldn't be deleted
     * @return binds task to model and returns tasks/delete-error
     */
    @ExceptionHandler(TaskDeleteException.class)
    public ModelAndView handleDeleteException(TaskDeleteException e) {

        logger.info("=== TaskController === method:handleDeleteException --- start");

        ModelMap model = new ModelMap();
        model.put("task", e.getTask());

        logger.info("=== TaskController === method:handleDeleteException --- end");
        return new ModelAndView("tasks/delete-error", model);
    }

    /**
     * Returns task with specified ID
     *
     * @param id Tasks's ID
     * @param model Model to put task to
     * @return tasks/view
     */
    // http://localhost:8083/timesheet/tasks/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getTask(@PathVariable("id") long id, Model model) {

        logger.info("=== TaskController === method:getTask --- start");

        Task task = taskDao.find(id);
        model.addAttribute("task", task);

        // add all remaining employees
        List<Employee> employees = employeeDao.list();
        Set<Employee> unassignedEmployees = new HashSet<Employee>();

        for (Employee employee : employees) {
            if (!task.getAssignedEmployees().contains(employee)) {
                unassignedEmployees.add(employee);
            }
        }

        model.addAttribute("unassigned", unassignedEmployees);
        //  see file content.jsp
        model.addAttribute("view", "tasks/");
        

        logger.info("=== TaskController === method:getTask --- end");

        //return "tasks/view";
        return "layout/content";
    }

    /**
     * Removes assigned employee from task
     *
     * @param taskId Task's ID
     * @param employeeId Assigned employee's ID
     */
    // http://localhost:8083/timesheet/tasks/{id}/employees/{employeeId}
    @RequestMapping(value = "/{id}/employees/{employeeId}", method = RequestMethod.DELETE)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeEmployee(
            @PathVariable("id") long taskId,
            @PathVariable("employeeId") long employeeId) {

        logger.info("=== TaskController === method:removeEmployee --- start");

        Employee employee = employeeDao.find(employeeId);
        Task task = taskDao.find(taskId);

        task.removeEmployee(employee);
        taskDao.update(task);

        logger.info("=== TaskController === method:removeEmployee --- end");
    }

    /**
     * Assigns employee to task
     *
     * @param taskId Task's ID
     * @param employeeId Employee's ID (to assign)
     * @return redirects back to altered task: tasks/taskId
     */
    // http://localhost:8083/timesheet/tasks/{id}/employees/{employeeId}
    @RequestMapping(value = "/{id}/employees/{employeeId}", method = RequestMethod.PUT)
    public String addEmployee(
            @PathVariable("id") long taskId,
            @PathVariable("employeeId") long employeeId) {

        logger.info("=== TaskController === method:addEmployee --- start");

        Employee employee = employeeDao.find(employeeId);
        Task task = taskDao.find(taskId);

        task.addEmployee(employee);
        taskDao.update(task);

        logger.info("=== TaskController === method:addEmployee --- end");

        return "redirect:/tasks/" + taskId;
    }

    //============================= UPDATE TASK ================================
    @ModelAttribute("taskUpdate")
    public TaskForm updateTaskForm() {
        return new TaskForm();
    }

    // http://localhost:8083/timesheet/tasks/{id}?update
    @RequestMapping(value = "/{id}", params = "update", method = RequestMethod.GET)
    public String updateTaskForm(@PathVariable("id") long id, Model model) {

        logger.info("=== TaskController === method:updateTaskForm --- start");

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
        //  see file content.jsp
        model.addAttribute("view", "tasks/update_get");

        logger.info("=== TaskController === method:updateTaskForm --- end");

        //return "tasks/update";
        //return new ModelAndView("tasks/update", "command", new TaskForm());
        return "layout/content";
    }

    /**
     * Updates task with specified ID
     *
     * @param id Task's ID
     * @param task Task to update (bounded from HTML form)
     * @return redirects to tasks
     */
    // http://localhost:8083/timesheet/tasks/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String updateTask(@PathVariable("id") long id,
            @ModelAttribute("taskUpdate") @Validated TaskForm taskForm,
            BindingResult bindingResult, Model model) {

        logger.info("=== TaskController === method:updateTask --- start");

        Task task = taskDao.find(id);
        task.setId(id);
        task.setDescription(taskForm.getDescription());
        task.setCompleted(taskForm.isCompleted());

        List<Employee> assignedEmployees = new ArrayList<Employee>();
        String[] aemp = taskForm.getAssignedEmployees();
        for (int i = 0; i < aemp.length; i++) {
            String string = aemp[i];

            Long aemployee_id = Long.parseLong(string);
            Employee aemployee = employeeDao.find(aemployee_id);
            assignedEmployees.add(aemployee);
        }

        task.setAssignedEmployees(assignedEmployees);

        // load list of managers to choose from DROPDOWN LIST =MANAGERS=
        List<Manager> managers = managerDao.list();
        model.addAttribute("managers", managers);
        // set selected value in DROPDOWN LIST =Managers=
        if(taskForm.getManagers() != "") {
          Long manager_id = Long.parseLong(taskForm.getManagers());
          Manager manager = managerDao.find(manager_id);
          model.addAttribute("selectedManId", manager_id);
          task.setManager(manager);
        }
        
        // just for keeping in form action URL ${task.id}
        model.addAttribute("task", task);
        
        model.addAttribute("description", taskForm.getDescription());
        model.addAttribute("completed", taskForm.isCompleted());
        model.addAttribute("assignedEmployees", assignedEmployees);
        model.addAttribute("manager", taskForm.getManagers());
        model.addAttribute("completed", task.isCompleted());

        // add all remaining employees
        List<Employee> employees = employeeDao.list();
        Set<Employee> unassignedEmployees = new HashSet<Employee>();

        for (Employee employee : employees) {
            if (!task.getAssignedEmployees().contains(employee)) {
                unassignedEmployees.add(employee);
            }
        }

        model.addAttribute("unassignedEmployees", unassignedEmployees);
        
         if (bindingResult.hasErrors()) { 
           
            // when button "Update" has been clicked             
            model.addAttribute("try_update", "updated");
            //  see file content.jsp
            model.addAttribute("view", "tasks/update_post");
            
            //return "tasks/update";
            return "layout/content";
        }  
         
        taskDao.update(task);
        
        logger.info("=== TaskController === method:updateManager --- end");

        return "redirect:/tasks";
        //return "tasks/newjsp";
    }

    //============================= CREATE TASK ================================
    @ModelAttribute("taskCreate")
    public TaskForm createTaskForm() {
        return new TaskForm();
    }

    /**
     * Creates form for new task.
     *
     * @param model Model to bind to HTML form
     * @return tasks/new
     */
    // http://localhost:8083/timesheet/tasks?new
    @RequestMapping(params = "new", method = RequestMethod.GET)
    //public ModelAndView createTaskForm(Model model) {
     public String createTaskForm(Model model) {

        logger.info("=== TaskController === method:createTaskForm --- start");

        model.addAttribute("task", new TaskForm());

        // list of managers to choose from
        List<Manager> managers = managerDao.list();
//        Map<String, String> managers = new HashMap<String, String>();
//        managers.put("1", "United States");
//        managers.put("2", "China");
//        managers.put("3", "Singapore");
//        managers.put("4", "Malaysia");
        model.addAttribute("managers", managers);
        
        //  see file content.jsp
        model.addAttribute("view", "tasks/create_get");

        logger.info("=== TaskController === method:createTaskForm --- end");

        // https://dev.mysql.com/doc/ndbapi/en/mccj-using-clusterj-mappings.html
        // return "tasks/new";
        //return new ModelAndView("tasks/new", "command", new TaskForm());
        return "layout/content";
    }

    /**
     * Saves new task to the database
     *
     * @param task Task to save
     * @return redirects to tasks
     */
    // http://localhost:8083/timesheet/tasks
    @RequestMapping(method = RequestMethod.POST)
//    public String addTask(Task task) {  @RequestParam("managerId") Long managerId,
    public String addTask(@ModelAttribute("taskCreate") @Validated TaskForm taskForm,
            BindingResult bindingResult, Model model) {

        logger.info("=== TaskController === method:addTask --- start");

        if (bindingResult.hasErrors()) {

            List<Manager> managers = managerDao.list();
            model.addAttribute("managers", managers);
            
            //  see file content.jsp
            model.addAttribute("view", "tasks/create_post");

            //return "tasks/new";
            return "layout/content";
        }

        // generate employees
        List<Employee> employees = reduce(employeeDao.list());

        Task task = new Task(taskForm.getDescription(), taskForm.getManager());
        task.setCompleted(false);
        task.setAssignedEmployees(employees);

        // get ID manager from DROPDOWN LIST of managers
        Long id = Long.parseLong(taskForm.getManagers());
        Manager manager = managerDao.find(id);
        task.setManager(manager);

        taskDao.add(task);

        // model.addAttribute("managerId", task.get());
//        model.addAttribute("employees", task.getAssignedEmployees());
//        model.addAttribute("description", taskForm.getDescription());
//        model.addAttribute("manager", taskForm.getManagers());
//        model.addAttribute("completed", task.isCompleted());
//        model.addAttribute("task", task);
        logger.info("=== TaskController === method:addTask --- end");

        return "redirect:/tasks";
        //  return "tasks/newjsp";
    }

    /**
     * Reduces list of employees to some smaller amount. Simulates user
     * interaction.
     *
     * @param employees Employees to reduced
     * @return New list of some employees from original employees list
     */
    private List<Employee> reduce(List<Employee> employees) {

        logger.info("=== TaskController === method:reduce --- start");

        List<Employee> reduced = new ArrayList<Employee>();
        Random random = new Random();
        int amount = random.nextInt(employees.size()) + 1;

        // max. five employees
        amount = amount > 3 ? 3 : amount;

        for (int i = 0; i < amount; i++) {
            int randomIdx = random.nextInt(employees.size());
            Employee employee = employees.get(randomIdx);
            reduced.add(employee);
            employees.remove(employee);
        }

        logger.info("=== TaskController === method:reduce --- end");

        return reduced;
    }

}