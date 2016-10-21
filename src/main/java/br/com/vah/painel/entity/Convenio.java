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
@Table(name = "CONVENIO", schema = "DBAMV")
public class Convenio implements Serializable {

  @Id
  @Column(name = "CD_CONVENIO")
  private Integer id;

  @Column(name = "NM_CONVENIO")
  private String nome;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }
}
