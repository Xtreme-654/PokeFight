package sptech.school.pokeFight_API;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/** Motor inicial de combate persistente. Dano simplificado; autenticação deve ser conectada antes de produção. */
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
        Collections.shuffle(candidatos, random);
        List<Map<String,Object>> bot = new ArrayList<>(candidatos.subList(0, Math.min(6,candidatos.size())));
        while(bot.size()<6) bot.add(candidatos.get(random.nextInt(candidatos.size())));
        String nomeBot=NOMES_BOT[random.nextInt(NOMES_BOT.length)];
        jdbc.update("INSERT INTO BATALHA (id_treinador,nome_bot,status,turno_atual) VALUES (?,?,'EM_ANDAMENTO',1)", treinadorId,nomeBot);
        Long id=jdbc.queryForObject("SELECT MAX(id_batalha) FROM BATALHA WHERE id_treinador=?", Long.class, treinadorId);
        for(int i=0;i<6;i++) {
            Map<String,Object> p=equipe.get(i);
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'JOGADOR',?,?,?,?)",id,i+1,p.get("ID_POKEMON"),p.get("VIDA_POKEMON"),i==0);
            Map<String,Object> b=bot.get(i);
            jdbc.update("INSERT INTO BATALHA_POKEMON (id_batalha,lado,posicao,id_pokemon,hp_atual,ativo) VALUES (?,'BOT',?,?,?,?)",id,i+1,b.get("ID_POKEMON"),b.get("VIDA_POKEMON"),i==0);
        }
        log(id,1,1,"A batalha começou! " + nomeBot + " desafiou você.");
        return ResponseEntity.status(201).body(estado(id,treinadorId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> obter(@PathVariable Long id, @RequestParam Integer treinadorId) {
        if (!dono(id,treinadorId)) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(estado(id,treinadorId));
    }

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
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=FALSE WHERE id_batalha=? AND lado='JOGADOR'",id);
            jdbc.update("UPDATE BATALHA_POKEMON SET ativo=TRUE WHERE id_batalha=? AND lado='JOGADOR' AND posicao=?",id,pos);
            log(id,turno,1,"Você chamou seu Pokémon da posição " + pos + ".");
        } else if("ATACAR".equalsIgnoreCase(tipo)) {
            Integer ataqueId=integer(body.get("idAtaque"));
            if(ataqueId==null) return ResponseEntity.badRequest().body(Map.of("erro","idAtaque obrigatório."));
            Integer equipeId=jdbc.query("SELECT e.id_equipe FROM EQUIPE_TREINADOR e JOIN BATALHA b ON b.id_treinador=e.id_treinador WHERE b.id_batalha=? AND e.posicao=(SELECT posicao FROM BATALHA_POKEMON WHERE id_batalha=? AND lado='JOGADOR' AND ativo=TRUE)",rs->rs.next()?rs.getInt(1):null,id,id);
            Integer permitido= jdbc.query("SELECT COUNT(*) FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='JOGADOR' AND bp.ativo=TRUE AND pa.id_ataque=?",rs->{rs.next();return rs.getInt(1);},id,ataqueId);
            if(permitido==0) return ResponseEntity.badRequest().body(Map.of("erro","Golpe não permitido para o Pokémon ativo."));
            executarGolpe(id,"JOGADOR",ataqueId,turno,1);
        } else return ResponseEntity.badRequest().body(Map.of("erro","Tipo deve ser ATACAR ou TROCAR."));

        if(finalizarSeNecessario(id,treinadorId)) return ResponseEntity.ok(estado(id,treinadorId));
        // Bot responde com um golpe real associado ao Pokémon ativo.
        Integer ataqueBot=jdbc.query("SELECT pa.id_ataque FROM POKEMON_ATAQUE pa JOIN BATALHA_POKEMON bp ON bp.id_pokemon=pa.id_pokemon WHERE bp.id_batalha=? AND bp.lado='BOT' AND bp.ativo=TRUE AND bp.hp_atual>0 ORDER BY pa.id_ataque",rs->{List<Integer> a=new ArrayList<>();while(rs.next())a.add(rs.getInt(1));return a.isEmpty()?null:a.get(random.nextInt(a.size()));},id);
        if(ataqueBot!=null) executarGolpe(id,"BOT",ataqueBot,turno,2);
        finalizarSeNecessario(id,treinadorId);
        jdbc.update("UPDATE BATALHA SET turno_atual=turno_atual+1 WHERE id_batalha=? AND status='EM_ANDAMENTO'",id);
        return ResponseEntity.ok(estado(id,treinadorId));
    }

    private void executarGolpe(Long id,String ladoAtacante,Integer ataqueId,int turno,int ordem) {
        Map<String,Object> atk=jdbc.queryForMap("SELECT nome_ataque,dano_ataque FROM ATAQUE WHERE id_ataque=?",ataqueId);
        String alvo="JOGADOR".equals(ladoAtacante)?"BOT":"JOGADOR";
        Map<String,Object> alvoP=jdbc.queryForMap("SELECT posicao,id_pokemon,hp_atual FROM BATALHA_POKEMON WHERE id_batalha=? AND lado=? AND ativo=TRUE",id,alvo);
        int hp=Math.max(0,((Number)alvoP.get("HP_ATUAL")).intValue()-((Number)atk.get("DANO_ATAQUE")).intValue());
        int pos=((Number)alvoP.get("POSICAO")).intValue();
        jdbc.update("UPDATE BATALHA_POKEMON SET hp_atual=?,derrotado=?,ativo=? WHERE id_batalha=? AND lado=? AND posicao=?",hp,hp==0,hp>0,id,alvo,pos);
        log(id,turno,ordem,("JOGADOR".equals(ladoAtacante)?"Seu Pokémon":"O Pokémon do Bot")+" usou "+atk.get("NOME_ATAQUE")+"! Causou "+(atk.get("DANO_ATAQUE"))+" de dano.");
        if(hp==0) {
            log(id,turno,ordem+1,"O Pokémon da posição "+pos+" foi derrotado.");
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
                log(id,((Number)jdbc.queryForObject("SELECT turno_atual FROM BATALHA WHERE id_batalha=?",Integer.class,id)).intValue(),99,"Fim de batalha: "+resultado+".");
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
    private void log(Long id,int turno,int ordem,String mensagem) { jdbc.update("INSERT INTO BATALHA_LOG (id_batalha,turno,ordem_evento,mensagem) VALUES (?,?,?,?)",id,turno,ordem,mensagem); }
    private boolean dono(Long id,Integer treinadorId) { if(treinadorId==null)return false; Integer n=jdbc.query("SELECT COUNT(*) FROM BATALHA WHERE id_batalha=? AND id_treinador=?",rs->{rs.next();return rs.getInt(1);},id,treinadorId);return n>0; }
    private Integer integer(Object x) { if(x instanceof Number n)return n.intValue();try{return x==null?null:Integer.valueOf(x.toString());}catch(Exception e){return null;} }
}
