package org.timesheet.service;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.springframework.data.domain.Page;
//import org.springframework.orm.hibernate3.HibernateTransactionManager;

public interface GenericDao<E, K> {

    void add(E entity);

    void update(E entity);

    void remove(E entity);

    E find(K key);

    List<E> list();
    
    Long countTotalItems();

    List<E> searchAll(final String[] sortByField, final String[] word);
    /**
     * - contract: if nothing is found, an empty list will be returned to the
     * calling client <br>
     */
    List<E> findAllSorted(final String sortBy, final String sortOrder);
    
    
    List<E> findAllSorted(final String[] sortByField, final String[] word, final String sortBy, final String sortOrder);
    /**
     * - contract: if nothing is found, an empty list will be returned to the
     * calling client <br>
     */
    List<E> findAllPaginated(final int page, final int size);
    /**
     * - contract: if nothing is found, an empty list will be returned to the
     * calling client <br>
     */
    List<E> findAllPaginatedAndSorted(final String[] sortByField, final String[] word, final int page, final int size, final String sortBy, final String sortOrder);
   
    
     List<E> findAllPaginatedAndSorted(final int page, final int size, final String sortBy, final String sortOrder);
   
   // Page<E> findAllPaginatedAndSortedRaw(final int page, final int size, final String sortBy, final String sortOrder);

   // Page<E> findAllPaginatedRaw(final int page, final int size);
}
