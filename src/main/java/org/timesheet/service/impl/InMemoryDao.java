package org.timesheet.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.timesheet.service.GenericDao;

public class InMemoryDao<E, K> implements GenericDao<E, K> {

    static final Logger logger = Logger.getLogger(InMemoryDao.class);

    private List<E> entities = new ArrayList<E>();

    @Override
    public void add(E entity) {
        logger.info("=== InMemoryDao === method:add --- start: " + entity);
        entities.add(entity);
        logger.info("=== InMemoryDao === method:add --- end: " + entity);
    }

    @Override
    public void update(E entity) {
        logger.info("=== InMemoryDao === method:update --- : " + entity);
        throw new UnsupportedOperationException("Not supported in dummy in-memory impl!");
    }

    @Override
    public void remove(E entity) {
        logger.info("=== InMemoryDao === method:remove --- start: " + entity);

        entities.remove(entity);

        logger.info("=== InMemoryDao === method:remove --- end: " + entity);
    }

    @Override
    public E find(K key) {
        logger.info("=== InMemoryDao === method:find --- start: " + key);
        
        if (entities.isEmpty()) {
            return null;
        }
        
        logger.info("=== InMemoryDao === method:find --- end: " + entities.get(0));
        // just return the first one sice we are not using any keys ATM
        return entities.get(0);
    }

    @Override
    public List<E> list() {
        logger.info("=== InMemoryDao === method:list --- : " + entities);
        return entities;
    }

    @Override
    public List<E> findAllSorted(String sortBy, String sortOrder) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<E> searchAll(String[] sortBy, String[] word) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<E> findAllSorted(String[] sortByField, String[] word, String sortBy, String sortOrder) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<E> findAllPaginated(int page, int size) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Long countTotalItems() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<E> findAllPaginatedAndSorted(String[] sortByField, String[] word, int page, int size, String sortBy, String sortOrder) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<E> findAllPaginatedAndSorted(int page, int size, String sortBy, String sortOrder) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
