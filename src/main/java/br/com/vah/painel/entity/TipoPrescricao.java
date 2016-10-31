package br.com.vah.painel.entity;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Jairoportela on 28/10/2016.
 */
@Entity
@Table(name = "TIP_PRESC", schema = "DBAMV")
public class TipoPrescricao implements Serializable {

  @Id
  @Column(name = "CD_TIP_PRESC")
  private Long id;

  @Column(name = "CD_TIP_ESQ")
  private String tipo;

  @ManyToOne
  @JoinColumn(name = "CD_PRODUTO")
  private Produto produto;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getTipo() {
    return tipo;
  }

  public void setTipo(String tipo) {
    this.tipo = tipo;
  }

  public Produto getProduto() {
    return produto;
  }

  public void setProduto(Produto produto) {
    this.produto = produto;
  }
}
