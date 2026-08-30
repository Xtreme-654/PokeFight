package sptech.school.pokeFight_API;

public class PokemonAtaque {
    private Pokemon pokemon;
    private Ataque ataque;

    public PokemonAtaque() {
    }

    public PokemonAtaque(Pokemon pokemon, Ataque ataque) {
        this.pokemon = pokemon;
        this.ataque = ataque;
    }

    public Pokemon getPokemon() {
        return pokemon;
    }

    public void setPokemon(Pokemon pokemon) {
        this.pokemon = pokemon;
    }

    public Ataque getAtaque() {
        return ataque;
    }

    public void setAtaque(Ataque ataque) {
        this.ataque = ataque;
    }
}
