package sptech.school.pokeFight_API;

import java.util.List;

public class Inventario {
    private Integer id_inventario;
    private Treinador treinador;
    private List<Pokemon> id_pokemon;

    public Inventario() {
    }

    public Inventario(Integer id_inventario, Treinador treinador, List<Pokemon> id_pokemon) {
        this.id_inventario = id_inventario;
        this.treinador = treinador;
        this.id_pokemon = id_pokemon;
    }

    public Inventario(Integer idGerado, Integer idTreinador, Integer idPokemon) {
    }

    public Integer getId_inventario() {
        return id_inventario;
    }

    public void setId_inventario(Integer id_inventario) {
        this.id_inventario = id_inventario;
    }

    public Treinador getTreinador() {
        return treinador;
    }

    public void setTreinador(Treinador treinador) {
        this.treinador = treinador;
    }

    public List<Pokemon> getId_pokemon() {
        return id_pokemon;
    }

    public void setId_pokemon(List<Pokemon> id_pokemon) {
        this.id_pokemon = id_pokemon;
    }
}