package br.com.vah.painel.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Entity
@Table(name = "TB_ATENDIME", schema = "DBAMV")
public class Atendimento {

  @Id
  @Column(name = "CD_ATENDIMENTO")
  private Long id;

  @ManyToOne
  @JoinColumn(name = "CD_LEITO")
  private Leito leito;

  @Column(name = "DT_ALTA_MEDICA")
  private Date dataAltaMedica;

  @ManyToOne
  @JoinColumn(name = "CD_PRESTADOR")
  private Prestador prestador;

  @ManyToOne
  @JoinColumn(name = "CD_PACIENTE")
  private Paciente paciente;

  @ManyToOne
  @JoinColumn(name = "CD_CONVENIO")
  private Convenio convenio;

  @Column(name = "TP_ATENDIMENTO")
  private String tpAtendimento;

  @Column(name = "DT_ALTA")
  private Date dtAlta;

  @Column(name = "CD_MULTI_EMPRESA")
  private Integer cdMultiEmpresa;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Date getDataAltaMedica() {
    return dataAltaMedica;
  }

  public void setDataAltaMedica(Date dataAltaMedica) {
    this.dataAltaMedica = dataAltaMedica;
  }

  public Paciente getPaciente() {
    return paciente;
  }

  public void setPaciente(Paciente paciente) {
    this.paciente = paciente;
  }

  public Convenio getConvenio() {
    return convenio;
  }

  public void setConvenio(Convenio convenio) {
    this.convenio = convenio;
  }

  public Leito getLeito() {
    return leito;
  }

  public void setLeito(Leito leito) {
    this.leito = leito;
  }

  public Prestador getPrestador() {
    return prestador;
  }

  public void setPrestador(Prestador prestador) {
    this.prestador = prestador;
  }

  public String getTpAtendimento() {
    return tpAtendimento;
  }

  public void setTpAtendimento(String tpAtendimento) {
    this.tpAtendimento = tpAtendimento;
  }

  public Date getDtAlta() {
    return dtAlta;
  }

  public void setDtAlta(Date dtAlta) {
    this.dtAlta = dtAlta;
  }

  public Integer getCdMultiEmpresa() {
    return cdMultiEmpresa;
  }

  public void setCdMultiEmpresa(Integer cdMultiEmpresa) {
    this.cdMultiEmpresa = cdMultiEmpresa;
  }


}
