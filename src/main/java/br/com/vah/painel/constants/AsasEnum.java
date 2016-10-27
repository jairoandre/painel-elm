package br.com.vah.painel.constants;

/**
 * Created by Jairoportela on 19/10/2016.
 */
public enum AsasEnum {
  HOMERO("HOMERO MASSENA", 1),
  AUGUSTO("AUGUSTO RUSCHI", 2),
  CORA("CORA CORALINA", 3),
  MONTEIRO("MONTEIRO LOBATO", 4),
  RUBEM("RUBEM BRAGA", 5),
  DAYCLINIC("DAY CLINIC", 6),
  UTI2("UTI2/CARDIO", 7,8),
  UTI1("UT1", 9),
  CTQ("CTQ", 10),
  NAOLISTADO("NÃO LISTADO");

  Integer[] ids;
  String label;

  AsasEnum(String label, Integer... ids) {
    this.label = label;
    this.ids = ids;
  }

  public String getLabel() {
    return label;
  }

  public Integer[] getIds() {
    return ids;
  }

  public static AsasEnum byInt(Integer id) {
    for (AsasEnum asa : AsasEnum.values()) {
      for (Integer idAsa : asa.getIds()) {
        if (idAsa == id) {
          return asa;
        }
      }
    }
    return NAOLISTADO;
  }
}
