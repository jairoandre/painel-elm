package br.com.vah.painel.rest;

import br.com.vah.painel.dto.Painel;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.util.Calendar;
import java.util.Random;

/**
 * Created by Jairoportela on 19/09/2016.
 */
@Path("/api")
public class MainSrv {

  @GET
  @Path("/painel")
  @Produces("application/json")
  public Painel painel() {
    Painel painel = new Painel();

    Random rnd = new Random(Calendar.getInstance().getTimeInMillis());

    painel.setName("Teste");
    painel.setQtd(rnd.nextInt());

    return painel;
  }
}
