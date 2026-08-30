package sptech.school.pokeFight_API;


import java.util.List;

public class Ataque {
    private Integer id_ataque;
    private String nome_ataque;
    private String tipo_ataque;
    private Integer dano_ataque;
    private List<Pokemon> pokemons; // N:N

    public Ataque(Integer id_ataque, String nome_ataque, String tipo_ataque, Integer dano_ataque, List<Pokemon> pokemons) {
        this.id_ataque = id_ataque;
        this.nome_ataque = nome_ataque;
        this.tipo_ataque = tipo_ataque;
        this.dano_ataque = dano_ataque;
        this.pokemons = pokemons;
    }

    public Ataque() {
    }

    public Integer getId_ataque() {
        return id_ataque;
    }

    public void setId_ataque(Integer id_ataque) {
        this.id_ataque = id_ataque;
    }

    public String getNome_ataque() {
        return nome_ataque;
    }

    public void setNome_ataque(String nome_ataque) {
        this.nome_ataque = nome_ataque;
    }

    public String getTipo_ataque() {
        return tipo_ataque;
    }

    public void setTipo_ataque(String tipo_ataque) {
        this.tipo_ataque = tipo_ataque;
    }

    public Integer getDano_ataque() {
        return dano_ataque;
    }

    public void setDano_ataque(Integer dano_ataque) {
        this.dano_ataque = dano_ataque;
    }

    public List<Pokemon> getPokemons() {
        return pokemons;
    }

    public void setPokemons(List<Pokemon> pokemons) {
        this.pokemons = pokemons;
    }
}
