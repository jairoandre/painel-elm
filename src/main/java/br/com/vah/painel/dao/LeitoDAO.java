package br.com.vah.painel.dao;

import br.com.vah.painel.entity.Leito;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import javax.ejb.Stateless;
import java.util.List;

/**
 * Created by Jairoportela on 19/10/2016.
 */
@Stateless
public class LeitoDAO extends AbstractDAO<Leito> {

  public LeitoDAO() {
    super(Leito.class);
  }

  public List<Leito> list(Integer[] ids) {
    Criteria criteria = createCriteria();
    criteria.add(Restrictions.in("unidadeInternacao", ids));
    criteria.add(Restrictions.eq("tpSituacao", "A"));
    return criteria.list();
  }
}
