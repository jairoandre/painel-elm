package br.com.vah.painel.constants;

/**
 * Created by Jairoportela on 19/10/2016.
 */
public enum AsasEnum {
  HOMERO(1),
  AUGUSTO(2),
  CORA(3),
  MONTEIRO(4),
  RUBEM(5),
  DAYCLINIC(6),
  UTI2(7,8),
  UTI1(9),
  CTQ(10);

  Integer[] ids;

  AsasEnum(Integer... ids) {
    this.ids = ids;
  }

  public Integer[] getIds() {
    return ids;
  }
}
