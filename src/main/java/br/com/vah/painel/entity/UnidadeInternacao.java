package br.com.vah.painel.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Entity
@Table(name = "UNID_INT", schema = "DBAMV")
public class UnidadeInternacao implements Serializable {

  @Id
  @Column(name = "CD_UNID_INT")
  private Long id;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }
}
