package sptech.school.pokeFight_API;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/** API de batalha por turnos. O front controla a apresentação das mensagens; o servidor valida cada ação. */
@RestController
@RequestMapping("/api/battles")
@CrossOrigin(origins = "*")
public class BatalhaController {
    private final JdbcTemplate jdbc;
    private final Random random = new Random();
    private static final String[] NOMES_BOT = {"Treinador da Rota 4", "N", "Ghetsis", "Treinador de Ginásio", "Treinadora de Unova"};
    public BatalhaController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

    @PostMapping
    @Transactional
    public ResponseEntity<?> iniciar(@RequestBody Map<String,Object> body) {
        Integer treinadorId = integer(body.get("treinadorId"));
        if (treinadorId == null) return ResponseEntity.badRequest().body(Map.of("erro", "treinadorId obrigatório"));
        Integer existe = jdbc.queryForObject("SELECT COUNT(*) FROM TREINADOR WHERE id_treinador=?", Integer.class, treinadorId);
        if (existe == null || existe == 0) return ResponseEntity.notFound().build();
        List<Map<String,Object>> equipe = jdbc.queryForList("SELECT e.posicao,e.id_pokemon,p.vida_pokemon FROM EQUIPE_TREINADOR e JOIN POKEMON p ON p.id_pokemon=e.id_pokemon WHERE e.id_treinador=? ORDER BY e.posicao", treinadorId);
        if (equipe.size()!=6) return ResponseEntity.badRequest().body(Map.of("erro", "Configure uma equipe de seis Pokémon antes de batalhar."));
        List<Map<String,Object>> candidatos = jdbc.queryForList("SELECT id_pokemon,vida_pokemon FROM POKEMON WHERE numero_pokedex BETWEEN 494 AND 649 ORDER BY id_pokemon");
        if (candidatos.isEmpty()) return ResponseEntity.internalServerError().body(Map.of("erro", "Catálogo Unova vazio."));
        // Sorteio sem repetição quando há candidatos suficientes, garantindo variedade por partida.
        Collections.shuffle(candidatos, random);
        List<Map<String,Object>> bot = new ArrayList<>(candidatos.subList(0, Math.min(6,candidatos.size())));
        while(bot.size()<6) bot.add(candidatos.get(random.nextInt(candidatos.size())));
        String nomeBot=NOMES_BOT[random.nextInt(NOMES_BOT.length)];
        jdbc.update("INSERT INTO BATALHA (id_treinador,nome_bot,status,turno_atual) VALUES (?,?,'EM_ANDAMENTO',1)", treinadorId,nomeBot);
        Long id=jdbc.queryForObject("SELECT MAX(id_batalha) FROM BATALHA WHERE id_treinador=?", Long.class, treinadorId);
        for(int i=0;i<6;i++) {
            Map<String,Object> p=equipe.get(i), b=bot.get(i);
            // HP é sempre restaurado ao máximo no início de cada batalha.
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'JOGADOR',?,?,?,?)",id,i+1,p.get("ID_POKEMON"),p.get("VIDA_POKEMON"),i==0);
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'BOT',?,?,?,?)",id,i+1,b.get("ID_POKEMON"),b.get("VIDA_POKEMON"),i==0);
        }
        String primeiro=nomePokemonAtivo(id,"JOGADOR");
        log(id,1,1,"O que "+primeiro+" vai fazer?");
        return ResponseEntity.status(201).body(estado(id,treinadorId));
    }

    @GetMapping("/history/{treinadorId}")
    public ResponseEntity<?> historico(@PathVariable Integer treinadorId) {
        if (!treinadorExiste(treinadorId)) return ResponseEntity.notFound().build();
        List<Map<String,Object>> rows = jdbc.queryForList("SELECT id_batalha,nome_bot,status,resultado,iniciada_em,finalizada_em FROM BATALHA WHERE id_treinador=? ORDER BY iniciada_em DESC", treinadorId);
        for (Map<String,Object> row : rows) {
            Long id=((Number)row.get("ID_BATALHA")).longValue();
            row.put("eventos", jdbc.queryForList("SELECT turno,mensagem,criado_em FROM BATALHA_LOG WHERE id_batalha=? ORDER BY id_log", id));
        }
        return ResponseEntity.ok(rows);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> obter(@PathVariable Long id, @RequestParam Integer treinadorId) {
        if (!dono(id,treinadorId)) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(estado(id,treinadorId));
    }

    /** Resolve apenas a ação do jogador. A resposta do bot é chamada separadamente após o typewriter. */
    @PostMapping("/{id}/actions")
    @Transactional
    public ResponseEntity<?> agir(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId=integer(body.get("treinadorId"));
        if (treinadorId==null || !dono(id,treinadorId)) return ResponseEntity.notFound().build();
        Map<String,Object> batalha=jdbc.queryForMap("SELECT status,turno_atual FROM BATALHA WHERE id_batalha=?",id);
        if (!"EM_ANDAMENTO".equals(batalha.get("STATUS"))) return ResponseEntity.status(409).body(Map.of("erro","Batalha encerrada."));
        int turno=((Number)batalha.get("TURNO_ATUAL")).intValue();
        String tipo=String.valueOf(body.get("tipo"));
        if("TROCAR".equalsIgnoreCase(tipo)) {
            Integer pos=integer(body.get("posicaoDestino"));
            if(pos==null||pos<1||pos>6) return ResponseEntity.badRequest().body(Map.of("erro","Posição de troca inválida."));
            Integer hp=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND posicao=?",rs->rs.next()?rs.getInt(1):null,id,pos);
            if(hp==null||hp<=0) return ResponseEntity.badRequest().body(Map.of("erro","Não é possível trocar para um Pokémon derrotado."));
            Integer atual=jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
            if (Objects.equals(atual,pos)) return ResponseEntity.badRequest().body(Map.of("erro","Esse Pokémon já está em campo."));
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=FALSE WHERE id_batalha=? AND lado='JOGADOR'",id);
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado='JOGADOR' AND posicao=?",id,pos);
            log(id,turno,1,nomePokemonNaPosicao(id,"JOGADOR",pos)+", eu escolho você!");
        } else if("ATACAR".equalsIgnoreCase(tipo)) {
            Integer ataqueId=integer(body.get("idAtaque"));
            if(ataqueId==null) return ResponseEntity.badRequest().body(Map.of("erro","idAtaque obrigatório."));
            Integer hpAtacante=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
            if(hpAtacante==null||hpAtacante<=0) return ResponseEntity.badRequest().body(Map.of("erro","Pokémon derrotado não pode atacar."));
            Integer permitido=jdbc.query("SELECT COUNT(*) FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='JOGADOR' AND bp.ativo=TRUE AND bp.hp_atual>0 AND pa.id_ataque=?",rs->{rs.next();return rs.getInt(1);},id,ataqueId);
            if(permitido==0) return ResponseEntity.badRequest().body(Map.of("erro","Golpe não permitido para o Pokémon ativo."));
            executarGolpe(id,"JOGADOR",ataqueId,turno,1);
        } else return ResponseEntity.badRequest().body(Map.of("erro","Tipo deve ser ATACAR ou TROCAR."));
        finalizarSeNecessario(id,treinadorId);
        return ResponseEntity.ok(estado(id,treinadorId));
    }

    /** Sorteia e anuncia o golpe do bot, sem aplicar dano. */
    @PostMapping("/{id}/bot-turn/announce")
    @Transactional
    public ResponseEntity<?> anunciarTurnoBot(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId=integer(body.get("treinadorId"));
        if(treinadorId==null||!dono(id,treinadorId)) return ResponseEntity.notFound().build();
        String status=jdbc.queryForObject("SELECT status FROM BATALHA WHERE id_batalha=?",String.class,id);
        if(!"EM_ANDAMENTO".equals(status)) return ResponseEntity.status(409).body(Map.of("erro","Batalha encerrada."));
        Integer hpBot=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='BOT' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
        Integer hpJogador=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
        if(hpBot==null||hpBot<=0||hpJogador==null||hpJogador<=0) return ResponseEntity.ok(Map.of("idAtaque",0,"mensagem","O adversário não pode agir neste turno.","estado",estado(id,treinadorId)));
        List<Integer> ataques=jdbc.query("SELECT pa.id_ataque FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='BOT' AND bp.ativo=TRUE AND bp.hp_atual>0 ORDER BY pa.id_ataque",(rs,n)->rs.getInt(1),id);
        if(ataques.isEmpty()) return ResponseEntity.ok(Map.of("idAtaque",0,"mensagem","O adversário não encontrou um golpe.","estado",estado(id,treinadorId)));
        Integer ataque=ataques.get(random.nextInt(ataques.size()));
        Map<String,Object> atk=jdbc.queryForMap("SELECT nome_ataque FROM ATAQUE WHERE id_ataque=?",ataque);
        String mensagem=nomePokemonAtivo(id,"BOT")+" usou "+atk.get("NOME_ATAQUE")+"!";
        log(id,jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?",Integer.class,id),1,mensagem);
        return ResponseEntity.ok(Map.of("idAtaque",ataque,"mensagem",mensagem,"estado",estado(id,treinadorId)));
    }

    /** Aplica o golpe anunciado somente depois que o front conclui o typewriter da mensagem. */
    @PostMapping("/{id}/bot-turn/resolve")
    @Transactional
    public ResponseEntity<?> resolverTurnoBot(@PathVariable Long id, @RequestBody Map<String,Object> body) {
        Integer treinadorId=integer(body.get("treinadorId")), ataqueId=integer(body.get("idAtaque"));
        if(treinadorId==null||!dono(id,treinadorId)) return ResponseEntity.notFound().build();
        String status=jdbc.queryForObject("SELECT status FROM BATALHA WHERE id_batalha=?",String.class,id);
        if(!"EM_ANDAMENTO".equals(status)) return ResponseEntity.status(409).body(Map.of("erro","Batalha encerrada."));
        Integer hpBot=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='BOT' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
        Integer hpJogador=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id);
        if(ataqueId!=null&&ataqueId>0&&hpBot!=null&&hpBot>0&&hpJogador!=null&&hpJogador>0) {
            Integer permitido=jdbc.query("SELECT COUNT(*) FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='BOT' AND bp.ativo=TRUE AND bp.hp_atual>0 AND pa.id_ataque=?",rs->{rs.next();return rs.getInt(1);},id,ataqueId);
            if(permitido>0) executarGolpe(id,"BOT",ataqueId,jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?",Integer.class,id),2);
        }
        finalizarSeNecessario(id,treinadorId);
        jdbc.update("UPDATE BATALHA SET turno_atual=turno_atual+1 WHERE id_batalha=? AND status='EM_ANDAMENTO'",id);
        if ("EM_ANDAMENTO".equals(jdbc.queryForObject("SELECT status FROM BATALHA WHERE id_batalha=?",String.class,id))) {
            log(id,jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?",Integer.class,id),1,"O que "+nomePokemonAtivo(id,"JOGADOR")+" vai fazer?");
        }
        return ResponseEntity.ok(estado(id,treinadorId));
    }

    private void executarGolpe(Long id,String ladoAtacante,Integer ataqueId,int turno,int ordem) {
        Integer hpAtacante=jdbc.query("SELECT hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE",rs->rs.next()?rs.getInt(1):null,id,ladoAtacante);
        if(hpAtacante==null||hpAtacante<=0) return; // Regra de KO: não executa ação de Pokémon derrotado.
        Map<String,Object> atk=jdbc.queryForMap("SELECT nome_ataque,dano_ataque FROM ATAQUE WHERE id_ataque=?",ataqueId);
        String alvo="JOGADOR".equals(ladoAtacante)?"BOT":"JOGADOR";
        Map<String,Object> alvoP=jdbc.queryForMap("SELECT posicao,id_pokemon,hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE",id,alvo);
        int hp=Math.max(0,((Number)alvoP.get("HP_ATUAL")).intValue()-((Number)atk.get("DANO_ATAQUE")).intValue());
        int pos=((Number)alvoP.get("POSICAO")).intValue();
        jdbc.update("UPDATE BATALHA_POKEMON SET hp_atual=?,derrotado=?,ativo=? WHERE id_batalha=? AND lado=? AND posicao=?",hp,hp==0,hp>0,id,alvo,pos);
        // O golpe do bot já foi anunciado e exibido antes de chamar a resolução.
        if ("JOGADOR".equals(ladoAtacante)) {
            log(id,turno,ordem,nomePokemonNaPosicao(id,"JOGADOR",posicaoAtiva(id,"JOGADOR"))+" usou "+atk.get("NOME_ATAQUE")+"!");
        }
        if(hp==0) {
            String derrotado=nomePokemonNaPosicao(id,alvo,pos);
            log(id,turno,ordem+1,derrotado+" foi derrotado!");
            Integer proximo=jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND hp_atual>0 ORDER BY posicao LIMIT 1",rs->rs.next()?rs.getInt(1):null,id,alvo);
            if(proximo!=null) jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado=? AND posicao=?",id,alvo,proximo);
        }
    }
    private boolean finalizarSeNecessario(Long id,Integer treinadorId) {
        for(String lado:List.of("JOGADOR","BOT")) {
            Integer vivos=jdbc.queryForObject("SELECT COUNT(*) FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND hp_atual>0",Integer.class,id,lado);
            if(vivos!=null&&vivos==0) {
                String resultado="BOT".equals(lado)?"VITORIA":"DERROTA";
                jdbc.update("UPDATE BATALHA SET status=?,resultado=?,finalizada_em=CURRENT_TIMESTAMP WHERE id_batalha=? AND status='EM_ANDAMENTO'",resultado,resultado,id);
                int turno=jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?",Integer.class,id);
                log(id,turno,99,"Batalha encerrada: "+resultado+"!");
                jdbc.update("INSERT INTO PLACAR (resultado,data_hora,id_treinador) VALUES (?,CURRENT_TIMESTAMP,?)",resultado,treinadorId);
                return true;
            }
        }
        return false;
    }
    private Map<String,Object> estado(Long id,Integer treinadorId) {
        Map<String,Object> b=jdbc.queryForMap("SELECT id_batalha,nome_bot,status,turno_atual,resultado,iniciada_em,finalizada_em FROM BATALHA WHERE id_batalha=?",id);
        List<Map<String,Object>> mons=jdbc.queryForList("SELECT bp.lado,bp.posicao,bp.hp_atual,bp.ativo,bp.derrotado,p.id_pokemon,p.nome_pokemon,p.tipo_pokemon,p.vida_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? ORDER BY bp.lado,bp.posicao",id);
        List<Map<String,Object>> logs=jdbc.queryForList("SELECT turno,mensagem,criado_em FROM BATALHA_LOG WHERE id_batalha=? ORDER BY id_log",id);
        return Map.of("batalha",b,"pokemon",mons,"eventos",logs);
    }
    private String nomePokemonAtivo(Long id,String lado) { return jdbc.query("SELECT p.nome_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.ativo=TRUE",rs->rs.next()?rs.getString(1):"Pokémon",id,lado); }
    private String nomePokemonNaPosicao(Long id,String lado,int pos) { return jdbc.query("SELECT p.nome_pokemon FROM BATALHA_POKEMON bp JOIN POKEMON p ON p.id_pokemon=bp.id_pokemon WHERE bp.id_batalha=? AND bp.lado=? AND bp.posicao=?",rs->rs.next()?rs.getString(1):"Pokémon",id,lado,pos); }
    private Integer posicaoAtiva(Long id,String lado) { return jdbc.query("SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE",rs->rs.next()?rs.getInt(1):1,id,lado); }
    private void log(Long id,int turno,int ordem,String mensagem) { jdbc.update("INSERT INTO BATALHA_LOG (id_batalha,turno,ordem_evento,mensagem) VALUES (?,?,?,?)",id,turno,ordem,mensagem); }
    private boolean dono(Long id,Integer treinadorId) { if(treinadorId==null)return false; Integer n=jdbc.query("SELECT COUNT(*) FROM BATALHA WHERE id_batalha=? AND id_treinador=?",rs->{rs.next();return rs.getInt(1);},id,treinadorId);return n>0; }
    private boolean treinadorExiste(Integer id) { if(id==null)return false; Integer n=jdbc.queryForObject("SELECT COUNT(*) FROM TREINADOR WHERE id_treinador=?",Integer.class,id);return n!=null&&n>0; }
    private Integer integer(Object x) { if(x instanceof Number n)return n.intValue();try{return x==null?null:Integer.valueOf(x.toString());}catch(Exception e){return null;} }
}
