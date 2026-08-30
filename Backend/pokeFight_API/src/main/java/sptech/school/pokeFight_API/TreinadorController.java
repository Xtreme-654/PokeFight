package sptech.school.pokeFight_API;

import org.jspecify.annotations.NonNull;
import org.springframework.aop.support.DelegatingIntroductionInterceptor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.web.bind.annotation.*;

import java.sql.PreparedStatement;
import java.sql.Statement;

@RestController
@RequestMapping("/treinador")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class TreinadorController {

    private final JdbcTemplate jdbcTemplate;

    public TreinadorController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @PostMapping("/cadastrar")
    public ResponseEntity<Treinador> cadastrar(@RequestBody Treinador treinadorCriar){

        String sql = "INSERT INTO TREINADOR (nome_treinador, senha_treinador, personagem_treinador) VALUES (?,?,?);";

        if (existeNome(treinadorCriar.getNome_treinador())){
            return ResponseEntity.status(409).body(treinadorCriar);
        } else if (TreinadorInvalido(treinadorCriar)) {
            return ResponseEntity.status(400).body(treinadorCriar);
        }else{

            KeyHolder keyHolder = new GeneratedKeyHolder();

            jdbcTemplate.update(con -> {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, treinadorCriar.getNome_treinador());
                ps.setString(2,treinadorCriar.getSenha_treinador());
                ps.setString(3, treinadorCriar.getPersonagem_treinador());

            return ps;
            }, keyHolder);

            Integer idGerado = keyHolder.getKeyAs(Integer.class);
            treinadorCriar.setId_treinador(idGerado);
            return ResponseEntity.status(201).body(treinadorCriar);
        }
    }

    @GetMapping("/{nome_treinador}")
    public ResponseEntity<Treinador> listarPorNome(@PathVariable("nome_treinador") String nome){

        String sql = "SELECT (id_treinador) FROM TREINADOR WHERE nome_treinador = ?;";

        try {
            Treinador treinador = jdbcTemplate.queryForObject(sql,
                    new BeanPropertyRowMapper<>(Treinador.class),
                    nome
            );
            return ResponseEntity.status(200).body(treinador);
        }catch (EmptyResultDataAccessException e){
            e.printStackTrace();
            return ResponseEntity.status(404).build();
        }
    }

    private @NonNull Boolean existeNome(String nome_treinador){
        String sqlExiste = "SELECT COUNT(*) FROM TREINADOR WHERE LOWER(nome_treinador) = LOWER(?);";
        Integer count = jdbcTemplate.queryForObject(sqlExiste, Integer.class ,nome_treinador);
        Boolean existe = count > 0;
        return existe;
    }

    private Boolean TreinadorInvalido(Treinador treinador){
        if (treinador == null){
            return true;
        } else if (treinador.getNome_treinador() == null || treinador.getNome_treinador().isBlank()){
            return true;
        } else if (treinador.getSenha_treinador() == null || treinador.getPersonagem_treinador().isBlank()) {
            return true;
        } else if (treinador.getPersonagem_treinador() == null || treinador.getPersonagem_treinador().isBlank()) {
            return true;
        }
        return false;
    }
}
