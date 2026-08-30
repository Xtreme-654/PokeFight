package sptech.school.pokeFight_API;


import org.springframework.http.ResponseEntity;
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


    public Boolean ExisteId(Integer id_treinador){
        String sqlExiste = "SELECT COUNT(*) FROM TREINADOR WHERE id_treinador = ?;";
        Integer count = jdbcTemplate.queryForObject(sqlExiste, Integer.class ,id_treinador);
        Boolean existe = count > 0;
        return existe;
    }
}
