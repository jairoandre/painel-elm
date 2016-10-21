package br.com.vah.painel.rest;

/**
 * Created by Jairoportela on 20/10/2016.
 */
public class Test {
  public static void main(String[] args) {
    String test = "Cataflan, dipirona e aspirina.".toUpperCase();
    String[] values = test.split("\\s*[^a-zA-Z]+\\s*");
    for (String val : values) {
      if (val.length() > 1) {
        System.out.println(val);
      }
    }
  }
}


