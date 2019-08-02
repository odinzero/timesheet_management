package org.timesheet.service.impl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.timesheet.domain.Employee;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.service.TimesheetService;
import org.timesheet.service.dao.TaskDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.apache.log4j.Logger;

@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
@Service("timesheetService")
public class TimesheetServiceImpl implements TimesheetService {
    
    static final Logger logger = Logger.getLogger(TimesheetServiceImpl.class);

    // dependencies
    private SessionFactory sessionFactory;
    private TaskDao taskDao;

    private Random random = new Random();

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Autowired
    public void setTaskDao(TaskDao taskDao) {
        this.taskDao = taskDao;
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public TaskDao getTaskDao() {
        return taskDao;
    }

    private Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Task busiestTask() {
        logger.info("=== TimesheetServiceImpl === method:busiestTask --- start " );
        
        List<Task> tasks = taskDao.list();
        if (tasks.isEmpty()) {
            return null;
        }
        
        logger.info("=== TimesheetServiceImpl === method:busiestTask --- inside: "  + tasks.toString());
        
        Task busiest = tasks.get(0);
        for (Task task : tasks) {
            if (task.getAssignedEmployees().size() > busiest.getAssignedEmployees().size()) {
                busiest = task;
            }
        }
        
        logger.info("=== TimesheetServiceImpl === method:busiestTask --- end :"  + busiest);
        
        return busiest;
    }

    @Override
    public List<Task> tasksForEmployee(Employee employee) {
        logger.info("=== TimesheetServiceImpl === method:tasksForEmployee --- start :" + employee);
        
        List<Task> allTasks = taskDao.list();
        List<Task> tasksForEmployee = new ArrayList<Task>();
        
        for (Task task : allTasks) {
            if (task.getAssignedEmployees().contains(employee)) {
                tasksForEmployee.add(task);
            }
        }
        
        logger.info("=== TimesheetServiceImpl === method:tasksForEmployee --- end : "  + tasksForEmployee);

        return tasksForEmployee;
    }

    @Override
    public List<Task> tasksForManager(Manager manager) {
        logger.info("=== TimesheetServiceImpl === method:tasksForManager --- start :" + manager.toString());
        
        Query query = currentSession()
                .createQuery("from Task t where t.manager.id = :id");
        query.setParameter("id", manager.getId());
        
        logger.info("=== TimesheetServiceImpl === method:tasksForManager --- end");
        
        return query.list();
    }
}
