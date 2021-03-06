package org.timesheet.service.impl;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.timesheet.domain.Employee;
import org.timesheet.service.dao.EmployeeDao;

@Repository("employeeDao")
public class EmployeeDaoImpl extends HibernateDao<Employee, Long> implements EmployeeDao {
    
    static final Logger logger = Logger.getLogger(EmployeeDaoImpl.class);

    @Override
    public boolean removeEmployee(Employee employee) {
        
        logger.info("=== EmployeeDaoImpl === method:removeEmployee --- start");
        
        Query employeeTaskQuery = currentSession().createQuery(
                "from Task t where :id in elements(t.assignedEmployees)");
        employeeTaskQuery.setParameter("id", employee.getId());

        // employee mustn't be assigned on no task
        if (!employeeTaskQuery.list().isEmpty()) {
            return false;
        }

        Query employeeTimesheetQuery = currentSession().createQuery(
                "from Timesheet t where t.who.id = :id");
        employeeTimesheetQuery.setParameter("id", employee.getId());

        // employee mustn't be assigned to any timesheet
        if (!employeeTimesheetQuery.list().isEmpty()) {
            return false;
        }

        // ok, remove as usual
        remove(employee);
        
        logger.info("=== EmployeeDaoImpl === method:removeEmployee --- end");
        
        return true;

    }
}
