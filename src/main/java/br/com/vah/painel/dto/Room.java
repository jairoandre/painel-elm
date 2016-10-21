package br.com.vah.painel.dto;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Jairoportela on 19/10/2016.
 */
public class Room implements Serializable {
  private String apto;
  private Integer status;
  private String paciente;
  private String medico;
  private String convenio;
  private String observacao;
  private String previsao;
  private Boolean previsaoToday;
  private Integer precaucao;
  private Integer scp;
  private Integer riscoQueda;
  private Integer ulceraPressao;
  private List<String> alergias;
  private List<String> exames;
  private List<String> cirurgias;
  private String jejum;

  public String getApto() {
    return apto;
  }

  public void setApto(String apto) {
    this.apto = apto;
  }

  public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public String getPaciente() {
    return paciente;
  }

  public void setPaciente(String paciente) {
    this.paciente = paciente;
  }

  public String getMedico() {
    return medico;
  }

  public void setMedico(String medico) {
    this.medico = medico;
  }

  public String getConvenio() {
    return convenio;
  }

  public void setConvenio(String convenio) {
    this.convenio = convenio;
  }

  public String getObservacao() {
    return observacao;
  }

  public void setObservacao(String observacao) {
    this.observacao = observacao;
  }

  public String getPrevisao() {
    return previsao;
  }

  public void setPrevisao(String previsao) {
    this.previsao = previsao;
  }

  public Boolean getPrevisaoToday() {
    return previsaoToday;
  }

  public void setPrevisaoToday(Boolean previsaoToday) {
    this.previsaoToday = previsaoToday;
  }

  public Integer getPrecaucao() {
    return precaucao;
  }

  public void setPrecaucao(Integer precaucao) {
    this.precaucao = precaucao;
  }

  public Integer getScp() {
    return scp;
  }

  public void setScp(Integer scp) {
    this.scp = scp;
  }

  public Integer getRiscoQueda() {
    return riscoQueda;
  }

  public void setRiscoQueda(Integer riscoQueda) {
    this.riscoQueda = riscoQueda;
  }

  public Integer getUlceraPressao() {
    return ulceraPressao;
  }

  public void setUlceraPressao(Integer ulceraPressao) {
    this.ulceraPressao = ulceraPressao;
  }

  public List<String> getAlergias() {
    return alergias;
  }

  public void setAlergias(List<String> alergias) {
    this.alergias = alergias;
  }

  public List<String> getExames() {
    return exames;
  }

  public void setExames(List<String> exames) {
    this.exames = exames;
  }

  public List<String> getCirurgias() {
    return cirurgias;
  }

  public void setCirurgias(List<String> cirurgias) {
    this.cirurgias = cirurgias;
  }

  public String getJejum() {
    return jejum;
  }

  public void setJejum(String jejum) {
    this.jejum = jejum;
  }
}
