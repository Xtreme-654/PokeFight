package sptech.school.pokeFight_API;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

}
