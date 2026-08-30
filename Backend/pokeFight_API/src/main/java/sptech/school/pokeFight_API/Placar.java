package sptech.school.pokeFight_API;

import java.time.LocalDateTime;

public class Placar {
    private Integer id_placar;
    private Integer vitorias;
    private Integer derrotas;
    private java.time.LocalDateTime data_hora;
    private Treinador treinador; // relação 1:N

    public Placar(Integer id_placar, Integer vitorias, Integer derrotas, LocalDateTime data_hora, Treinador treinador) {
        this.id_placar = id_placar;
        this.vitorias = vitorias;
        this.derrotas = derrotas;
        this.data_hora = data_hora;
        this.treinador = treinador;
    }

    public Placar() {
    }

    public Integer getId_placar() {
        return id_placar;
    }

    public void setId_placar(Integer id_placar) {
        this.id_placar = id_placar;
    }

    public Integer getVitorias() {
        return vitorias;
    }

    public void setVitorias(Integer vitorias) {
        this.vitorias = vitorias;
    }

    public Integer getDerrotas() {
        return derrotas;
    }

    public void setDerrotas(Integer derrotas) {
        this.derrotas = derrotas;
    }

    public LocalDateTime getData_hora() {
        return data_hora;
    }

    public void setData_hora(LocalDateTime data_hora) {
        this.data_hora = data_hora;
    }

    public Treinador getTreinador() {
        return treinador;
    }

    public void setTreinador(Treinador treinador) {
        this.treinador = treinador;
    }
}
