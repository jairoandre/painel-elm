package br.com.vah.painel.dao;

import br.com.vah.painel.exception.VahDAOException;
import org.hibernate.Criteria;
import org.hibernate.Session;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by Jairoportela on 19/10/2016.
 */
public abstract class AbstractDAO<T> implements Serializable {

  @PersistenceContext
  private EntityManager em;

  public AbstractDAO() {
  }

  private Class<T> type;

  /**
   * Default constructor
   *
   * @param type entity class
   */
  public AbstractDAO(Class<T> type) {
    this.type = type;
  }

  /**
   * Creates a new record in the database
   *
   * @param t
   * @return
   */
  public T create(T t) {
    this.em.persist(t);
    this.em.flush();
    this.em.refresh(t);
    return t;
  }

  /**
   * Retrieves an entity instance that was previously persisted to the
   * database
   *
   * @param id
   * @return
   */
  public T find(Object id) {
    try {
      T attachedObj = this.em.find(this.type, id);
      return attachedObj;
    } catch (Exception e) {
      throw new VahDAOException(String.format("Objeto da classe [%s] para o id [%s]", type.toString(), id.toString()));
    }
  }

  /**
   * Removes the record that is associated with the entity instance
   *
   * @param id
   * @param id
   */
  public void delete(Object id) {
    Object ref = this.em.getReference(this.type, id);
    this.em.remove(ref);
  }

  /**
   * Removes the number of entries from a table
   *
   * @param items
   * @return
   */
  public boolean deleteItems(T[] items) {
    for (T item : items) {
      em.remove(em.merge(item));
    }
    return true;
  }

  /**
   * Updates the entity instance
   *
   * @param item
   * @return the object that is updated
   */
  public T update(T item) {
    return this.em.merge(item);
  }

  /**
   * Updates a list of entity instance
   *
   * @param items
   * @return
   */
  public List<T> update(List<T> items) {
    List<T> persistedList = new ArrayList<>();
    for (T item : items) {
      persistedList.add(this.em.merge(item));
    }
    return persistedList;
  }

  /**
   * Returns the number of records that meet the criteria
   *
   * @param namedQueryName
   * @return List
   */
  public List findWithNamedQuery(String namedQueryName) {
    return this.em.createNamedQuery(namedQueryName).getResultList();
  }

  /**
   * Returns the number of records that meet the criteria
   *
   * @param namedQueryName
   * @param parameters
   * @return List
   */
  public List findWithNamedQuery(String namedQueryName, Map parameters) {
    return findWithNamedQuery(namedQueryName, parameters, 0);
  }

  /**
   * Returns the number of records with result limit
   *
   * @param queryName
   * @param resultLimit
   * @return List
   */
  public List findWithNamedQuery(String queryName, int resultLimit) {
    return this.em.createNamedQuery(queryName).setMaxResults(resultLimit).getResultList();
  }

  /**
   * Returns the number of records that meet the criteria
   *
   * @param sql
   * @return List
   */
  public List<T> findByNativeQuery(String sql) {
    return this.em.createNativeQuery(sql, type).getResultList();
  }

  /**
   * Returns the number of total records
   *
   * @param namedQueryName
   * @return int
   */
  public int countTotalRecord(String namedQueryName) {
    Query query = em.createNamedQuery(namedQueryName);
    Number result = (Number) query.getSingleResult();
    return result.intValue();
  }

  /**
   * Returns the number of records that meet the criteria with parameter map
   * and result limit
   *
   * @param namedQueryName
   * @param parameters
   * @param resultLimit
   * @return List
   */
  public List findWithNamedQuery(String namedQueryName, Map parameters, int resultLimit) {
    Set<Map.Entry<String, Object>> rawParameters = parameters.entrySet();
    Query query = this.em.createNamedQuery(namedQueryName);
    if (resultLimit > 0) {
      query.setMaxResults(resultLimit);
    }
    for (Map.Entry<String, Object> entry : rawParameters) {
      query.setParameter(entry.getKey(), entry.getValue());
    }
    return query.getResultList();
  }

  /**
   * Returns the number of records that will be used with lazy loading /
   * pagination
   *
   * @param namedQueryName
   * @param start
   * @param end
   * @return List
   */
  public List findWithNamedQuery(String namedQueryName, int start, int end) {
    Query query = this.em.createNamedQuery(namedQueryName);
    query.setMaxResults(end - start);
    query.setFirstResult(start);
    return query.getResultList();
  }

  public Criteria createCriteria() {
    return getSession().createCriteria(type);
  }

  public Session getSession() {
    return em.unwrap(Session.class);
  }

}
