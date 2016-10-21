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
@Table(name = "PACIENTE", schema = "DBAMV")
public class Paciente implements Serializable {

  @Id
  @Column(name = "CD_PACIENTE")
  private Long id;

  @Column(name = "NM_PACIENTE")
  private String nome;

  @Column(name = "NM_MNEMONICO")
  private String mnemonico;

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

  public String getMnemonico() {
    return mnemonico;
  }

  public void setMnemonico(String mnemonico) {
    this.mnemonico = mnemonico;
  }
}
