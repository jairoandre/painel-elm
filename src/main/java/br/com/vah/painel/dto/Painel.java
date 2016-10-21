package br.com.vah.painel.dto;

import java.util.List;

/**
 * Created by Jairoportela on 19/09/2016.
 */
public class Painel {

  private String date;
  private List<Room> rooms;
  private String version;

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public List<Room> getRooms() {
    return rooms;
  }

  public void setRooms(List<Room> rooms) {
    this.rooms = rooms;
  }

  public String getVersion() {
    return version;
  }

  public void setVersion(String version) {
    this.version = version;
  }
}
