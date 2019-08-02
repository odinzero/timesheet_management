package org.timesheet.service.impl;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.timesheet.domain.Task;
import org.timesheet.domain.Timesheet;
import org.timesheet.service.dao.TaskDao;

@Repository("taskDao")
public class TaskDaoImpl extends HibernateDao<Task, Long> implements TaskDao {
    
    static final Logger logger = Logger.getLogger(TaskDaoImpl.class);

    @Override
    public boolean removeTask(Task task) {
        logger.info("=== TaskDaoImpl === method:removeTask --- start : " + task);
        
        Query taskQuery = currentSession().createQuery(
                "from Timesheet t where t.task.id = :id");
        taskQuery.setParameter("id", task.getId());
        
        logger.info("=== TaskDaoImpl === method:removeTask --- inside : " + taskQuery.toString());

        // task mustn't be assigned to no timesheet
        if (!taskQuery.list().isEmpty()) {
            return false;
        }

        logger.info("=== TaskDaoImpl === method:removeTask --- end : " + task);
        // ok, remove as usual
        remove(task);
        return true;
    }

    @Override
    public List<Task> list() {
        logger.info("=== TaskDaoImpl === method:list ");
        
        return currentSession().createCriteria(Task.class)
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
    }
}
