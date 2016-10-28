package br.com.vah.painel.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jairoportela on 27/10/2016.
 */
public class PainelCpam {
  private String date;
  private String version;
  private List<SetorCepam> setores = new ArrayList<>();

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public String getVersion() {
    return version;
  }

  public void setVersion(String version) {
    this.version = version;
  }

  public List<SetorCepam> getSetores() {
    return setores;
  }

  public void setSetores(List<SetorCepam> setores) {
    this.setores = setores;
  }
}
