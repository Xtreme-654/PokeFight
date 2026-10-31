# PokeFight
Interface web estilizada em pixel art para o jogo de batalhas PokéFight, integrada com uma API REST em Java/Spring Boot. O projeto simula a experiência de jogos clássicos como Pokémon (GBA), permitindo login de treinadores, montagem de times e batalhas em tempo real.

🚀 Funcionalidades
Autenticação de Treinador: Tela de login e cadastro com salvamento do perfil e escolha do sprite do avatar (fem_trainer ou men_trainer).

Montagem de Time: Seleção de 3 Pokémons iniciais a partir do catálogo retornado pela API, com visualização dinâmica em tempo real.

Arena de Batalha:

Exibição de dados do treinador e histórico da última partida realizada.

Visualização de Pokémons no campo (sprites do jogador e do oponente).

Painel de seleção de até 4 ataques com cálculo de dano e atualização de vida em tempo real.

Mecânica de troca de Pokémons durante o combate.

Registro automático do resultado da partida no banco de dados após a vitória.

🛠️ Tecnologias Utilizadas
Tecnologia	Descrição
HTML5	Estruturação das telas, painéis de combate e formulários
CSS3	Estilização personalizada, posicionamento Flexbox e tipografia estilo retro
JavaScript (ES6+)	Manipulação da DOM, gerenciamento de estado via sessionStorage e requisições HTTP
Fetch API	Comunicação assíncrona com o backend Spring Boot
Google Fonts	Tipografia Pixelify Sans para ambientação pixel art
📂 Estrutura de Arquivos
Plaintext
frontend/
├── Assets/
│   ├── pokemons_assets/      # Sprites dos Pokémons (front e back)
│   ├── pixel_pokeball.png    # Ícones da interface
│   ├── pokefight-logo.png    # Logos do projeto
│   └── backgroundbattle2.png # Fundo da arena de batalha
├── CSS/
│   └── Main.css              # Estilização geral e regras do layout
└── HTML/
    └── Main.html             # Estrutura e scripts de integração
🔗 Integração com a API
Endpoints consumidos pelo frontend (http://localhost:8080):

Método	Endpoint	Função
GET	/treinador/{nome}/{senha}	Autenticar usuário
POST	/treinador/cadastrar	Registrar novo treinador
GET	/treinador/{nome}	Buscar ID do treinador cadastrado
GET	/pokemon/listar	Carregar catálogo de Pokémons para o select
POST	/Inventario/cadastrar	Salvar o time inicial de 3 Pokémons
GET	/Inventario/primeiro/{id}	Buscar o primeiro Pokémon do time para iniciar a batalha
GET	/Inventario/{id}	Listar todos os Pokémons do inventário do jogador
GET	/pokemon/ataque/{id}	Listar os ataques disponíveis do Pokémon ativo
POST	/treinador/placar	Registrar o resultado da partida (Vitória/Derrota)
GET	/treinador/verUltimoPlacar/{id}	Buscar a data e o resultado do último combate
⚙️ Como Executar
Certifique-se de que a API Java (backend) esteja rodando na porta 8080.

Abra o arquivo Main.html utilizando a extensão Live Server no VS Code ou qualquer servidor HTTP local para evitar bloqueios de CORS.An game that's actually an API test
