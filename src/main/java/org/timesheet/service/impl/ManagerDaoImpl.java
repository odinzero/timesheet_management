package org.timesheet.service.impl;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.timesheet.domain.Manager;
import org.timesheet.service.dao.ManagerDao;

@Repository("managerDao")
public class ManagerDaoImpl extends HibernateDao<Manager, Long> implements ManagerDao {
    
    static final Logger logger = Logger.getLogger(ManagerDaoImpl.class);

    @Override
    public boolean removeManager(Manager manager) {
        logger.info("=== ManagerDaoImpl === method:removeManager --- start : " + manager);
        
        Query managerQuery = currentSession().createQuery(
                "from Task t where t.manager.id = :id");
        managerQuery.setParameter("id", manager.getId());
        
        logger.info("=== ManagerDaoImpl === method:removeManager --- inside : " + managerQuery.toString());

        // manager mustn't be assigned on no task
        if (!managerQuery.list().isEmpty()) {
            return false;
        }

        // ok, remove as usual
        remove(manager);
        
        logger.info("=== ManagerDaoImpl === method:removeManager --- end : " + manager);
        
        return true;
    }
}
