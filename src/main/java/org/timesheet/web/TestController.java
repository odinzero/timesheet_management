
package org.timesheet.web;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.timesheet.web.helpers.ApplicationContextUtils;

@Controller
@RequestMapping("/test")
public class TestController { 
    
    private BeanFactory beanFactory;    
     
    public void setBeanFactory(BeanFactory beanFactory) {
        this.beanFactory = beanFactory;
    }
    
    @RequestMapping(value = "/beans", method = RequestMethod.GET)
    public void beans(){
        
       // String[] allBeanNames = applicationContext.getBeanDefinitionNames();
//        ApplicationContext appCtx = ApplicationContextUtils
//				.getApplicationContext();
//        String[] allBeanNames = appCtx.getBeanDefinitionNames();
        
        ConfigurableBeanFactory configurableBeanFactory = (ConfigurableBeanFactory) beanFactory;
        String[] allBeanNames =  configurableBeanFactory.getSingletonNames();
        
        for(String beanName : allBeanNames) {
            System.out.println(beanName);
        }
    }
}
