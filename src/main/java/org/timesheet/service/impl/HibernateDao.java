package org.timesheet.service.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.timesheet.service.GenericDao;

/**
 * Basic DAO operations dependent with Hibernate's specific classes
 *
 * @see SessionFactory
 */
@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
public class HibernateDao<E, K extends Serializable> implements GenericDao<E, K> {

    static final Logger logger = Logger.getLogger(HibernateDao.class);

    private SessionFactory sessionFactory;
    protected Class<? extends E> daoType;

    public HibernateDao() {
        logger.info("=== HibernateDao === construct --- start");
        daoType = (Class<E>) ((ParameterizedType) getClass().getGenericSuperclass())
                .getActualTypeArguments()[0];
        logger.info("=== HibernateDao === construct --- end : " + daoType);
    }

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    protected Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void add(E entity) {
        logger.info("=== HibernateDao === method:add --- start: " + entity);
        currentSession().save(entity);
        logger.info("=== HibernateDao === method:add --- end");
    }

    @Override
    public void update(E entity) {
        logger.info("=== HibernateDao === method:update --- start: " + entity);
        currentSession().saveOrUpdate(entity);
        logger.info("=== HibernateDao === method:update --- end");
    }

    @Override
    public void remove(E entity) {
        logger.info("=== HibernateDao === method:remove --- start: " + entity);
        currentSession().delete(entity);
        logger.info("=== HibernateDao === method:remove --- end");
    }

    @Override
    public E find(K key) {
        logger.info("=== HibernateDao === method:find ---: " + key + " ---  " + daoType);
        logger.info("=== HibernateDao === method:find ---: " + (E) currentSession().get(daoType, key));
        return (E) currentSession().get(daoType, key);
    }

    @Override
    public List<E> list() {
        logger.info("=== HibernateDao === method:list ---: "
                + currentSession().createCriteria(daoType).list());

        // Transaction tx = currentSession().beginTransaction();
        return currentSession().createCriteria(daoType).list();
    }

    @Override
    public List<E> findAllSorted(String sortBy, String sortOrder) {
        logger.info("=== HibernateDao === method:findAllSorted --- start ");

        Criteria criteria = currentSession().createCriteria(daoType);

        if (sortOrder.equals("asc")) {
            criteria.addOrder(Order.asc(sortBy));
            logger.info("=== HibernateDao === method:findAllSorted ---  asc");
        }

        if (sortOrder.equals("desc")) {
            criteria.addOrder(Order.desc(sortBy));
            logger.info("=== HibernateDao === method:findAllSorted ---  desc ");
        }

        logger.info("=== HibernateDao === method:findAllSorted --- end : " + criteria.list() + " "
                + sortBy + " " + sortOrder);

        return criteria.list();
    }

    @Override
    public List<E> searchAll(String[] sortBy, String[] word) {

        Criteria criteria = currentSession().createCriteria(daoType);

        for (int i = 0; i < sortBy.length; i++) {

            if (sortBy[i] == "id") {
                if (word[i] != "") {
                    criteria.add(Restrictions.like(sortBy[i], Long.parseLong(word[i])));
                }
            } else {
                criteria.add(Restrictions.like(sortBy[i], word[i], MatchMode.ANYWHERE));
            }

            logger.info("=== HibernateDao === method:findAllSorted --- end : " + sortBy[i] + " " + word[i]);
        }

        return criteria.list();
    }

    @Override
    public List<E> findAllSorted(String[] sortByField, String[] word, String sortBy, String sortOrder) {

        logger.info("=== HibernateDao === method:findAllSorted2 --- start ");

        Criteria criteria = currentSession().createCriteria(daoType);

        for (int i = 0; i < sortByField.length; i++) {

            if (sortByField[i] == "id") {
                if (word[i] != "") {
                    criteria.add(Restrictions.like(sortByField[i], Long.parseLong(word[i])));
                }
            } // other fields
            else {
                criteria.add(Restrictions.like(sortByField[i], word[i], MatchMode.ANYWHERE));
            }

            logger.info("=== HibernateDao === method:findAllSorted2 --- cycle : " + sortByField[i] + " " + word[i]);
        }

        if (sortOrder.equals("asc")) {
            criteria.addOrder(Order.asc(sortBy));
            logger.info("=== HibernateDao === method:findAllSorted2 ---  asc");
        }

        if (sortOrder.equals("desc")) {
            criteria.addOrder(Order.desc(sortBy));
            logger.info("=== HibernateDao === method:findAllSorted2 ---  desc ");
        }

        logger.info("=== HibernateDao === method:findAllSorted2 --- end  ");

        return criteria.list();
    }

    @Override
    public List<E> findAllPaginated(int page, int size) {
        logger.info("=== HibernateDao === method:findAllPaginated --- start ");

        Criteria criteria = currentSession().createCriteria(daoType);
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        criteria.addOrder(Order.asc("id"));
        criteria.setFirstResult((page - 1) * size);
        criteria.setMaxResults(size);

        logger.info("=== HibernateDao === method:findAllPaginated --- end ");

        return criteria.list();
    }

    @Override
    public Long countTotalItems() {

        Criteria criteria = currentSession().createCriteria(daoType);
        criteria.setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
    }

    @Override
    public List<E> findAllPaginatedAndSorted(int page, int size, String sortBy, String sortOrder) {
        logger.info("=== HibernateDao === method:findAllPaginatedAndSorted1 --- start ");

        Criteria criteria = currentSession().createCriteria(daoType);
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        criteria.setFirstResult((page - 1) * size);
        criteria.setMaxResults(size);

        if (sortOrder.equals("asc")) {
            criteria.addOrder(Order.asc(sortBy));
        }

        if (sortOrder.equals("desc")) {
            criteria.addOrder(Order.desc(sortBy));
        }
        
        //criteria.setFetchSize(size);

        logger.info("=== HibernateDao === method:findAllPaginatedAndSorted1 --- end ");

        return criteria.list();
    }

    @Override
    public List<E> findAllPaginatedAndSorted(String[] sortByField, String[] word, int page, int size, String sortBy, String sortOrder) {

        logger.info("=== HibernateDao === method:findAllPaginatedAndSorted --- start ");

        Criteria criteria = currentSession().createCriteria(daoType);
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        criteria.setFirstResult((page - 1) * size);
        criteria.setMaxResults(size);

        for (int i = 0; i < sortByField.length; i++) {

            if (sortByField[i] == "id") {
                if (word[i] != "") {
                    criteria.add(Restrictions.like(sortByField[i], Long.parseLong(word[i])));
                }
            } // other fields
            else {
                criteria.add(Restrictions.like(sortByField[i], word[i], MatchMode.ANYWHERE));
            }

            logger.info("=== HibernateDao === method:findAllPaginatedAndSorted --- cycle : " + sortByField[i] + " " + word[i]);
        }

        if (sortOrder.equals("asc")) {
            criteria.addOrder(Order.asc(sortBy));
        }

        if (sortOrder.equals("desc")) {
            criteria.addOrder(Order.desc(sortBy));
        }

        logger.info("=== HibernateDao === method:findAllPaginatedAndSorted --- end  ");

        return criteria.list();
    }

}
