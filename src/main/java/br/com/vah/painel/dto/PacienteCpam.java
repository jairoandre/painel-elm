package br.com.vah.painel.dto;

import java.util.List;

/**
 * Created by Jairoportela on 27/10/2016.
 */
public class PacienteCpam {
  private String apto;
  private Integer atendimento;
  private String nome;
  private String altaMedica;
  private String altaHospitalar;
  private List<String> suspensos;
  private List<String> agora;
  private List<String> urgente;
  private List<String> alergias;

  public String getApto() {
    return apto;
  }

  public void setApto(String apto) {
    this.apto = apto;
  }

  public Integer getAtendimento() {
    return atendimento;
  }

  public void setAtendimento(Integer atendimento) {
    this.atendimento = atendimento;
  }

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public String getAltaMedica() {
    return altaMedica;
  }

  public void setAltaMedica(String altaMedica) {
    this.altaMedica = altaMedica;
  }

  public String getAltaHospitalar() {
    return altaHospitalar;
  }

  public void setAltaHospitalar(String altaHospitalar) {
    this.altaHospitalar = altaHospitalar;
  }

  public List<String> getSuspensos() {
    return suspensos;
  }

  public void setSuspensos(List<String> suspensos) {
    this.suspensos = suspensos;
  }

  public List<String> getAgora() {
    return agora;
  }

  public void setAgora(List<String> agora) {
    this.agora = agora;
  }

  public List<String> getUrgente() {
    return urgente;
  }

  public void setUrgente(List<String> urgente) {
    this.urgente = urgente;
  }

  public List<String> getAlergias() {
    return alergias;
  }

  public void setAlergias(List<String> alergias) {
    this.alergias = alergias;
  }
}
