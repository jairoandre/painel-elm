package br.com.vah.painel.dao;

import br.com.vah.painel.entity.Atendimento;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import javax.ejb.Stateless;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Jairoportela on 19/10/2016.
 */
@Stateless
public class AtendimentoDAO extends AbstractDAO<Atendimento> {

  private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");


  public AtendimentoDAO() {
    super(Atendimento.class);
  }

  public List<Atendimento> list(Integer[] ids) {
    Criteria criteria = createCriteria();

    criteria.createAlias("leito", "l").add(Restrictions.in("l.unidadeInternacao", ids));

    criteria.add(Restrictions.eq("l.tpSituacao", "A"));
    criteria.add(Restrictions.eq("cdMultiEmpresa", 1));
    criteria.add(Restrictions.isNull("dtAlta"));
    criteria.add(Restrictions.eq("tpAtendimento", "I"));

    return criteria.list();
  }

  public List<Atendimento> listForCepam() {
    Criteria criteria = createCriteria();

    criteria.createAlias("leito", "l")
        .add(Restrictions.not(Restrictions.in("l.unidadeInternacao", new Integer[] {12, 10, 6, 17, 7, 8, 9})));

    Calendar cld = Calendar.getInstance();
    Date today = new Date();
    cld.setTime(today);
    cld.add(Calendar.HOUR_OF_DAY, -10);
    Date tenHoursBefore = cld.getTime();

    criteria.add(Restrictions.between("horaAlta", tenHoursBefore, today));

    criteria.add(Restrictions.eq("cdMultiEmpresa", 1));
    criteria.add(Restrictions.eq("tpAtendimento", "I"));

    return criteria.list();
  }

  public String previsaoAlta(Long atendimentoId) {
    String sql =
        "SELECT MAX(ITPRE_MED.DH_INICIAL)" +
            "    FROM DBAMV.TB_ATENDIME" +
            "    JOIN DBAMV.PRE_MED" +
            "        ON TB_ATENDIME.CD_ATENDIMENTO = PRE_MED.CD_ATENDIMENTO" +
            "    JOIN DBAMV.ITPRE_MED" +
            "        ON PRE_MED.CD_PRE_MED = ITPRE_MED.CD_PRE_MED" +
            "    WHERE TB_ATENDIME.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "        AND ITPRE_MED.CD_TIP_PRESC = 26057" +
            "        AND ITPRE_MED.TP_SITUACAO = 'N'";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object> result = query.list();

    if (result == null || result.isEmpty()) {
      return null;
    } else {
      Date date = (Timestamp) result.iterator().next();

      if (date == null) {
        return null;
      } else {
        return sdf.format(date);
      }
    }

  }

  public Integer precaucao(Long atendimentoId) {
    String sql =
        "SELECT RR.DS_RESPOSTA" +
            "    FROM DBAMV.REGISTRO_DOCUMENTO RD" +
            "    JOIN DBAMV.REGISTRO_RESPOSTA RR" +
            "      ON RD.CD_REGISTRO_DOCUMENTO =" +
            "         RR.CD_REGISTRO_DOCUMENTO" +
            "    JOIN DBAMV.PERGUNTA_DOC PD" +
            "      ON RR.CD_PERGUNTA_DOC = PD.CD_PERGUNTA_DOC" +
            "   WHERE RR.CD_PERGUNTA_DOC = (15242)" +
            "     AND RD.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "     AND RR.DS_RESPOSTA IS NOT NULL" +
            "     ORDER BY RD.DT_REGISTRO DESC";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object> result = query.list();

    if (result == null || result.isEmpty()) {
      return -1;
    } else {
      String val = (String) result.iterator().next();

      if (val == null) {
        return -1;
      } else {
        return Integer.valueOf(val.split(";")[0]);
      }
    }
  }

