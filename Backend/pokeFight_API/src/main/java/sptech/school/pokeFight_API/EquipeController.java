package sptech.school.pokeFight_API;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/** API de equipe PokePath. O ID do treinador deve ser obtido da autenticação ao integrar Spring Security. */
@RestController
@RequestMapping("/api/user/team")
@CrossOrigin(origins = "*")
public class EquipeController {
    private final JdbcTemplate jdbc;
    public EquipeController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

    @GetMapping
    public ResponseEntity<?> listar(@RequestParam Integer treinadorId) {
        if (!treinadorExiste(treinadorId)) return ResponseEntity.notFound().build();
        List<Map<String,Object>> equipe = jdbc.queryForList(
            "SELECT e.posicao, p.id_pokemon AS idPokemon, p.nome_pokemon AS nome, p.numero_pokedex AS numeroPokedex, p.tipo_pokemon AS tipo, p.vida_pokemon AS hpMaximo " +
            "FROM EQUIPE_TREINADOR e JOIN POKEMON p ON p.id_pokemon=e.id_pokemon WHERE e.id_treinador=? ORDER BY e.posicao", treinadorId);
        for (Map<String,Object> item : equipe) {
            List<Map<String,Object>> golpes = jdbc.queryForList(
                "SELECT a.id_ataque AS id, a.nome_ataque AS nome, a.tipo_ataque AS tipo, a.dano_ataque AS poder " +
                "FROM EQUIPE_POKEMON_ATAQUE ea JOIN ATAQUE a ON a.id_ataque=ea.id_ataque WHERE ea.id_equipe=(SELECT e.id_equipe FROM EQUIPE_TREINADOR e WHERE e.id_treinador=? AND e.posicao=?) ORDER BY ea.slot_ataque",
                treinadorId, ((Number)item.get("POSICAO")).intValue());
            item.put("golpes", golpes);
        }
        return ResponseEntity.ok(Map.of("treinadorId", treinadorId, "pokemon", equipe));
    }

    @PutMapping
    @Transactional
    public ResponseEntity<?> atualizar(@RequestParam Integer treinadorId, @RequestBody Map<String,Object> body) {
        if (!treinadorExiste(treinadorId)) return ResponseEntity.notFound().build();
        Object raw = body.get("pokemon");
        if (!(raw instanceof List<?> itens) || itens.size() != 6)
            return ResponseEntity.badRequest().body(Map.of("erro", "A equipe deve conter exatamente seis Pokémon."));

        Set<Integer> posicoes = new HashSet<>();
        List<Map<String,Object>> validados = new ArrayList<>();
        for (Object obj : itens) {
            if (!(obj instanceof Map<?,?> item)) return ResponseEntity.badRequest().body(Map.of("erro", "Integrante inválido."));
            Integer id = numero(item.get("idPokemon"));
            Integer pos = numero(item.get("posicao"));
            if (id == null || pos == null || pos < 1 || pos > 6 || !posicoes.add(pos))
                return ResponseEntity.badRequest().body(Map.of("erro", "IDs e posições são obrigatórios; posições únicas de 1 a 6."));
            Integer dex = jdbc.query("SELECT numero_pokedex FROM POKEMON WHERE id_pokemon=?", rs -> rs.next() ? (Integer)rs.getObject(1) : null, id);
            if (dex == null || dex < 494 || dex > 649)
                return ResponseEntity.badRequest().body(Map.of("erro", "Pokémon inexistente ou fora da 5ª geração.", "idPokemon", id));
            List<Integer> golpes = new ArrayList<>();
            Object rawGolpes = item.get("golpes");
            if (rawGolpes instanceof List<?> lista) for (Object g : lista) { Integer gid = numero(g); if (gid == null || golpes.contains(gid)) return ResponseEntity.badRequest().body(Map.of("erro", "Lista de golpes inválida.")); golpes.add(gid); }
            if (golpes.size() > 4) return ResponseEntity.badRequest().body(Map.of("erro", "Cada Pokémon pode equipar até quatro golpes."));
            if (!golpes.isEmpty()) {
                for (Integer golpe : golpes) {
                    Integer existe = jdbc.query("SELECT COUNT(*) FROM POKEMON_ATAQUE WHERE id_pokemon=? AND id_ataque=?", rs -> {rs.next(); return rs.getInt(1);}, id, golpe);
                    if (existe == 0) return ResponseEntity.badRequest().body(Map.of("erro", "Golpe não associado a esse Pokémon.", "idPokemon", id, "idAtaque", golpe));
                }
            } else {
                golpes = jdbc.query("SELECT id_ataque FROM POKEMON_ATAQUE WHERE id_pokemon=? ORDER BY id_ataque LIMIT 4", (rs, n) -> rs.getInt(1), id);
                if (golpes.isEmpty()) return ResponseEntity.badRequest().body(Map.of("erro", "Pokémon sem golpes cadastrados.", "idPokemon", id));
            }
            validados.add(Map.of("id", id, "posicao", pos, "golpes", golpes));
        }
        if (posicoes.size() != 6) return ResponseEntity.badRequest().body(Map.of("erro", "Informe cada posição de 1 a 6."));

        jdbc.update("DELETE FROM EQUIPE_TREINADOR WHERE id_treinador=?", treinadorId);
        validados.sort(Comparator.comparingInt(x -> (Integer)x.get("posicao")));
        for (Map<String,Object> p : validados) {
            jdbc.update("INSERT INTO EQUIPE_TREINADOR (id_treinador,id_pokemon,posicao) VALUES (?,?,?)", treinadorId,p.get("id"),p.get("posicao"));
            Integer equipeId = jdbc.queryForObject("SELECT id_equipe FROM EQUIPE_TREINADOR WHERE id_treinador=? AND posicao=?", Integer.class, treinadorId,p.get("posicao"));
            int slot=1;
            for (Integer golpe : (List<Integer>)p.get("golpes")) jdbc.update("INSERT INTO EQUIPE_POKEMON_ATAQUE (id_equipe,id_ataque,slot_ataque) VALUES (?,?,?)", equipeId,golpe,slot++);
        }
        return ResponseEntity.noContent().build();
    }

    private boolean treinadorExiste(Integer id) {
        if (id == null) return false;
        Integer n = jdbc.queryForObject("SELECT COUNT(*) FROM TREINADOR WHERE id_treinador=?", Integer.class, id);
        return n != null && n > 0;
    }
    private Integer numero(Object v) {
        if (v instanceof Number n) return n.intValue();
        try { return v == null ? null : Integer.valueOf(v.toString()); } catch (NumberFormatException e) { return null; }
    }
}
