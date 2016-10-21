package br.com.vah.painel.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Entity
@Table(name = "LEITO", schema = "DBAMV")
public class Leito {

  @Id
  @Column(name = "CD_LEITO")
  private Integer id;

  @Column(name = "DS_LEITO")
  private String nome;

  @Column(name = "DS_RESUMO")
  private String resumo;

  @Column(name = "CD_UNID_INT")
  private Integer unidadeInternacao;

  @Column(name = "TP_OCUPACAO")
  private String tpOcupacao;

  @Column(name = "TP_SITUACAO")
  private String tpSituacao;

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

  public String getResumo() {
    return resumo;
  }

  public void setResumo(String resumo) {
    this.resumo = resumo;
  }

  public Integer getUnidadeInternacao() {
    return unidadeInternacao;
  }

  public void setUnidadeInternacao(Integer unidadeInternacao) {
    this.unidadeInternacao = unidadeInternacao;
  }

  public String getTpOcupacao() {
    return tpOcupacao;
  }

  public void setTpOcupacao(String tpOcupacao) {
    this.tpOcupacao = tpOcupacao;
  }

  public String getTpSituacao() {
    return tpSituacao;
  }

  public void setTpSituacao(String tpSituacao) {
    this.tpSituacao = tpSituacao;
  }
}
