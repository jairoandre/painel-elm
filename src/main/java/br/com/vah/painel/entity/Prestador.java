package br.com.vah.painel.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Entity
@Table(name = "PRESTADOR", schema = "DBAMV")
public class Prestador {

  @Id
  @Column(name = "CD_PRESTADOR")
  private Long id;

  @Column(name = "NM_MNEMONICO")
  private String mnemonico;

  public String getMnemonico() {
    return mnemonico;
  }

  public void setMnemonico(String mnemonico) {
    this.mnemonico = mnemonico;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }
}
