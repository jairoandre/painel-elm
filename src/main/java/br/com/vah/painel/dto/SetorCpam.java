package br.com.vah.painel.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jairoportela on 27/10/2016.
 */
public class SetorCpam {
  private String nome;
  private List<PacienteCpam> pacientes = new ArrayList<>();

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public List<PacienteCpam> getPacientes() {
    return pacientes;
  }

  public void setPacientes(List<PacienteCpam> pacientes) {
    this.pacientes = pacientes;
  }

}
