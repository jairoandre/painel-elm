package br.com.vah.painel.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by Jairoportela on 28/10/2016.
 */
@Entity
@Table(name = "TIP_FRE", schema = "DBAMV")
public class TipoFrequencia implements Serializable {

  @Id
  @Column(name = "CD_TIP_FRE")
  private Long id;

  @Column(name = "DS_TIP_FRE")
  private String nome;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }
}