  public Integer ulceraPressao(Long atendimentoId) {
    String sql =
        "SELECT VL_RESULTADO" +
            "    FROM DBAMV.PAGU_AVALIACAO" +
            "    WHERE PAGU_AVALIACAO.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "    AND  PAGU_AVALIACAO.CD_FORMULA = 19" +
            "    ORDER BY DH_AVALIACAO DESC";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object> result = query.list();

    if (result == null || result.isEmpty()) {
      return -1;
    } else {
      BigDecimal val = (BigDecimal) result.iterator().next();
      if (val == null) {
        return -1;
      } else {
        int ulceraPressao = val.intValue();
        if (ulceraPressao >= 4 && ulceraPressao <= 12) {
          return 2;
        } else if (ulceraPressao >= 13 && ulceraPressao <= 15) {
          return 1;
        } else if (ulceraPressao >= 16 && ulceraPressao <= 23) {
          return 0;
        } else {
          return -1;
        }
      }
    }

  }

  public List<String> separateValues(String rawText) {
    String[] values = rawText.toUpperCase().split("\\s*[^a-zA-ZÇÁÉÍÓÚÃÕÀÌÈÒÙÂÊÎÔÛ\\-]+\\s*");
    List<String> result = new ArrayList<>();
    for (String val : values) {
      if (val.length() > 1) {
        result.add(val);
      }
    }
    return result;
  }

  public List<String> alergias(Long atendimentoId) {
    String sql = "SELECT" +
        "  RR.CD_PERGUNTA_DOC, RR.DS_RESPOSTA" +
        "  FROM DBAMV.REGISTRO_DOCUMENTO RD" +
        "  JOIN DBAMV.REGISTRO_RESPOSTA RR ON RD.CD_REGISTRO_DOCUMENTO = RR.CD_REGISTRO_DOCUMENTO" +
        "  WHERE RD.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
        "  AND RR.DS_RESPOSTA IS NOT NULL" +
        "  AND RR.CD_PERGUNTA_DOC IN (16361,16362,16381,16382,16383,16384,16385,16386,16387,16388,16389)" +
        "  AND RD.DT_REGISTRO =" +
        "  (" +
        "   SELECT" +
        "    MAX(RD.DT_REGISTRO)" +
        "    FROM DBAMV.REGISTRO_DOCUMENTO RD" +
        "    JOIN DBAMV.REGISTRO_RESPOSTA RR ON RD.CD_REGISTRO_DOCUMENTO = RR.CD_REGISTRO_DOCUMENTO" +
        "    WHERE RD.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
        "    AND RR.DS_RESPOSTA IS NOT NULL" +
        "    AND RR.CD_PERGUNTA_DOC IN (16361,16362,16381,16382,16383,16384,16385,16386,16387,16388,16389)" +
        "  )";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object[]> result = (List<Object[]>) query.list();

    List<String> list = new ArrayList<>();

    for (Object[] obj : result) {
      Integer value = ((BigDecimal) obj[0]).intValue();
      switch (value) {
        case 16361:
          break;
        case 16362:
          break;
        case 16381: // ALIMENTAR
        case 16386: // MEDICAMENTOS
        case 16389: // OUTROS
          String ori = obj[1].toString();
          list.addAll(separateValues(ori));
          break;
        case 16382: // ESPARADRAPO
          String esp = obj[1].toString();
          if(esp.contains("Sim") || esp.contains("checked")) {
            list.add("ESPARADRAPO");
          }
          break;
        case 16383: // IODO
          String io = obj[1].toString();
          if(io.contains("Sim") || io.contains("checked")) {
            list.add("IODO");
          }
          break;
        case 16384: // LATEX
          String latex = obj[1].toString();
          if(latex.contains("Sim") || latex.contains("checked")) {
            list.add("LÁTEX");
          }
          break;
        case 16387: // MICROPORE
          String micropore = obj[1].toString();
          if(micropore.contains("Sim") || micropore.contains("checked")) {
            list.add("MICROPORE");
          }
          break;
        default:
          break;

      }
    }
    return list;
  }

