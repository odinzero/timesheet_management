package org.timesheet.web;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.timesheet.domain.Manager;
import org.timesheet.forms.EmployeeForm;
import org.timesheet.forms.ManagerForm;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.web.exceptions.ManagerDeleteException;

@Controller
@RequestMapping("/managers")
public class ManagerController {
    
    static final Logger logger = Logger.getLogger(ManagerController.class);

    private ManagerDao managerDao;

    @Autowired
    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    public ManagerDao getManagerDao() {
        return managerDao;
    }

    /**
     * Retrieves managers, puts them in the model and returns corresponding view
     * @param model Model to put managers to
     * @return managers/list
     */
    // http://localhost:8083/timesheet/managers
    @RequestMapping(method = RequestMethod.GET)
    public String showManagers(Model model) {
        
        logger.info("=== ManagerController === method:showManagers --- start");
        
        List<Manager> managers = managerDao.list();
        model.addAttribute("managers", managers);
        
        model.addAttribute("view", "managers/list");
        
        logger.info("=== ManagerController === method:showManagers --- end");

        //return "managers/list";
        return "layout/content";
    }

    /**
     * Deletes manager with specified ID
     * @param id Manager's ID
     * @return redirects to managers if everything was OK
     * @throws ManagerDeleteException When manager cannot be deleted
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteManager(@PathVariable("id") long id)
            throws ManagerDeleteException {
        
        logger.info("=== ManagerController === method:deleteManager --- start");

        Manager toDelete = managerDao.find(id);
        boolean wasDeleted = managerDao.removeManager(toDelete);

        if (!wasDeleted) {
            throw new ManagerDeleteException(toDelete);
        }
        
        logger.info("=== ManagerController === method:deleteManager --- end");

        // everything OK, see remaining managers
        return "redirect:/managers";
    }

    /**
     * Handles ManagerDeleteException
     * @param e Thrown exception with manager that couldn't be deleted
     * @return binds manager to model and returns managers/delete-error
     */
    @ExceptionHandler(ManagerDeleteException.class)
    public ModelAndView handleDeleteException(ManagerDeleteException e) {
        
        logger.info("=== ManagerController === method:handleDeleteException --- start");
        
        ModelMap model = new ModelMap();
        model.put("manager", e.getManager());
        
        logger.info("=== ManagerController === method:handleDeleteException --- end");
        
        return new ModelAndView("managers/delete-error", model);
    }

    /**
     * Returns manager with specified ID
     * @param id Managers's ID
     * @param model Model to put manager to
     * @return managers/view
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getManager(@PathVariable("id") long id, Model model) {
        
        logger.info("=== ManagerController === method:getManager --- start");
        
        Manager manager = managerDao.find(id);
        model.addAttribute("manager", manager);
        
        model.addAttribute("view", "managers/");
        
        logger.info("=== ManagerController === method:getManager --- end");

        //return "managers/view";
        return "layout/content";
    }
    
    // ========================== UPDATE =======================================
    @ModelAttribute("managerUpdate")
    public ManagerForm updateManagerForm() {
        return new ManagerForm();
    }
    
    // http://localhost:8083/timesheet/managers/{id}?update
    @RequestMapping(value = "/{id}", params = "update", method = RequestMethod.GET)
    //public ModelAndView updateManagerForm(@PathVariable("id") long id, Model model) {
      public String updateManagerForm(@PathVariable("id") long id, Model model) {          

        logger.info("=== ManagerController === method:updateManagerForm --- start");

        Manager manager = managerDao.find(id);
        model.addAttribute("manager", manager);
        
        model.addAttribute("view", "managers/update_get");
        
        logger.info("=== ManagerController === method:updateManagerForm --- end");

        // return "employees/new";
        //return new ModelAndView("managers/update", "command", new ManagerForm());
        return "layout/content";
    }

    /**
     * Updates manager with specified ID
     * @param id Manager's ID
     * @param manager Manager to update (bounded from HTML form)
     * @return redirects to managers
     */
    // http://localhost:8083/timesheet/managers/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    //public String updateManager(@PathVariable("id") long id, Manager manager) {
      public String updateManager(@PathVariable("id") long id, 
            @ModelAttribute("managerUpdate") @Validated ManagerForm managerForm,
            BindingResult bindingResult, Model model) {          
        
        logger.info("=== ManagerController === method:updateManager --- start");

        if (bindingResult.hasErrors()) {
            
              // when button "Update" has been clicked             
              model.addAttribute("try_update", "updated");
              model.addAttribute("view", "managers/update_post");
            
              return "layout/content";
            //return "managers/update";
        }
         
        Manager manager = managerDao.find(id);  
        manager.setId(id);
        manager.setName(managerForm.getName());
        
        managerDao.update(manager);
        
        logger.info("=== ManagerController === method:updateManager --- end");

        return "redirect:/managers";
    }

    // ========================== CREATE =======================================
    @ModelAttribute("managerCreate")
    public ManagerForm createManagerForm() {
        return new ManagerForm();
    }
    /**
     * Creates form for new manager
     * @param model Model to bind to HTML form
     * @return manager/new
     */
    // http://localhost:8083/timesheet/managers?new
    @RequestMapping(params = "new", method = RequestMethod.GET)
    public String createManagerForm(Model model) {
        
        logger.info("=== ManagerController === method:createManagerForm --- start");

        model.addAttribute("manager", new Manager());
        
        model.addAttribute("view", "managers/create_get");
        
        logger.info("=== ManagerController === method:createManagerForm --- end");

        //return "managers/new";
        return "layout/content";
    }

    /**
     * Saves new manager to the database
     * @param manager Manager to save
     * @return redirects to managers
     */
    // http://localhost:8083/timesheet/managers
    @RequestMapping(method = RequestMethod.POST)
   // public String addManager(Manager manager) {
        public String addManager(@ModelAttribute("managerCreate") @Validated ManagerForm managerForm,
            BindingResult bindingResult, Model model) {         
        
        logger.info("=== ManagerController === method:addManager --- start");

        if (bindingResult.hasErrors()) {
            
            // when button "Create" has been clicked             
            model.addAttribute("try_create", "created");
            // see file content.jsp
            model.addAttribute("view", "managers/create_post");
            
            //return "managers/new";
            return "layout/content";
        }

        Manager manager = new Manager(managerForm.getName());
        managerDao.add(manager);
        
        logger.info("=== ManagerController === method:addManager --- end");

        return "redirect:/managers";
    }

}
