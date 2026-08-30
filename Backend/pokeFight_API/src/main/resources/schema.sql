CREATE TABLE TREINADOR (
    id_treinador INT AUTO_INCREMENT PRIMARY KEY,
    nome_treinador VARCHAR(255) NOT NULL,
    senha_treinador VARCHAR(255) NOT NULL,
    personagem_treinador VARCHAR(255) NOT NULL
);

CREATE TABLE POKEMON (
    id_pokemon INT AUTO_INCREMENT PRIMARY KEY,
    nome_pokemon VARCHAR(255) NOT NULL,
    tipo_pokemon VARCHAR(100) NOT NULL,
    vida_pokemon INT NOT NULL,
    fraqueza_pokemon VARCHAR(100) NOT NULL
);

CREATE TABLE ATAQUE (
    id_ataque INT AUTO_INCREMENT PRIMARY KEY,
    nome_ataque VARCHAR(255) NOT NULL,
    tipo_ataque VARCHAR(100) NOT NULL,
    dano_ataque INT NOT NULL
);

CREATE TABLE STATUS (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    derrotas INT NOT NULL DEFAULT 0,
    vitorias INT NOT NULL DEFAULT 0,
    id_treinador INT NOT NULL,
    CONSTRAINT fk_status_treinador FOREIGN KEY (id_treinador) REFERENCES TREINADOR(id_treinador) ON DELETE CASCADE
);

CREATE TABLE PLACAR (
    id_placar INT AUTO_INCREMENT PRIMARY KEY,
    resultado VARCHAR(225) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    id_treinador INT NOT NULL,
    CONSTRAINT fk_placar_treinador FOREIGN KEY (id_treinador) REFERENCES TREINADOR(id_treinador) ON DELETE CASCADE
);

CREATE TABLE INVENTARIO (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_treinador INT,
    id_pokemon INT,
    FOREIGN KEY (id_treinador) REFERENCES TREINADOR(id_treinador),
    FOREIGN KEY (id_pokemon) REFERENCES POKEMON(id_pokemon)
);


CREATE TABLE POKEMON_ATAQUE (
    id_pokemon INT NOT NULL,
    id_ataque INT NOT NULL,
    PRIMARY KEY (id_pokemon, id_ataque),
    CONSTRAINT fk_pokematq_pokemon FOREIGN KEY (id_pokemon) REFERENCES POKEMON(id_pokemon) ON DELETE CASCADE,
    CONSTRAINT fk_pokematq_ataque FOREIGN KEY (id_ataque) REFERENCES ATAQUE(id_ataque) ON DELETE CASCADE
);

INSERT INTO POKEMON (nome_pokemon, tipo_pokemon, fraqueza_pokemon, vida_pokemon)
VALUES ('Serperior', 'Grass', 'Fire', 75),
 ('Emboar', 'Fire', 'Water', 110),
 ('Samurott', 'Water', 'Electric', 95),
 ('Watchog', 'Normal', 'Fighting', 70),
 ('Stoutland', 'Normal', 'Fighting', 85),
 ('Liepard', 'Dark', 'Fighting', 65),
 ('Simisage', 'Grass', 'Fire', 80),
 ('Simisear', 'Fire', 'Water', 80),
 ('Simipour', 'Water', 'Electric', 80),
 ('Musharna', 'Psychic', 'Bug', 110),
 ('Unfezant', 'Normal', 'Fighting', 80),
 ('Zebstrika', 'Electric', 'Ground', 75),
 ('Gigalith', 'Rock', 'Water', 85),
 ('Swoobat', 'Psychic', 'Bug', 67),
 ('Excadrill', 'Ground', 'Water', 110),
 ('Audino', 'Normal', 'Fighting', 103),
 ('Conkeldurr', 'Fighting', 'Psychic', 105),
 ('Seismitoad', 'Water', 'Grass', 105),
 ('Throh', 'Fighting', 'Psychic', 120),
 ('Sawk', 'Fighting', 'Psychic', 75),
 ('Leavanny', 'Bug', 'Fire', 75),
 ('Scolipede', 'Bug', 'Fire', 80),
 ('Whimsicott', 'Grass', 'Fire', 60),
 ('Lilligant', 'Grass', 'Fire', 70),
 ('Basculin', 'Water', 'Electric', 70),
 ('Krookodile', 'Ground', 'Water', 95),
 ('Darmanitan', 'Fire', 'Water', 105),
 ('Maractus', 'Grass', 'Fire', 75),
 ('Crustle', 'Bug', 'Water', 70),
 ('Scrafty', 'Dark', 'Fighting', 90),
 ('Sigilyph', 'Psychic', 'Bug', 72),
 ('Cofagrigus', 'Ghost', 'Dark', 58),
 ('Carracosta', 'Water', 'Grass', 74),
 ('Archeops', 'Rock', 'Water', 75),
 ('Garbodor', 'Poison', 'Psychic', 80),
 ('Zoroark', 'Dark', 'Fighting', 60),
 ('Cinccino', 'Normal', 'Fighting', 75),
 ('Gothitelle', 'Psychic', 'Bug', 70),
 ('Reuniclus', 'Psychic', 'Bug', 110),
 ('Swanna', 'Water', 'Electric', 75),
 ('Vanilluxe', 'Ice', 'Fire', 71),
 ('Sawsbuck', 'Normal', 'Fighting', 80),
 ('Emolga', 'Electric', 'Ground', 55),
 ('Escavalier', 'Bug', 'Fire', 70),
 ('Amoonguss', 'Grass', 'Fire', 114),
 ('Jellicent', 'Water', 'Electric', 100),
 ('Alomomola', 'Water', 'Electric', 165),
 ('Galvantula', 'Bug', 'Fire', 70),
 ('Ferrothorn', 'Grass', 'Fire', 74),
 ('Klinklang', 'Steel', 'Fire', 60),
 ('Eelektross', 'Electric', 'Ground', 85),
 ('Beheeyem', 'Psychic', 'Bug', 75),
 ('Chandelure', 'Ghost', 'Water', 60),
 ('Haxorus', 'Dragon', 'Ice', 76),
 ('Beartic', 'Ice', 'Fire', 95),
 ('Cryogonal', 'Ice', 'Fire', 80),
 ('Accelgor', 'Bug', 'Fire', 80),
 ('Stunfisk', 'Ground', 'Water', 109),
 ('Mienshao', 'Fighting', 'Flying', 65),
 ('Druddigon', 'Dragon', 'Ice', 77),
 ('Golurk', 'Ground', 'Water', 89),
 ('Bisharp', 'Dark', 'Fire', 65),
 ('Bouffalant', 'Normal', 'Fighting', 95),
 ('Braviary', 'Normal', 'Rock', 100),
 ('Mandibuzz', 'Dark', 'Electric', 110),
 ('Heatmor', 'Fire', 'Water', 85),
 ('Durant', 'Bug', 'Fire', 58),
 ('Hydreigon', 'Dragon', 'Ice', 92),
 ('Volcarona', 'Bug', 'Water', 85);