  public List<String> exames(Long atendimentoId) {
    String sql =
        "SELECT" +
            "  T.DS_TIP_PRESC" +
            "  FROM DBAMV.TB_ATENDIME A" +
            "    LEFT JOIN DBAMV.PRE_MED P ON P.CD_ATENDIMENTO = A.CD_ATENDIMENTO" +
            "    LEFT JOIN DBAMV.ITPRE_MED I ON P.CD_PRE_MED = I.CD_PRE_MED" +
            "    LEFT JOIN DBAMV.TIP_PRESC T ON I.CD_TIP_PRESC = T.CD_TIP_PRESC" +
            "  WHERE A.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "    AND T.CD_TIP_ESQ IN ('ECA','EXA','ERX','ETR','EUS','LAB', 'LAS')" +
            "    AND A.CD_MULTI_EMPRESA = '1'" +
            "    AND P.DT_VALIDADE > SYSDATE";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<String> result = (List<String>) query.list();

    return result;
  }

  public Integer riscoQueda(Long atendimentoId) {
    String sql =
        "SELECT VL_RESULTADO" +
            "    FROM DBAMV.PAGU_AVALIACAO" +
            "    WHERE PAGU_AVALIACAO.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "    AND  PAGU_AVALIACAO.CD_FORMULA = 18" +
            "    ORDER BY DH_AVALIACAO DESC";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object> result = query.list();

    if (result == null || result.isEmpty()) {
      return -1;
    } else {
      BigDecimal val = (BigDecimal) result.iterator().next();
      if (val == null) {
        return -1;
      } else {
        if (val.intValue() > 45) {
          return 2;
        } else {
          return 0;
        }
      }
    }
  }

  public Integer scpAtendimento(Long atendimentoId) {
    String sql =
        "SELECT VL_RESULTADO" +
            "    FROM DBAMV.PAGU_AVALIACAO" +
            "    WHERE PAGU_AVALIACAO.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            "    AND  PAGU_AVALIACAO.CD_FORMULA = 21" +
            "    ORDER BY DH_AVALIACAO DESC";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    List<Object> result = query.list();

    if (result == null || result.isEmpty()) {
      return -1;
    } else {
      BigDecimal val = (BigDecimal) result.iterator().next();

      if (val == null) {
        return -1;
      } else {
        Integer scp = val.intValue();
        if (scp >= 9 && scp <= 14) {
          return 0;
        } else if (scp >= 15 && scp <= 13) {
          return 1;
        } else if (scp >= 24 && scp <= 31) {
          return 2;
        } else if (scp > 31) {
          return 3;
        } else {
          return 4;
        }

      }
    }

  }

  public List<String> cirurgias(Long atendimentoId) {
    String sql =
        "SELECT CIRURGIA.DS_CIRURGIA" +
            "   FROM DBAMV.AVISO_CIRURGIA" +
            "   JOIN DBAMV.CIRURGIA_AVISO" +
            "     ON AVISO_CIRURGIA.CD_AVISO_CIRURGIA = CIRURGIA_AVISO.CD_AVISO_CIRURGIA" +
            "   JOIN DBAMV.CIRURGIA" +
            "     ON CIRURGIA_AVISO.CD_CIRURGIA = CIRURGIA.CD_CIRURGIA" +
            "  WHERE AVISO_CIRURGIA.CD_ATENDIMENTO = :CD_ATENDIMENTO" +
            " AND AVISO_CIRURGIA.TP_SITUACAO <> 'R'" +
            " AND AVISO_CIRURGIA.TP_SITUACAO <> 'C'";

    Session session = getSession();
    SQLQuery query = session.createSQLQuery(sql);
    query.setParameter("CD_ATENDIMENTO", atendimentoId);

    return (List<String>) query.list();
  }

}
