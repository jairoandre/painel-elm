package br.com.vah.painel.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jairoportela on 27/10/2016.
 */
public class SetorCepam {
  private String nome;
  private List<PacienteCepam> pacientes = new ArrayList<>();

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public List<PacienteCepam> getPacientes() {
    return pacientes;
  }

  public void setPacientes(List<PacienteCepam> pacientes) {
    this.pacientes = pacientes;
  }

}
