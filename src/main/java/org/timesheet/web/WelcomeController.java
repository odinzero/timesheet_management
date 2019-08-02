package org.timesheet.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timesheet.web.helpers.EntityGenerator;

import javax.annotation.PostConstruct;
import java.util.Date;
import org.apache.log4j.Logger;

//@Controller
//@RequestMapping("/welcome")
public class WelcomeController {
    
    static final Logger logger = Logger.getLogger(WelcomeController.class);

    @Autowired
    private EntityGenerator entityGenerator;

    @RequestMapping(method = RequestMethod.GET)
    public String showMenu(Model model) {
        
        logger.info("=== WelcomeController === method:showMenu --- start");
        
        model.addAttribute("today", new Date());
        
        logger.info("=== WelcomeController === method:showMenu --- end");
        
        return "index";
    }

    @PostConstruct
    public void prepareFakeDomain() {
        logger.info("=== WelcomeController === method:prepareFakeDomain --- start");
        
        entityGenerator.deleteDomain();
        entityGenerator.generateDomain();
        
        logger.info("=== WelcomeController === method:prepareFakeDomain --- end");
        
    }
    
}
