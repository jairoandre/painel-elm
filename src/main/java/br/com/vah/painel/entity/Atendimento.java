package br.com.vah.painel.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
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

  @Column(name = "DT_ALTA_MEDICA")
  private Date dataAltaMedica;

  @Column(name = "CD_PACIENTE")
  private Long cdPaciente;

  @Column(name = "CD_PRESTADOR")
  private Long cdPrestador;

  @Column(name = "CD_CONVENIO")
  private Long cdConvenio;

  @Column(name = "CD_LEITO")
  private Long cdLeito;

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

  public Long getCdPaciente() {
    return cdPaciente;
  }

  public void setCdPaciente(Long cdPaciente) {
    this.cdPaciente = cdPaciente;
  }

  public Long getCdPrestador() {
    return cdPrestador;
  }

  public void setCdPrestador(Long cdPrestador) {
    this.cdPrestador = cdPrestador;
  }

  public Long getCdConvenio() {
    return cdConvenio;
  }

  public void setCdConvenio(Long cdConvenio) {
    this.cdConvenio = cdConvenio;
  }

  public Long getCdLeito() {
    return cdLeito;
  }

  public void setCdLeito(Long cdLeito) {
    this.cdLeito = cdLeito;
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
