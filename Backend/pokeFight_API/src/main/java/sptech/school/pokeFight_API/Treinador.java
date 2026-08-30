package sptech.school.pokeFight_API;

import java.util.List;

public class Treinador {
    private Integer id_treinador;
    private String nome_treinador;
    private String senha_treinador;
    private String personagem_treinador;
    private List<Pokemon> pokemons; // relação N:N via Inventário
    private List<Placar> placares;  // relação 1:N

    public Treinador() {
    }

    public Treinador(Integer id_treinador, String nome_treinador, String senha_treinador, String personagem_treinador, List<Pokemon> pokemons, List<Placar> placares) {
        this.id_treinador = id_treinador;
        this.nome_treinador = nome_treinador;
        this.senha_treinador = senha_treinador;
        this.personagem_treinador = personagem_treinador;
        this.pokemons = pokemons;
        this.placares = placares;
    }

    public Integer getId_treinador() {
        return id_treinador;
    }

    public void setId_treinador(Integer id_treinador) {
        this.id_treinador = id_treinador;
    }

    public String getNome_treinador() {
        return nome_treinador;
    }

    public void setNome_treinador(String nome_treinador) {
        this.nome_treinador = nome_treinador;
    }

    public String getSenha_treinador() {
        return senha_treinador;
    }

    public void setSenha_treinador(String senha_treinador) {
        this.senha_treinador = senha_treinador;
    }

    public String getPersonagem_treinador() {
        return personagem_treinador;
    }

    public void setPersonagem_treinador(String personagem_treinador) {
        this.personagem_treinador = personagem_treinador;
    }

    public List<Pokemon> getPokemons() {
        return pokemons;
    }

    public void setPokemons(List<Pokemon> pokemons) {
        this.pokemons = pokemons;
    }

    public List<Placar> getPlacares() {
        return placares;
    }

    public void setPlacares(List<Placar> placares) {
        this.placares = placares;
    }
}
