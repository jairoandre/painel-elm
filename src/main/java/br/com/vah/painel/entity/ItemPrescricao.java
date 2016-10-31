package br.com.vah.painel.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Jairoportela on 28/10/2016.
 */
@Entity
@Table(name = "ITPRE_MED", schema = "DBAMV")
public class ItemPrescricao implements Serializable {

  @Id
  @Column(name = "CD_ITPRE_MED")
  private Long id;

  @ManyToOne
  @JoinColumn(name = "CD_PRE_MED")
  private PrescricaoMedica prescricao;

  @Column(name = "DH_REGISTRO")
  private Date dataRegistro;

  @Column(name = "SN_CANCELADO")
  private String cancelado;

  @ManyToOne
  @JoinColumn(name = "CD_TIP_PRESC")
  private TipoPrescricao tipo;

  @ManyToOne
  @JoinColumn(name = "CD_TIP_FRE")
  private TipoFrequencia frequencia;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public PrescricaoMedica getPrescricao() {
    return prescricao;
  }

  public void setPrescricao(PrescricaoMedica prescricao) {
    this.prescricao = prescricao;
  }

  public Date getDataRegistro() {
    return dataRegistro;
  }

  public void setDataRegistro(Date dataRegistro) {
    this.dataRegistro = dataRegistro;
  }

  public String getCancelado() {
    return cancelado;
  }

  public void setCancelado(String cancelado) {
    this.cancelado = cancelado;
  }

  public TipoPrescricao getTipo() {
    return tipo;
  }

  public void setTipo(TipoPrescricao tipo) {
    this.tipo = tipo;
  }

  public TipoFrequencia getFrequencia() {
    return frequencia;
  }

  public void setFrequencia(TipoFrequencia frequencia) {
    this.frequencia = frequencia;
  }
}
