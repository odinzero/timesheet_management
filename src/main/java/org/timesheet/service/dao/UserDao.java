package org.timesheet.service.dao;

import org.timesheet.domain.User;
import org.timesheet.service.GenericDao;

/**
 * DAO of User.
 */
public interface UserDao extends GenericDao<User, Long> {

    /**
     * Tries to remove user from the system.
     * @param user User to remove
     * @return {@code true} if user is not assigned to any task
     * or timesheet. Else {@code false}.
     */
    boolean removeUser(User user);
    
    
    boolean tryLogin(User user);

}
