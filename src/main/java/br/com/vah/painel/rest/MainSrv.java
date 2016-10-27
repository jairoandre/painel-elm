package br.com.vah.painel.rest;

import br.com.vah.painel.constants.AsasEnum;
import br.com.vah.painel.dao.AtendimentoDAO;
import br.com.vah.painel.dao.LeitoDAO;
import br.com.vah.painel.dto.*;
import br.com.vah.painel.entity.Atendimento;
import br.com.vah.painel.entity.Leito;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Path("/api")
public class MainSrv {

  private
  @Inject
  AtendimentoDAO atendimentoDAO;

  private
  @Inject
  LeitoDAO leitoDAO;

  private Boolean previsaoToday(String previsao) {
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    if (previsao == null) {
      return false;
    } else {
      try {
        Date date = sdf.parse(previsao);
        Calendar cld1 = Calendar.getInstance();
        cld1.setTime(date);
        Calendar cld2 = Calendar.getInstance();
        return (cld1.get(Calendar.ERA) == cld2.get(Calendar.ERA)
            && (cld1.get(Calendar.YEAR) == cld2.get(Calendar.YEAR))
            && (cld1.get(Calendar.DAY_OF_YEAR) == cld2.get(Calendar.DAY_OF_YEAR)));
      } catch (Exception e) {
        return false;
      }
    }
  }

  // Para forçar atualização dos clientes
  public static final String VERSION = "0.0.1";

  @GET
  @Path("/painel/{asa}")
  @Produces("application/json")
  public Painel painel(@PathParam("asa") String asa) {
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    Painel painel = new Painel();
    painel.setDate(sdf.format(Calendar.getInstance().getTime()));
    painel.setRooms(list(asa));
    painel.setVersion(VERSION);
    return painel;
  }

  @GET
  @Path("/list/{asa}")
  @Produces("application/json")
  public List<Room> list(@PathParam("asa") String asa) {
    List<Room> rooms = new ArrayList<>();

    if (asa != null) {
      asa = asa.toUpperCase();
    }

    AsasEnum asaEnum = AsasEnum.valueOf(asa);

    List<Atendimento> atendimentos = atendimentoDAO.list(asaEnum.getIds());

    for (Atendimento atendimento : atendimentos) {
      Room room = new Room();
      room.setApto(atendimento.getLeito().getResumo());
      if (atendimento.getDtAlta() == null) {
        room.setStatus(0);
      } else {
        room.setStatus(1);
      }
      room.setPaciente(atendimento.getPaciente().getNome());
      room.setMedico(atendimento.getPrestador().getMnemonico());
      room.setConvenio(atendimento.getConvenio().getNome());
      Long id = atendimento.getId();
      room.setPrecaucao(atendimentoDAO.precaucao(id));
      room.setPrevisao(atendimentoDAO.previsaoAlta(id));
      room.setPrevisaoToday(previsaoToday(room.getPrevisao()));
      room.setScp(atendimentoDAO.scpAtendimento(id));
      room.setRiscoQueda(atendimentoDAO.riscoQueda(id));
      room.setUlceraPressao(atendimentoDAO.ulceraPressao(id));
      room.setAlergias(atendimentoDAO.alergias(id));
      room.setCirurgias(atendimentoDAO.cirurgias(id));
      // room.setExames(atendimentoDAO.exames(id));
      rooms.add(room);
    }

    List<Leito> leitos = leitoDAO.list(asaEnum.getIds());
    for (Leito leito : leitos) {
      if (!leito.getTpOcupacao().equals("O")) {
        Room room = new Room();
        room.setApto(leito.getResumo());
        switch (leito.getTpOcupacao()) {
          case "V":
            room.setStatus(2);
            break;
          case "A":
            room.setStatus(3);
            break;
          case "L":
            room.setStatus(4);
            break;
          case "R":
            room.setStatus(5);
            break;
          case "M":
            room.setStatus(6);
            break;
          case "I":
          case "T":
            room.setStatus(7);
            break;
          default:
            room.setStatus(9);
            continue;
        }
        rooms.add(room);
      }
    }
    Collections.sort(rooms, new Comparator<Room>() {
      @Override
      public int compare(Room o1, Room o2) {
        return o1.getApto().compareTo(o2.getApto());
      }
    });
    return rooms;
  }

  @GET
  @Path("/cepam")
  @Produces("application/json")
  public PainelCepam cepam() {
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy HH:mm");
    SimpleDateFormat sdfYear = new SimpleDateFormat("dd/MM/yyyy");
    PainelCepam painel = new PainelCepam();
    List<Atendimento> atendimentos = atendimentoDAO.listForCepam();
    Map<AsasEnum, SetorCepam> mapSetor = new HashMap<>();
    List<SetorCepam> setores = new ArrayList<>();
    for (Atendimento atendimento : atendimentos) {
      AsasEnum curr = AsasEnum.byInt(atendimento.getLeito().getUnidadeInternacao());
      SetorCepam setor = mapSetor.get(curr);
      if (setor == null) {
        setor = new SetorCepam();
        setor.setNome(curr.getLabel());
        setores.add(setor);
        mapSetor.put(curr, setor);
      }
      PacienteCepam paciente = new PacienteCepam();
      paciente.setNome(atendimento.getPaciente().getNome());
      paciente.setApto(atendimento.getLeito().getNome());
      paciente.setAltaMedica(sdf.format(atendimento.getHoraAltaMedica()));
      paciente.setAtendimento(atendimento.getId().intValue());
      setor.getPacientes().add(paciente);
    }

    Collections.sort(setores, new Comparator<SetorCepam>() {
      @Override
      public int compare(SetorCepam o1, SetorCepam o2) {
        return o1.getNome().compareTo(o2.getNome());
      }
    });

    for (SetorCepam setor : setores) {
      Collections.sort(setor.getPacientes(), new Comparator<PacienteCepam>() {
        @Override
        public int compare(PacienteCepam o1, PacienteCepam o2) {
          return o1.getApto().compareTo(o2.getApto());
        }
      });
    }
    painel.setDate(sdfYear.format(Calendar.getInstance().getTime()));
    painel.setVersion(VERSION);
    painel.setSetores(setores);
    return painel;
  }


}
