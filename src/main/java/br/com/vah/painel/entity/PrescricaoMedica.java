package br.com.vah.painel.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Created by Jairoportela on 28/10/2016.
 */
@Entity
@Table(name = "PRE_MED", schema = "DBAMV")
public class PrescricaoMedica implements Serializable {

  @Id
  @Column(name = "CD_PRE_MED")
  private Long id;

  @ManyToOne
  @JoinColumn(name = "CD_ATENDIMENTO")
  private Atendimento atendimento;

  @OneToMany(mappedBy = "prescricao")
  private Set<ItemPrescricao> items;

  @Column(name = "FL_IMPRESSO")
  private String impresso;

  @Column(name = "TP_PRE_MED")
  private String tipo;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Atendimento getAtendimento() {
    return atendimento;
  }

  public void setAtendimento(Atendimento atendimento) {
    this.atendimento = atendimento;
  }

  public Set<ItemPrescricao> getItems() {
    return items;
  }

  public void setItems(Set<ItemPrescricao> items) {
    this.items = items;
  }

  public String getImpresso() {
    return impresso;
  }

  public void setImpresso(String impresso) {
    this.impresso = impresso;
  }

  public String getTipo() {
    return tipo;
  }

  public void setTipo(String tipo) {
    this.tipo = tipo;
  }
}
