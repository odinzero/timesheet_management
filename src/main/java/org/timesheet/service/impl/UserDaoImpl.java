package org.timesheet.service.impl;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.timesheet.domain.User;
import org.timesheet.service.dao.UserDao;

@Repository("userDao")
public class UserDaoImpl extends HibernateDao<User, Long> implements UserDao {

    static final Logger logger = Logger.getLogger(UserDaoImpl.class);

    @Override
    public boolean removeUser(User user) {

        logger.info("=== UserDaoImpl === method:removeUser --- start");

        remove(user);

        logger.info("=== UserDaoImpl === method:removeUser --- end");

        return true;
    }

    @Override
    public boolean tryLogin(User user) {

        Criteria criteria = currentSession().createCriteria(User.class);

        criteria.add(Restrictions.eq("username", user.getUsername()).ignoreCase());
        criteria.add(Restrictions.eq("password_hash", user.getPassword_hash()));

        User member = (User) criteria.uniqueResult();
        
        if(member != null) {
            
           logger.info("=== UserDaoImpl === method:tryLogin --- : " + true); 
           return true; 
        } else {
           logger.info("=== UserDaoImpl === method:tryLogin --- : " + false); 
           return false;
        }
        
       
    }

}
