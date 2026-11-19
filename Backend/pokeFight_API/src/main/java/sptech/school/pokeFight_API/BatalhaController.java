package sptech.school.pokeFight_API;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/** API de batalha por turnos; decisões do bot são anunciadas e resolvidas em chamadas distintas. */
@RestController
@RequestMapping("/api/battles")
@CrossOrigin(origins = "*")
public class BatalhaController {
    private final JdbcTemplate jdbc;
    private final TypeEffectivenessService effectiveness;
    private final Random random = new Random();
    private static final String[] NOMES_BOT = {"Treinador da Rota 4", "N", "Ghetsis", "Treinador de Ginásio", "Treinadora de Unova"};

    public BatalhaController(JdbcTemplate jdbc, TypeEffectivenessService effectiveness) {
        this.jdbc = jdbc;
        this.effectiveness = effectiveness;
    }

    @PostMapping
    @Transactional
    public ResponseEntity<?> iniciar(@RequestBody Map<String,Object> body) {
        Integer treinadorId = integer(body.get("treinadorId"));
        if (treinadorId == null) return ResponseEntity.badRequest().body(Map.of("erro", "treinadorId obrigatório"));
        if (!treinadorExiste(treinadorId)) return ResponseEntity.notFound().build();
        List<Map<String,Object>> equipe = jdbc.queryForList(
            "SELECT e.posicao,e.id_pokemon,p.vida_pokemon FROM EQUIPE_TREINADOR e JOIN POKEMON p ON p.id_pokemon=e.id_pokemon WHERE e.id_treinador=? ORDER BY e.posicao", treinadorId);
        if (equipe.size() != 6) return ResponseEntity.badRequest().body(Map.of("erro", "Configure uma equipe de seis Pokémon antes de batalhar."));

        List<Map<String,Object>> candidatos = jdbc.queryForList("SELECT id_pokemon,vida_pokemon FROM POKEMON WHERE numero_pokedex BETWEEN 494 AND 649 ORDER BY id_pokemon");
        if (candidatos.isEmpty()) return ResponseEntity.internalServerError().body(Map.of("erro", "Catálogo Unova vazio."));
        Collections.shuffle(candidatos, random);
        List<Map<String,Object>> bot = new ArrayList<>(candidatos.subList(0, Math.min(6, candidatos.size())));
        while (bot.size() < 6) bot.add(candidatos.get(random.nextInt(candidatos.size())));

        String nomeBot = NOMES_BOT[random.nextInt(NOMES_BOT.length)];
        jdbc.update("INSERT INTO BATALHA (id_treinador,nome_bot,status,turno_atual) VALUES (?,?,'EM_ANDAMENTO',1)", treinadorId, nomeBot);
        Long id = jdbc.queryForObject("SELECT MAX(id_batalha) FROM BATALHA WHERE id_treinador=?", Long.class, treinadorId);
        for (int i = 0; i < 6; i++) {
            Map<String,Object> p = equipe.get(i), b = bot.get(i);
            // O HP máximo já é balanceado em +60% no seed do catálogo.
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'JOGADOR',?,?,?,?)",
                id, i + 1, p.get("ID_POKEMON"), p.get("VIDA_POKEMON"), i == 0);
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'BOT',?,?,?,?)",
                id, i + 1, b.get("ID_POKEMON"), b.get("VIDA_POKEMON"), i == 0);
        }
        log(id, 1, 1, "O que " + nomePokemonAtivo(id, "JOGADOR") + " vai fazer?");
        return ResponseEntity.status(201).body(estado(id, treinadorId));
    }

    @GetMapping("/history/{treinadorId}")
    public ResponseEntity<?> historico(@PathVariable Integer treinadorId) {
        if (!treinadorExiste(treinadorId)) return ResponseEntity.notFound().build();
        List<Map<String,Object>> rows = jdbc.queryForList("SELECT id_batalha,nome_bot,status,resultado,iniciada_em,finalizada_em FROM BATALHA WHERE id_treinador=? ORDER BY iniciada_em DESC", treinadorId);
        for (Map<String,Object> row : rows) {
            Long id = ((Number) row.get("ID_BATALHA")).longValue();
            row.put("eventos", jdbc.queryForList("SELECT turno,mensagem,criado_em FROM BATALHA_LOG WHERE id_batalha=? ORDER BY id_log", id));
        }
        return ResponseEntity.ok(rows);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> obter(@PathVariable Long id, @RequestParam Integer treinadorId) {
        if (!dono(id, treinadorId)) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(estado(id, treinadorId));
    }

    @PostMapping("/{id}/actions")
    @Transactional
    public ResponseEntity<?> agir(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId = integer(body.get("treinadorId"));
        if (treinadorId == null || !dono(id, treinadorId)) return ResponseEntity.notFound().build();
        if (!batalhaEmAndamento(id)) return ResponseEntity.status(409).body(Map.of("erro", "Batalha encerrada."));
        int turno = jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?", Integer.class, id);
        String tipo = String.valueOf(body.get("tipo"));

        if ("TROCAR".equalsIgnoreCase(tipo)) {
            Integer pos = integer(body.get("posicaoDestino"));
            if (pos == null || pos < 1 || pos > 6) return ResponseEntity.badRequest().body(Map.of("erro", "Posição de troca inválida."));
            Integer hp = hpNaPosicao(id, "JOGADOR", pos);
            if (hp == null || hp <= 0) return ResponseEntity.badRequest().body(Map.of("erro", "Não é possível trocar para um Pokémon derrotado."));
            Integer atual = posicaoAtiva(id, "JOGADOR");
            if (Objects.equals(atual, pos)) return ResponseEntity.badRequest().body(Map.of("erro", "Esse Pokémon já está em campo."));
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=FALSE WHERE id_batalha=? AND lado='JOGADOR'", id);
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado='JOGADOR' AND posicao=?", id, pos);
            log(id, turno, 1, nomePokemonNaPosicao(id, "JOGADOR", pos) + ", eu escolho você!");
        } else if ("ATACAR".equalsIgnoreCase(tipo)) {
            Integer ataqueId = integer(body.get("idAtaque"));
            if (ataqueId == null) return ResponseEntity.badRequest().body(Map.of("erro", "idAtaque obrigatório."));
            Integer hpAtacante = hpAtivo(id, "JOGADOR");
            if (hpAtacante == null || hpAtacante <= 0) return ResponseEntity.badRequest().body(Map.of("erro", "Escolha um Pokémon saudável antes de atacar."));
            Integer permitido = jdbc.queryForObject(
                "SELECT COUNT(*) FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='JOGADOR' AND bp.ativo=TRUE AND bp.hp_atual>0 AND pa.id_ataque=?",
                Integer.class, id, ataqueId);
            if (permitido == null || permitido == 0) return ResponseEntity.badRequest().body(Map.of("erro", "Golpe não permitido para o Pokémon ativo."));
            executarGolpe(id, "JOGADOR", ataqueId, turno, 1);
        } else return ResponseEntity.badRequest().body(Map.of("erro", "Tipo deve ser ATACAR ou TROCAR."));

        finalizarSeNecessario(id, treinadorId);
        return ResponseEntity.ok(estado(id, treinadorId));
    }

    /** A IA só escolhe a ação quando esta rota é chamada pelo front após terminar os textos anteriores. */
    @PostMapping("/{id}/bot-turn/announce")
    @Transactional
    public ResponseEntity<?> anunciarTurnoBot(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId = integer(body.get("treinadorId"));
        if (treinadorId == null || !dono(id, treinadorId)) return ResponseEntity.notFound().build();
        if (!batalhaEmAndamento(id)) return ResponseEntity.status(409).body(Map.of("erro", "Batalha encerrada."));
        Integer hpBot = hpAtivo(id, "BOT"), hpJogador = hpAtivo(id, "JOGADOR");
        if (hpBot == null || hpBot <= 0 || hpJogador == null || hpJogador <= 0)
            return ResponseEntity.ok(Map.of("tipoAcao", "NENHUMA", "idAtaque", 0, "mensagem", "O adversário aguarda sua próxima escolha.", "estado", estado(id, treinadorId)));

        Map<String,Object> botAtivo = pokemonAtivo(id, "BOT");
        int hpMax = ((Number) botAtivo.get("VIDA_POKEMON")).intValue();
        List<Integer> reservas = jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='BOT' AND ativo=FALSE AND hp_atual>0 ORDER BY posicao", (rs, n) -> rs.getInt(1), id);
        // Com HP crítico, o bot pode trocar para uma reserva saudável antes de atacar.
        if (!reservas.isEmpty() && hpBot <= Math.ceil(hpMax * 0.25) && random.nextDouble() < 0.65) {
            int destino = reservas.get(random.nextInt(reservas.size()));
            String nomeAtual = nomePokemonAtivo(id, "BOT"), nomeNovo = nomePokemonNaPosicao(id, "BOT", destino);
            String mensagem = nomeAtual + " voltou! " + nomeNovo + " entrou em campo!";
            log(id, turnoAtual(id), 1, mensagem);
            return ResponseEntity.ok(Map.of("tipoAcao", "TROCAR", "posicaoDestino", destino, "idAtaque", 0, "mensagem", mensagem, "estado", estado(id, treinadorId)));
        }

        List<Integer> ataques = jdbc.query("SELECT pa.id_ataque FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='BOT' AND bp.ativo=TRUE AND bp.hp_atual>0 ORDER BY pa.id_ataque", (rs, n) -> rs.getInt(1), id);
        if (ataques.isEmpty()) return ResponseEntity.ok(Map.of("tipoAcao", "NENHUMA", "idAtaque", 0, "mensagem", "O adversário não encontrou um golpe.", "estado", estado(id, treinadorId)));
        Integer ataque = ataques.get(random.nextInt(ataques.size()));
        String nomeAtaque = jdbc.queryForObject("SELECT nome_ataque FROM ATAQUE WHERE id_ataque=?", String.class, ataque);
        String mensagem = nomePokemonAtivo(id, "BOT") + " usou " + nomeAtaque + "!";
        log(id, turnoAtual(id), 1, mensagem);
        return ResponseEntity.ok(Map.of("tipoAcao", "ATACAR", "idAtaque", ataque, "mensagem", mensagem, "estado", estado(id, treinadorId)));
    }

    /** Aplica a decisão do bot somente depois que o front termina de escrever a mensagem anunciada. */
    @PostMapping("/{id}/bot-turn/resolve")
    @Transactional
    public ResponseEntity<?> resolverTurnoBot(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId = integer(body.get("treinadorId"));
        Integer ataqueId = integer(body.get("idAtaque"));
        String tipoAcao = String.valueOf(body.getOrDefault("tipoAcao", "ATACAR"));
        if (treinadorId == null || !dono(id, treinadorId)) return ResponseEntity.notFound().build();
        if (!batalhaEmAndamento(id)) return ResponseEntity.status(409).body(Map.of("erro", "Batalha encerrada."));
        int turno = turnoAtual(id);

        if ("TROCAR".equalsIgnoreCase(tipoAcao)) {
            Integer pos = integer(body.get("posicaoDestino"));
            Integer hpDestino = pos == null ? null : hpNaPosicao(id, "BOT", pos);
            if (pos != null && pos >= 1 && pos <= 6 && hpDestino != null && hpDestino > 0) {
                jdbc.update("UPDATE BATALHA_POKEMON SET ativo=FALSE WHERE id_batalha=? AND lado='BOT'", id);
                jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado='BOT' AND posicao=?", id, pos);
            }
        } else if ("ATACAR".equalsIgnoreCase(tipoAcao) && ataqueId != null && ataqueId > 0) {
            Integer hpBot = hpAtivo(id, "BOT"), hpJogador = hpAtivo(id, "JOGADOR");
            if (hpBot != null && hpBot > 0 && hpJogador != null && hpJogador > 0) {
                Integer permitido = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='BOT' AND bp.ativo=TRUE AND bp.hp_atual>0 AND pa.id_ataque=?",
                    Integer.class, id, ataqueId);
                if (permitido != null && permitido > 0) executarGolpe(id, "BOT", ataqueId, turno, 2);
            }
        }

        finalizarSeNecessario(id, treinadorId);
        if (batalhaEmAndamento(id)) {
            jdbc.update("UPDATE BATALHA SET turno_atual=turno_atual+1 WHERE id_batalha=?", id);
            if (hpAtivo(id, "JOGADOR") == null || hpAtivo(id, "JOGADOR") <= 0) {
                log(id, turnoAtual(id), 1, "Escolha um Pokémon para continuar!");
            } else {
                log(id, turnoAtual(id), 1, "O que " + nomePokemonAtivo(id, "JOGADOR") + " vai fazer?");
            }
        }
        return ResponseEntity.ok(estado(id, treinadorId));
    }

    private void executarGolpe(Long id, String ladoAtacante, Integer ataqueId, int turno, int ordem) {
        Integer hpAtacante = hpAtivo(id, ladoAtacante);
        if (hpAtacante == null || hpAtacante <= 0) return; // Um Pokémon derrotado nunca conclui ação enfileirada.
        Map<String,Object> atk = jdbc.queryForMap("SELECT nome_ataque,tipo_ataque,dano_ataque FROM ATAQUE WHERE id_ataque=?", ataqueId);
        String alvo = "JOGADOR".equals(ladoAtacante) ? "BOT" : "JOGADOR";
        Map<String,Object> alvoP = jdbc.queryForMap(
            "SELECT bp.posicao,bp.hp_atual,p.tipo_pokemon,p.tipo_secundario FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.ativo=TRUE AND bp.hp_atual>0", id, alvo);
        int pos = ((Number) alvoP.get("POSICAO")).intValue();
        String tipoAtaque = String.valueOf(atk.get("TIPO_ATAQUE"));
        TypeEffectivenessService.Result result = effectiveness.calculate(tipoAtaque,
            String.valueOf(alvoP.get("TIPO_POKEMON")), (String) alvoP.get("TIPO_SECUNDARIO"));
        int danoBase = ((Number) atk.get("DANO_ATAQUE")).intValue();
        int danoFinal = Math.max(0, Math.round(danoBase * (float) result.multiplier()));
        int hp = Math.max(0, ((Number) alvoP.get("HP_ATUAL")).intValue() - danoFinal);
        jdbc.update("UPDATE BATALHA_POKEMON SET hp_atual=?,derrotado=?,ativo=? WHERE id_batalha=? AND lado=? AND posicao=?",
            hp, hp == 0, hp > 0, id, alvo, pos);

        if ("JOGADOR".equals(ladoAtacante)) {
            log(id, turno, ordem, nomePokemonNaPosicao(id, "JOGADOR", posicaoAtiva(id, "JOGADOR")) + " usou " + atk.get("NOME_ATAQUE") + "!");
        }
        if (result.immune()) log(id, turno, ordem + 1, "Imune! Não afetou " + nomePokemonNaPosicao(id, alvo, pos) + "!");
        else if (result.multiplier() >= 2.0) log(id, turno, ordem + 1, "Super-efetivo!");
        else if (result.multiplier() > 1.0) log(id, turno, ordem + 1, "Efetivo!");
        else if (result.multiplier() == 1.0) log(id, turno, ordem + 1, "Efeito normal.");
        else log(id, turno, ordem + 1, "Pouco-efetivo...");
        if (hp == 0) {
            String derrotado = nomePokemonNaPosicao(id, alvo, pos);
            log(id, turno, ordem + 2, derrotado + " foi derrotado!");
            // O bot pode escolher automaticamente a próxima criatura; o jogador deve escolher manualmente.
            if ("BOT".equals(alvo)) {
                Integer proximo = jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='BOT' AND hp_atual>0 ORDER BY posicao LIMIT 1", rs -> rs.next() ? rs.getInt(1) : null, id);
                if (proximo != null) jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado='BOT' AND posicao=?", id, proximo);
            }
        }
    }

    private boolean finalizarSeNecessario(Long id, Integer treinadorId) {
        for (String lado : List.of("JOGADOR", "BOT")) {
            Integer vivos = jdbc.queryForObject("SELECT COUNT(*) FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND hp_atual>0", Integer.class, id, lado);
            if (vivos != null && vivos == 0) {
                String resultado = "BOT".equals(lado) ? "VITORIA" : "DERROTA";
                jdbc.update("UPDATE BATALHA SET status=?,resultado=?,finalizada_em=CURRENT_TIMESTAMP WHERE id_batalha=? AND status='EM_ANDAMENTO'", resultado, resultado, id);
                log(id, turnoAtual(id), 99, "Batalha encerrada: " + resultado + "!");
                jdbc.update("INSERT INTO PLACAR (resultado,data_hora,id_treinador) VALUES (?,CURRENT_TIMESTAMP,?)", resultado, treinadorId);
                return true;
            }
        }
        return false;
    }

    private Map<String,Object> estado(Long id, Integer treinadorId) {
        Map<String,Object> b = jdbc.queryForMap("SELECT id_batalha,nome_bot,status,turno_atual,resultado,iniciada_em,finalizada_em FROM BATALHA WHERE id_batalha=?", id);
        List<Map<String,Object>> mons = jdbc.queryForList(
            "SELECT bp.lado,bp.posicao,bp.hp_atual,bp.ativo,bp.derrotado,p.id_pokemon,p.nome_pokemon,p.tipo_pokemon,p.tipo_secundario,p.vida_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? ORDER BY bp.lado,bp.posicao", id);
        List<Map<String,Object>> logs = jdbc.queryForList("SELECT turno,mensagem,criado_em FROM BATALHA_LOG WHERE id_batalha=? ORDER BY id_log", id);
        return Map.of("batalha", b, "pokemon", mons, "eventos", logs);
    }

    private Map<String,Object> pokemonAtivo(Long id, String lado) {
        return jdbc.queryForMap("SELECT bp.hp_atual,p.vida_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.ativo=TRUE", id, lado);
    }
    private Integer hpAtivo(Long id, String lado) { return jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE", rs -> rs.next() ? rs.getInt(1) : null, id, lado); }
    private Integer hpNaPosicao(Long id, String lado, int pos) { return jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND posicao=?", rs -> rs.next() ? rs.getInt(1) : null, id, lado, pos); }
    private String nomePokemonAtivo(Long id, String lado) { return jdbc.query("SELECT p.nome_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.ativo=TRUE", rs -> rs.next() ? rs.getString(1) : "Pokémon", id, lado); }
    private String nomePokemonNaPosicao(Long id, String lado, int pos) { return jdbc.query("SELECT p.nome_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.posicao=?", rs -> rs.next() ? rs.getString(1) : "Pokémon", id, lado, pos); }
    private Integer posicaoAtiva(Long id, String lado) { return jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE", rs -> rs.next() ? rs.getInt(1) : null, id, lado); }
    private int turnoAtual(Long id) { return jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?", Integer.class, id); }
    private void log(Long id, int turno, int ordem, String mensagem) { jdbc.update("INSERT INTO BATALHA_LOG (id_batalha,turno,ordem_evento,mensagem) VALUES (?,?,?,?)", id, turno, ordem, mensagem); }
    private boolean batalhaEmAndamento(Long id) { return "EM_ANDAMENTO".equals(jdbc.queryForObject("SELECT status FROM BATALHA WHERE id_batalha=?", String.class, id)); }
    private boolean dono(Long id, Integer treinadorId) { if (treinadorId == null) return false; Integer n = jdbc.queryForObject("SELECT COUNT(*) FROM BATALHA WHERE id_batalha=? AND id_treinador=?", Integer.class, id, treinadorId); return n != null && n > 0; }
    private boolean treinadorExiste(Integer id) { if (id == null) return false; Integer n = jdbc.queryForObject("SELECT COUNT(*) FROM TREINADOR WHERE id_treinador=?", Integer.class, id); return n != null && n > 0; }
    private Integer integer(Object x) { if (x instanceof Number n) return n.intValue(); try { return x == null ? null : Integer.valueOf(x.toString()); } catch (Exception e) { return null; } }
    private String formatMultiplier(double value) { return String.format(Locale.US, "%.1f", value).replaceAll("\\.0$", ""); }
}
