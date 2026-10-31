const API = 'http://localhost:8080';
const $ = id => document.getElementById(id);
let trainer = null, catalog = [], team = [], battle = null, eventCursor = 0, busy = false, currentView = 'auth-view', toastTimer;
const field = (obj, ...keys) => { for (const key of keys) if (obj && obj[key] !== undefined && obj[key] !== null) return obj[key]; return undefined; };
const battleId = () => field(battle?.batalha, 'ID_BATALHA', 'id_batalha', 'idBatalha');
const battleStatus = () => field(battle?.batalha, 'STATUS', 'status');
const normName = p => String(field(p,'NOME_POKEMON','nome_pokemon','nomePokemon','nome') || 'Pokémon');
const monId = p => Number(field(p,'ID_POKEMON','id_pokemon','idPokemon'));
const hpNow = p => Number(field(p,'HP_ATUAL','hp_atual','hpAtual') ?? 0);
const hpMax = p => Number(field(p,'VIDA_POKEMON','vida_pokemon','vidaPokemon','hpMaximo') ?? 100);
const side = (p, s) => String(field(p,'LADO','lado') || '') === s;
const active = p => field(p,'ATIVO','ativo') === true;

window.addEventListener('DOMContentLoaded', async () => {
  trainer = loadTrainer();
  await loadCatalog();
  if (trainer?.id) { updateTrainerUI(); showView('hub-view'); } else showView('auth-view');
});
function loadTrainer(){
  const id = Number(sessionStorage.ID_TREINADOR);
  if (!id) return null;
  return {id, name:sessionStorage.NOME_TREINADOR || 'Treinador', avatar:sessionStorage.PERSONAGEM_TREINADOR || 'men_trainer1'};
}
function updateTrainerUI(){ $('trainer-label').textContent = trainer.name; $('hub-trainer-name').textContent = trainer.name; $('logout-btn').classList.remove('hidden'); }
function showView(id){ document.querySelectorAll('.view').forEach(v=>v.classList.add('hidden')); $(id).classList.remove('hidden'); currentView=id; window.scrollTo({top:0,behavior:'smooth'}); }
function showAuth(mode){ const login=mode==='login'; $('login-form').classList.toggle('hidden',!login); $('signup-form').classList.toggle('hidden',login); $('login-tab').classList.toggle('active',login); $('signup-tab').classList.toggle('active',!login); }
function notify(message){ const el=$('toast');el.textContent=message;el.classList.remove('hidden');clearTimeout(toastTimer);toastTimer=setTimeout(()=>el.classList.add('hidden'),3400); }
async function api(path, options={}){
  const response=await fetch(`${API}${path}`,{...options,headers:{...(options.body?{'Content-Type':'application/json'}:{}),...(options.headers||{})}});
  let data=null;try{data=await response.json()}catch{}
  if(!response.ok){throw new Error(field(data||{},'erro','message') || `Falha na API (${response.status})`)}
  return data;
}
async function logar(){
  const nome=$('login-name').value.trim(), senha=$('login-password').value;
  if(!nome||!senha){notify('Informe nome e senha.');return;}
  try{
    const t=await api(`/treinador/${encodeURIComponent(nome)}/${encodeURIComponent(senha)}`);
    trainer={id:Number(field(t,'id_treinador','idTreinador')),name:field(t,'nome_treinador','nomeTreinador')||nome,avatar:field(t,'personagem_treinador','personagemTreinador')||'men_trainer1'};
    persistTrainer();updateTrainerUI();showView('hub-view');notify(`Bem-vindo de volta, ${trainer.name}!`);
  }catch(e){notify(e.message.includes('404')?'Treinador não encontrado. Confira os dados.':e.message.includes('401')?'Senha incorreta.':e.message);}
}
async function cadastrar(){
  const nome=$('signup-name').value.trim(), senha=$('signup-password').value, avatar=document.querySelector('input[name="trainer-avatar"]:checked')?.value;
  if(nome.length<3||senha.length<4||!avatar){notify('Preencha os dados e escolha um avatar.');return;}
  try{
    const t=await api('/treinador/cadastrar',{method:'POST',body:JSON.stringify({nome_treinador:nome,senha_treinador:senha,personagem_treinador:avatar})});
    trainer={id:Number(field(t,'id_treinador','idTreinador')),name:field(t,'nome_treinador','nomeTreinador')||nome,avatar};persistTrainer();updateTrainerUI();await openTeam();notify('Treinador criado! Monte sua equipe de seis Pokémon.');
  }catch(e){notify(e.message);}
}
function persistTrainer(){sessionStorage.ID_TREINADOR=trainer.id;sessionStorage.NOME_TREINADOR=trainer.name;sessionStorage.PERSONAGEM_TREINADOR=trainer.avatar;}
function logout(){if(busy)return;sessionStorage.removeItem('ID_TREINADOR');sessionStorage.removeItem('NOME_TREINADOR');sessionStorage.removeItem('PERSONAGEM_TREINADOR');trainer=null;battle=null;$('logout-btn').classList.add('hidden');$('trainer-label').textContent='Treinador visitante';showView('auth-view');showAuth('login');}
async function loadCatalog(){
  try{catalog=await api('/pokemon/listar');if(!Array.isArray(catalog))catalog=[];}
  catch(e){catalog=[];console.warn('Catálogo indisponível:',e);}
}
function pokemonImage(p,back=false){const name=normName(p).toLowerCase().replaceAll(' ','');const path=`../Assets/pokemons_assets/${name}${back?'_back':''}.png`;return path;}
function openTeam(){if(!trainer){showView('auth-view');return;}return renderTeam();}
async function renderTeam(){
  try{const data=await api(`/api/user/team?treinadorId=${trainer.id}`);team=(field(data,'pokemon')||[]).map(p=>({id:Number(field(p,'IDPOKEMON','idPokemon','id_pokemon')),pos:Number(field(p,'POSICAO','posicao')),golpes:field(p,'golpes')||[]}));}
  catch{team=[];}
  const slots=$('team-grid');slots.innerHTML='';
  for(let i=1;i<=6;i++){
    const chosen=team.find(p=>p.pos===i), card=document.createElement('div');card.className='team-slot';
    card.innerHTML=`<h3>Posição ${i}</h3><img id="team-preview-${i}" src="${chosen?pokemonImage(catalog.find(p=>monId(p)===chosen.id)||{nome_pokemon:'reshiram'}):'../Assets/pixel_pokeball.png'}" alt="Prévia do Pokémon ${i}"><label class="slot-number" for="team-select-${i}">Escolha um Pokémon</label><select id="team-select-${i}" data-slot="${i}"><option value="">Selecione...</option>${catalog.map(p=>`<option value="${monId(p)}" ${chosen&&chosen.id===monId(p)?'selected':''}>${escapeHtml(normName(p))}</option>`).join('')}</select>`;
    slots.appendChild(card);const select=$(`team-select-${i}`);select.addEventListener('change',()=>{const p=catalog.find(x=>monId(x)===Number(select.value));$(`team-preview-${i}`).src=p?pokemonImage(p):'../Assets/pixel_pokeball.png';});
  }
  showView('team-view');
}
async function saveTeam(){
  const ids=Array.from({length:6},(_,i)=>Number($(`team-select-${i+1}`).value));
  if(ids.some(id=>!id)){notify('Escolha um Pokémon em cada uma das seis posições.');return;}
  if(new Set(ids).size!==6){notify('Escolha seis Pokémon diferentes para sua equipe.');return;}
  try{await api(`/api/user/team?treinadorId=${trainer.id}`,{method:'PUT',body:JSON.stringify({pokemon:ids.map((id,i)=>({idPokemon:id,posicao:i+1,golpes:[]}))})});team=ids.map((id,i)=>({id,pos:i+1}));notify('Equipe salva com sucesso!');showView('hub-view');}
  catch(e){notify(e.message);}
}
function openPokedex(){renderPokedex();showView('pokedex-view');}
function renderPokedex(){const grid=$('pokedex-grid');const query=($('pokedex-search').value||'').trim().toLowerCase();const filtered=catalog.filter(p=>`${normName(p)} ${field(p,'tipo_pokemon','tipoPokemon','tipo')||''}`.toLowerCase().includes(query));$('pokedex-count').textContent=`${filtered.length} Pokémon`;grid.innerHTML=filtered.map(p=>`<article class="dex-card"><img src="${pokemonImage(p)}" alt="${escapeHtml(normName(p))}" onerror="this.src='../Assets/pixel_pokeball.png'"><h3>${escapeHtml(normName(p))}</h3><span class="type-tag">${escapeHtml(String(field(p,'tipo_pokemon','tipoPokemon','tipo')||'Tipo desconhecido'))}</span><p>#${field(p,'numero_pokedex','numeroPokedex')??'—'} · ${field(p,'vida_pokemon','vidaPokemon')??'—'} HP</p></article>`).join('')||'<div class="empty-state">Nenhum Pokémon encontrado.</div>';}
function filterPokedex(){renderPokedex();}
async function openLogs(){showView('logs-view');$('logs-list').innerHTML='<div class="empty-state">Carregando histórico...</div>';try{const rows=await api(`/api/battles/history/${trainer.id}`);renderLogs(rows||[]);}catch(e){$('logs-list').innerHTML=`<div class="empty-state">${escapeHtml(e.message)}</div>`;}}
function renderLogs(rows){const list=$('logs-list');if(!rows.length){list.innerHTML='<div class="empty-state">Ainda não há batalhas registradas. Inicie sua primeira batalha!</div>';return;}list.innerHTML=rows.map(b=>{const events=field(b,'eventos')||[];const status=field(b,'RESULTADO','resultado','STATUS','status')||'EM_ANDAMENTO';return `<article class="log-card"><h3>Batalha #${field(b,'ID_BATALHA','id_batalha')} · ${escapeHtml(field(b,'NOME_BOT','nome_bot')||'Adversário')}</h3><p>Resultado: <strong>${escapeHtml(status)}</strong> · Início: ${escapeHtml(String(field(b,'INICIADA_EM','iniciada_em')||'—'))}</p><details><summary>Ver ${events.length} eventos</summary><ol>${events.map(ev=>`<li>Turno ${field(ev,'TURNO','turno')}: ${escapeHtml(field(ev,'MENSAGEM','mensagem')||'')}</li>`).join('')}</ol></details></article>`;}).join('');}
async function openBattle(){if(!trainer)return showView('auth-view');showView('battle-view');$('battle-title').textContent='Preparando batalha...';$('battle-message').textContent='A equipe está entrando no campo...';$('battle-actions').classList.add('hidden');$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.add('hidden');busy=true;try{battle=await api('/api/battles',{method:'POST',body:JSON.stringify({treinadorId:trainer.id})});eventCursor=0;renderBattle(battle);await playNewEvents();if(battleStatus()==='EM_ANDAMENTO')showActions();else await finishBattle();}catch(e){notify(e.message);showView('hub-view');}finally{busy=false;}}
function getMons(){return field(battle,'pokemon')||[];}
function activeMon(which){return getMons().find(p=>side(p,which)&&active(p))||getMons().find(p=>side(p,which));}
function renderBattle(data){battle=data;const b=data.batalha||{};const foe=activeMon('BOT'),player=activeMon('JOGADOR');$('battle-title').textContent=`${trainer.name} vs ${field(b,'NOME_BOT','nome_bot')||'Treinador rival'}`;if(foe)renderStatus('foe',foe,false);if(player)renderStatus('player',player,true);renderBattleTeam();}
function renderStatus(prefix,p,back){const name=normName(p),hp=hpNow(p),max=hpMax(p);$(`${prefix}-name`).textContent=name;$(`${prefix}-hp-text`).textContent=`${hp} / ${max} HP`;$(`${prefix}-hp-bar`).style.width=`${Math.max(0,Math.min(100,max?hp/max*100:0))}%`;$(`${prefix}-hp-bar`).style.background=hp/max<=.2?'#e3350d':hp/max<=.5?'#f3c13a':'#65c75b';$(`${prefix}-sprite`).src=pokemonImage(p,back);$(`${prefix}-sprite`).alt=name;}
function renderBattleTeam(){const grid=$('battle-team-grid');grid.innerHTML='';const mons=getMons().filter(p=>side(p,'JOGADOR')).sort((a,b)=>Number(field(a,'POSICAO','posicao'))-Number(field(b,'POSICAO','posicao')));mons.forEach(p=>{const pos=Number(field(p,'POSICAO','posicao')),hp=hpNow(p),isActive=active(p);const btn=document.createElement('button');btn.className='battle-mon';btn.disabled=busy||hp<=0||isActive;btn.innerHTML=`<img src="${pokemonImage(p)}" alt=""><strong>${escapeHtml(normName(p))}${isActive?' · ATIVO':''}</strong><small>${hp}/${hpMax(p)} HP</small>`;btn.onclick=()=>doPlayerAction({tipo:'TROCAR',posicaoDestino:pos});grid.appendChild(btn);});}
async function playNewEvents(){const events=field(battle,'eventos')||[];for(;eventCursor<events.length;eventCursor++){const ev=events[eventCursor];const message=field(ev,'MENSAGEM','mensagem');if(message)await typeMessage(message);}renderBattle(battle);}
function typeMessage(text){return new Promise(resolve=>{busy=true;setControlsDisabled(true);const el=$('battle-message');el.textContent='';$('dialog-caret').classList.remove('hidden');let i=0;const speed=22;function tick(){if(i<text.length){el.textContent+=text.charAt(i++);setTimeout(tick,speed);}else{busy=false;setControlsDisabled(false);resolve();}}tick();});}
function setControlsDisabled(disabled){document.querySelectorAll('#battle-actions button,#moves-grid button,#battle-team-grid button,#fight-menu>.btn,#battle-team-menu>.btn').forEach(b=>b.disabled=disabled);}
function showActions(){if(battleStatus()!=='EM_ANDAMENTO')return;busy=false;$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.add('hidden');$('battle-actions').classList.remove('hidden');$('fight-btn').disabled=false;$('pokemon-btn').disabled=false;}
function returnActions(){if(busy)return;$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.add('hidden');showActions();}
async function showFight(){if(busy||battleStatus()!=='EM_ANDAMENTO')return;$('battle-actions').classList.add('hidden');$('battle-team-menu').classList.add('hidden');$('fight-menu').classList.remove('hidden');const mon=activeMon('JOGADOR');if(!mon)return;const id=monId(mon);try{const moves=await api(`/pokemon/ataque/${id}`);const grid=$('moves-grid');grid.innerHTML='';(moves||[]).slice(0,4).forEach(move=>{const moveId=Number(field(move,'id_ataque','idAtaque','id'));const name=field(move,'nome_ataque','nomeAtaque','nome')||'Golpe';const type=field(move,'tipo_ataque','tipoAtaque','tipo')||'Normal';const power=field(move,'dano_ataque','danoAtaque','poder')??'?';const btn=document.createElement('button');btn.className='move-btn';btn.innerHTML=`<strong>${escapeHtml(name)}</strong><small>${escapeHtml(type)} · Poder ${power}</small>`;btn.onclick=()=>doPlayerAction({tipo:'ATACAR',idAtaque:moveId});grid.appendChild(btn);});if(!grid.children.length)grid.innerHTML='<p>Este Pokémon não possui golpes disponíveis.</p>';}catch(e){notify(e.message);}}
function showBattleTeam(){if(busy||battleStatus()!=='EM_ANDAMENTO')return;$('battle-actions').classList.add('hidden');$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.remove('hidden');renderBattleTeam();}
async function doPlayerAction(action){if(busy||battleStatus()!=='EM_ANDAMENTO')return;busy=true;$('battle-actions').classList.add('hidden');$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.add('hidden');setControlsDisabled(true);try{
    battle=await api(`/api/battles/${battleId()}/actions`,{method:'POST',body:JSON.stringify({treinadorId:trainer.id,...action})});renderBattle(battle);await playNewEvents();
    if(battleStatus()!=='EM_ANDAMENTO'){await finishBattle();return;}
    // Primeiro apresenta a mensagem de escolha do golpe do adversário; dano só é aplicado depois do typewriter.
    const announce=await api(`/api/battles/${battleId()}/bot-turn/announce`,{method:'POST',body:JSON.stringify({treinadorId:trainer.id})});
    if(announce.mensagem){await typeMessage(announce.mensagem);eventCursor=(field(announce.estado,'eventos')||[]).length;battle=announce.estado;renderBattle(battle);}
    if(battleStatus()==='EM_ANDAMENTO'){
      battle=await api(`/api/battles/${battleId()}/bot-turn/resolve`,{method:'POST',body:JSON.stringify({treinadorId:trainer.id,idAtaque:Number(announce.idAtaque)})});renderBattle(battle);await playNewEvents();
    }
    if(battleStatus()!=='EM_ANDAMENTO'){await finishBattle();return;}showActions();
  }catch(e){notify(e.message);if(battleStatus()==='EM_ANDAMENTO')showActions();}finally{busy=false;setControlsDisabled(false);}}
async function finishBattle(){const result=field(battle?.batalha,'RESULTADO','resultado','STATUS','status')||'FIM DE BATALHA';$('battle-actions').classList.add('hidden');$('fight-menu').classList.add('hidden');$('battle-team-menu').classList.add('hidden');notify(result==='VITORIA'?'Vitória! Você venceu a batalha!':result==='DERROTA'?'Fim de batalha. Você foi derrotado.':`Batalha finalizada: ${result}`);await new Promise(r=>setTimeout(r,1800));battle=null;await openLogsAfterBattle();}
async function openLogsAfterBattle(){showView('hub-view');notify('Retornando ao hub do treinador...');}
function leaveBattle(){if(busy)return;battle=null;showView('hub-view');}
function escapeHtml(value){return String(value??'').replace(/[&<>"']/g,ch=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[ch]));}
