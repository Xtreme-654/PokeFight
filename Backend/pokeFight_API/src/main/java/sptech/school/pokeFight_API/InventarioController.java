package sptech.school.pokeFight_API;


import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.web.bind.annotation.*;

import java.security.PublicKey;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/Inventario")
    @CrossOrigin(origins = "*", allowedHeaders = "*")
public class InventarioController {

    private final JdbcTemplate jdbcTemplate;

    public InventarioController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @PostMapping("/cadastrar")
    public ResponseEntity<List<Inventario>> cadastrar_pokemon(@RequestBody Inventario criarInventario) {

        if (criarInventario == null || criarInventario.getTreinador() == null || criarInventario.getTreinador().getId_treinador() == null) {
            return ResponseEntity.status(400).build();
        }

        if (!ExisteId(criarInventario.getTreinador().getId_treinador())) {
            return ResponseEntity.status(404).build();
        }

        String sql = "INSERT INTO INVENTARIO (id_treinador, id_pokemon) VALUES (?, ?);";
        List<Inventario> lista_inventario = new ArrayList<>();

        for (Pokemon poke : criarInventario.getId_pokemon()) {
            KeyHolder keyHolder = new GeneratedKeyHolder();

            jdbcTemplate.update(con -> {
                PreparedStatement ps = con.prepareStatement(sql, new String[] { "ID_INVENTARIO" });
                ps.setInt(1, criarInventario.getTreinador().getId_treinador());
                ps.setInt(2, poke.getId_pokemon());
                return ps;
            }, keyHolder);

            Number key = keyHolder.getKey();
            Integer idGerado = (key != null) ? key.intValue() : null;

            Inventario novo_Inventario = new Inventario();
            novo_Inventario.setId_inventario(idGerado);
            novo_Inventario.setTreinador(criarInventario.getTreinador());
            novo_Inventario.setId_pokemon(List.of(poke));

            lista_inventario.add(novo_Inventario);
        }

        return ResponseEntity.status(201).body(lista_inventario);
    }
    @GetMapping("/{id_treinador}")
    public ResponseEntity<List<Inventario>> listar_inventario(@PathVariable("id_treinador") Integer id) {
        String sql = "SELECT p.id_pokemon, p.nome_pokemon, p.tipo_pokemon, p.vida_pokemon, p.fraqueza_pokemon " +
                "FROM INVENTARIO i " +
                "JOIN POKEMON p ON i.id_pokemon = p.id_pokemon " +
                "JOIN TREINADOR t ON i.id_treinador = t.id_treinador " +
                "WHERE t.id_treinador = ?;";
        try {
            List<Pokemon> pokemons = jdbcTemplate.query(sql, (rs, rowNum) -> {
                Pokemon p = new Pokemon();
                p.setId_pokemon(rs.getInt("id_pokemon"));
                p.setNome_pokemon(rs.getString("nome_pokemon"));
                p.setTipo_pokemon(rs.getString("tipo_pokemon"));
                p.setVida_pokemon(rs.getInt("vida_pokemon"));
                p.setFraqueza_pokemon(rs.getString("fraqueza_pokemon"));
                return p;
            }, id);

            if (pokemons.isEmpty()) {
                return ResponseEntity.status(404).build();
            }

            Inventario inventario = new Inventario();
            inventario.setId_pokemon(pokemons);

            return ResponseEntity.status(200).body(List.of(inventario));

        } catch (EmptyResultDataAccessException e) {
            e.printStackTrace();
            return ResponseEntity.status(404).build();
        }
    }

    @GetMapping("/primeiro/{id_treinador}")
    public ResponseEntity<Pokemon> primeiro_pokemon(@PathVariable("id_treinador") Integer id) {
        String sql = "SELECT p.id_pokemon, p.nome_pokemon, p.tipo_pokemon, p.vida_pokemon, p.fraqueza_pokemon " +
                "FROM INVENTARIO i " +
                "JOIN POKEMON p ON i.id_pokemon = p.id_pokemon " +
                "WHERE i.id_treinador = ? " +
                "ORDER BY i.id_inventario ASC LIMIT 1;";
        try {
            Pokemon primeiroPokemon = jdbcTemplate.queryForObject(
                    sql,
                    new BeanPropertyRowMapper<>(Pokemon.class),
                    id
            );
            return ResponseEntity.status(200).body(primeiroPokemon);
        } catch (EmptyResultDataAccessException e) {
            return ResponseEntity.status(404).build();
        }
    }

    public Boolean ExisteId(Integer id_treinador){
        String sqlExiste = "SELECT COUNT(*) FROM TREINADOR WHERE id_treinador = ?;";
        Integer count = jdbcTemplate.queryForObject(sqlExiste, Integer.class ,id_treinador);
        Boolean existe = count > 0;
        return existe;
    }
}
