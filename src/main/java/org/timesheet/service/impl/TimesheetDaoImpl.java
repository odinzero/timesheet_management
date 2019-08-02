package org.timesheet.service.impl;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;
import org.timesheet.domain.Timesheet;
import org.timesheet.service.dao.TimesheetDao;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.transaction.annotation.Transactional;

@Repository("timesheetDao")
public class TimesheetDaoImpl extends HibernateDao<Timesheet, Long> implements TimesheetDao {
    
    static final Logger logger = Logger.getLogger(TimesheetDaoImpl.class);

    @Override
    public List<Timesheet> list() {
        logger.info("=== TimesheetDaoImpl === method:list ");
        
        return currentSession().createCriteria(Timesheet.class)
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
    }
}
