package sptech.school.pokeFight_API;

import java.util.List;

public class Pokemon {
    private Integer id_pokemon;
    private String nome_pokemon;
    private String tipo_pokemon;
    private Integer vida_pokemon;
    private String fraqueza_pokemon;
    private List<Treinador> treinadores; // N:N
    private List<Ataque> ataques;        // N:N

    public Pokemon() {
    }

    public Pokemon(Integer id_pokemon, String nome_pokemon, String tipo_pokemon, Integer vida_pokemon, String fraqueza_pokemon, List<Treinador> treinadores, List<Ataque> ataques) {
        this.id_pokemon = id_pokemon;
        this.nome_pokemon = nome_pokemon;
        this.tipo_pokemon = tipo_pokemon;
        this.vida_pokemon = vida_pokemon;
        this.fraqueza_pokemon = fraqueza_pokemon;
        this.treinadores = treinadores;
        this.ataques = ataques;
    }


    public Integer getId_pokemon() {
        return id_pokemon;
    }

    public void setId_pokemon(Integer id_pokemon) {
        this.id_pokemon = id_pokemon;
    }

    public String getNome_pokemon() {
        return nome_pokemon;
    }

    public void setNome_pokemon(String nome_pokemon) {
        this.nome_pokemon = nome_pokemon;
    }

    public String getTipo_pokemon() {
        return tipo_pokemon;
    }

    public void setTipo_pokemon(String tipo_pokemon) {
        this.tipo_pokemon = tipo_pokemon;
    }

    public Integer getVida_pokemon() {
        return vida_pokemon;
    }

    public void setVida_pokemon(Integer vida_pokemon) {
        this.vida_pokemon = vida_pokemon;
    }

    public String getFraqueza_pokemon() {
        return fraqueza_pokemon;
    }

    public void setFraqueza_pokemon(String fraqueza_pokemon) {
        this.fraqueza_pokemon = fraqueza_pokemon;
    }

    public List<Treinador> getTreinadores() {
        return treinadores;
    }

    public void setTreinadores(List<Treinador> treinadores) {
        this.treinadores = treinadores;
    }

    public List<Ataque> getAtaques() {
        return ataques;
    }

    public void setAtaques(List<Ataque> ataques) {
        this.ataques = ataques;
    }
}

