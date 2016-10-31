package br.com.vah.painel.rest;

import br.com.vah.painel.constants.TipoPrescricaoEnum;
import br.com.vah.painel.entity.TipoPrescricao;

/**
 * Created by Jairoportela on 20/10/2016.
 */
public class Test {
  public static void main(String[] args) {
    TipoPrescricaoEnum tipo = TipoPrescricaoEnum.valueOf("TESATE");
    String test = "Cataflan, dipirona e aspirina.".toUpperCase();
    String[] values = test.split("\\s*[^a-zA-Z]+\\s*");
    for (String val : values) {
      if (val.length() > 1) {
        System.out.println(val);
      }
    }
  }
}


