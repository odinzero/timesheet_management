
package org.timesheet.web;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/loadschema")
public class LoadschemaController {
    
     // http://localhost:8083/timesheet/loadschema/menu
    @RequestMapping(value = "menu", method = RequestMethod.GET)
    public String menu() {
        
        return "load/menu";
    }
    
    // http://localhost:8083/timesheet/loadschema/loadtablesdata
    @RequestMapping(value = "loadtablesdata", method = RequestMethod.POST)
    @ResponseBody
    public String loadTablesData() {
        
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:persistence-beans_1.xml");
        
        //return "load/result";
        return "Tables data loaded successfully.";
    }
    
    // http://localhost:8083/timesheet/loadschema/removetablesdata
    @RequestMapping(value = "removetablesdata", method = RequestMethod.POST)
    @ResponseBody
    public String removeTablesData() {
        
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:persistence-beans_2.xml");
        
        //return "load/result2";
        return "Tables data removed successfully.";
    }
    
     // http://localhost:8083/timesheet/loadschema/removetables
    @RequestMapping(value = "removetables", method = RequestMethod.POST)
    @ResponseBody
    public String removeTables() {
        
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:persistence-beans_3.xml");
        
        return "Tables removed successfully.";
    }
    
     // http://localhost:8083/timesheet/loadschema/createtables
    @RequestMapping(value = "createtables", method = RequestMethod.POST)
    @ResponseBody
    public String createTables() {
        
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:persistence-beans_4.xml");
        
        return "Tables created successfully.";
    }
    
}
