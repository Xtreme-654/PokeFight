package sptech.school.pokeFight_API;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pokemon")
@CrossOrigin(origins = "*", allowedHeaders = "*")

public class PokemonController {

    private final JdbcTemplate jdbcTemplate;

    public PokemonController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/listar")
    public ResponseEntity<List<Pokemon>> listarPokemon(){
        String sql = "SELECT id_pokemon AS id_pokemon, nome_pokemon AS nome_pokemon FROM POKEMON;";

        List<Pokemon> pokemons = jdbcTemplate.query(sql,
                new BeanPropertyRowMapper<>(Pokemon.class));
        return ResponseEntity.status(200).body(pokemons);
    }

    @GetMapping("/ataque/{id_pokemon}")
    public ResponseEntity<List<Ataque>> listarAtaques(@PathVariable("id_pokemon") Integer id){
        String sql = "SELECT a.id_ataque, a.nome_ataque, a.tipo_ataque, a.dano_ataque FROM POKEMON_ATAQUE pa " +
                "JOIN ATAQUE a ON pa.id_ataque = a.id_ataque " +
                "JOIN POKEMON p ON pa.id_pokemon = p.id_pokemon " +
                "WHERE p.id_pokemon = ?;";
        try {
            List<Ataque> ataques = jdbcTemplate.query(sql,
                    new BeanPropertyRowMapper<>(Ataque.class),
            id);
            return ResponseEntity.status(200).body(ataques);
        }catch (EmptyResultDataAccessException e) {
            e.printStackTrace();
            return ResponseEntity.status(404).build();
        }
    }
}
