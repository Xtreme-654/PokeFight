CREATE TABLE TREINADOR (
    id_treinador INT AUTO_INCREMENT PRIMARY KEY,
    nome_treinador VARCHAR(255) NOT NULL,
    senha_treinador VARCHAR(255) NOT NULL,
    personagem_treinador VARCHAR(255) NOT NULL
);

CREATE TABLE POKEMON (
    id_pokemon INT AUTO_INCREMENT PRIMARY KEY,
    nome_pokemon VARCHAR(255) NOT NULL,
    numero_pokedex INT UNIQUE,
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
id_pokemon_ataque INT AUTO_INCREMENT,
    id_pokemon INT NOT NULL,
    id_ataque INT NOT NULL,
    PRIMARY KEY (id_pokemon_ataque, id_pokemon, id_ataque),
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

 INSERT INTO ATAQUE (nome_ataque, tipo_ataque, dano_ataque) VALUES
 ('Blue Flare', 'Fire', 130),
 ('Flare Blitz', 'Fire', 120),
 ('Scald', 'Water', 80),
 ('Aqua Tail', 'Water', 90),
 ('Leaf Tornado', 'Grass', 65),
 ('Energy Ball', 'Grass', 90),
 ('Bolt Strike', 'Electric', 130),
 ('Discharge', 'Electric', 80),
 ('Icicle Crash', 'Ice', 85),
 ('Avalanche', 'Ice', 60),
 ('Sacred Sword', 'Fighting', 90),
 ('Close Combat', 'Fighting', 120),
 ('Psystrike', 'Psychic', 100),
 ('Zen Headbutt', 'Psychic', 80),
 ('Foul Play', 'Dark', 95),
 ('Night Slash', 'Dark', 70),
 ('Hex', 'Ghost', 65),
 ('Shadow Claw', 'Ghost', 70),
 ('Dragon Tail', 'Dragon', 60),
 ('Dragon Pulse', 'Dragon', 85),
 ('Gear Grind', 'Steel', 50),
 ('Flash Cannon', 'Steel', 80),
 ('Smack Down', 'Rock', 50),
 ('Stone Edge', 'Rock', 100),
 ('Bulldoze', 'Ground', 60),
 ('Earth Power', 'Ground', 90),
 ('Steamroller', 'Bug', 65),
 ('X-Scissor', 'Bug', 80),
 ('Venoshock', 'Poison', 65),
 ('Poison Jab', 'Poison', 80),
 ('Acrobatics', 'Flying', 55),
 ('Brave Bird', 'Flying', 120),
 ('Chip Away', 'Normal', 70),
 ('Giga Impact', 'Normal', 150),
('Body Slam', 'Normal', 85),
('Hyper Beam', 'Normal', 150),
('Double-Edge', 'Normal', 120),
('Return', 'Normal', 102);

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Serperior'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Serperior'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Serperior'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Serperior'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emboar'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flare Blitz')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emboar'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emboar'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emboar'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Samurott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Samurott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Samurott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Samurott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Watchog'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Chip Away')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Watchog'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Watchog'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Watchog'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stoutland'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Body Slam')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stoutland'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Giga Impact')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stoutland'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stoutland'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Liepard'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Foul Play')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Liepard'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Liepard'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Liepard'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisage'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisage'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisage'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisage'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisear'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flare Blitz')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisear'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisear'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simisear'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simipour'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simipour'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simipour'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Simipour'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Musharna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Musharna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Musharna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Musharna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Unfezant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Unfezant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Giga Impact')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Unfezant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Unfezant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zebstrika'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Discharge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zebstrika'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bolt Strike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zebstrika'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zebstrika'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gigalith'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gigalith'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Smack Down')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gigalith'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gigalith'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swoobat'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swoobat'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swoobat'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swoobat'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Excadrill'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Excadrill'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bulldoze')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Excadrill'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Excadrill'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Audino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Audino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Body Slam')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Audino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Audino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Conkeldurr'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Conkeldurr'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Sacred Sword')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Conkeldurr'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Conkeldurr'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Seismitoad'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Seismitoad'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Seismitoad'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Seismitoad'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Throh'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Throh'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Sacred Sword')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Throh'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Throh'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Body Slam'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Sacred Sword')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Leavanny'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Leavanny'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Leavanny'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Leavanny'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scolipede'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scolipede'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scolipede'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scolipede'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Whimsicott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Whimsicott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Whimsicott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Whimsicott'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Lilligant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Lilligant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Lilligant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Lilligant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Basculin'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Basculin'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Basculin'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Basculin'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Krookodile'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Krookodile'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bulldoze')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Krookodile'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Krookodile'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Darmanitan'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flare Blitz')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Darmanitan'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Darmanitan'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Darmanitan'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Maractus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Maractus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Maractus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Maractus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Poison Jab'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Crustle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Crustle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Crustle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Crustle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scrafty'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Foul Play')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scrafty'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scrafty'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Scrafty'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sigilyph'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sigilyph'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sigilyph'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sigilyph'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cofagrigus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cofagrigus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cofagrigus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cofagrigus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Carracosta'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Carracosta'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Carracosta'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Carracosta'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Archeops'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Archeops'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Smack Down')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Archeops'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Archeops'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Garbodor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Poison Jab')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Garbodor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Venoshock')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Garbodor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Garbodor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zoroark'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Foul Play')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zoroark'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zoroark'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Zoroark'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cinccino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cinccino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cinccino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cinccino'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gothitelle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gothitelle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gothitelle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Gothitelle'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Reuniclus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Reuniclus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Reuniclus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Reuniclus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swanna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swanna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swanna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Swanna'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Vanilluxe'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Icicle Crash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Vanilluxe'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Avalanche')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Vanilluxe'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Vanilluxe'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawsbuck'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawsbuck'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawsbuck'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Sawsbuck'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emolga'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Discharge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emolga'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bolt Strike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emolga'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Emolga'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Escavalier'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Escavalier'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Escavalier'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Escavalier'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flash Cannon'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Amoonguss'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Amoonguss'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Amoonguss'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Amoonguss'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Poison Jab'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Jellicent'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Jellicent'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Jellicent'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Jellicent'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Alomomola'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Scald')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Alomomola'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Aqua Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Alomomola'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Alomomola'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Body Slam'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Galvantula'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Galvantula'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Galvantula'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Galvantula'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Discharge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Ferrothorn'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Energy Ball')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Ferrothorn'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Leaf Tornado')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Ferrothorn'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Ferrothorn'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flash Cannon'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Klinklang'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flash Cannon')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Klinklang'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Gear Grind')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Klinklang'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Klinklang'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Eelektross'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bolt Strike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Eelektross'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Discharge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Eelektross'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Eelektross'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flash Cannon'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beheeyem'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Psystrike')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beheeyem'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Zen Headbutt')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beheeyem'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beheeyem'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Chandelure'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Shadow Claw')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Chandelure'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Hex')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Chandelure'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Chandelure'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Haxorus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Pulse')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Haxorus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Haxorus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Haxorus'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beartic'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Icicle Crash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beartic'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Avalanche')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beartic'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Beartic'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cryogonal'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Icicle Crash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cryogonal'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Avalanche')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cryogonal'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Cryogonal'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Accelgor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Accelgor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Accelgor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Accelgor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stunfisk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bulldoze')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stunfisk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stunfisk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Stunfisk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mienshao'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mienshao'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Sacred Sword')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mienshao'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mienshao'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Acrobatics'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Druddigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Pulse')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Druddigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Druddigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Druddigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Golurk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Earth Power')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Golurk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Bulldoze')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Golurk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Golurk'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bisharp'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Foul Play')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bisharp'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bisharp'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bisharp'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bouffalant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Double-Edge')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bouffalant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Giga Impact')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bouffalant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Bouffalant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Close Combat'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Braviary'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Braviary'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Giga Impact')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Braviary'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Braviary'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mandibuzz'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Foul Play')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mandibuzz'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Night Slash')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mandibuzz'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Mandibuzz'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Brave Bird'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Heatmor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flare Blitz')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Heatmor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Heatmor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Heatmor'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Poison Jab'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Durant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Durant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Durant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Durant'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Stone Edge'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Hydreigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Pulse')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Hydreigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Dragon Tail')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Hydreigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Hydreigon'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Flash Cannon'));

INSERT INTO POKEMON_ATAQUE (id_pokemon, id_ataque) VALUES
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Volcarona'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='X-Scissor')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Volcarona'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Steamroller')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Volcarona'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Blue Flare')),
  ((SELECT id_pokemon FROM POKEMON WHERE nome_pokemon='Volcarona'), (SELECT id_ataque FROM ATAQUE WHERE nome_ataque='Return'));


-- PokePath: equipe ordenada, golpes equipados e estado persistido das batalhas.
-- Os números da Pokédex são atribuídos por nome, nunca pelo ID interno do banco.
UPDATE POKEMON SET numero_pokedex = CASE nome_pokemon
 WHEN 'Serperior' THEN 497 WHEN 'Emboar' THEN 500 WHEN 'Samurott' THEN 503
 WHEN 'Watchog' THEN 505 WHEN 'Stoutland' THEN 508 WHEN 'Liepard' THEN 510
 WHEN 'Simisage' THEN 512 WHEN 'Simisear' THEN 514 WHEN 'Simipour' THEN 516
 WHEN 'Musharna' THEN 518 WHEN 'Unfezant' THEN 521 WHEN 'Zebstrika' THEN 523
 WHEN 'Gigalith' THEN 526 WHEN 'Swoobat' THEN 528 WHEN 'Excadrill' THEN 530
 WHEN 'Audino' THEN 531 WHEN 'Conkeldurr' THEN 534 WHEN 'Seismitoad' THEN 537
 WHEN 'Throh' THEN 538 WHEN 'Sawk' THEN 539 WHEN 'Leavanny' THEN 542
 WHEN 'Scolipede' THEN 545 WHEN 'Whimsicott' THEN 547 WHEN 'Lilligant' THEN 549
 WHEN 'Basculin' THEN 550 WHEN 'Krookodile' THEN 553 WHEN 'Darmanitan' THEN 555
 WHEN 'Maractus' THEN 556 WHEN 'Crustle' THEN 558 WHEN 'Scrafty' THEN 560
 WHEN 'Sigilyph' THEN 561 WHEN 'Cofagrigus' THEN 563 WHEN 'Carracosta' THEN 565
 WHEN 'Archeops' THEN 567 WHEN 'Garbodor' THEN 569 WHEN 'Zoroark' THEN 571
 WHEN 'Cinccino' THEN 573 WHEN 'Gothitelle' THEN 576 WHEN 'Reuniclus' THEN 579
 WHEN 'Swanna' THEN 581 WHEN 'Vanilluxe' THEN 584 WHEN 'Sawsbuck' THEN 586
 WHEN 'Emolga' THEN 587 WHEN 'Escavalier' THEN 589 WHEN 'Amoonguss' THEN 591
 WHEN 'Jellicent' THEN 593 WHEN 'Alomomola' THEN 594 WHEN 'Galvantula' THEN 596
 WHEN 'Ferrothorn' THEN 598 WHEN 'Klinklang' THEN 601 WHEN 'Eelektross' THEN 604
 WHEN 'Beheeyem' THEN 606 WHEN 'Chandelure' THEN 609 WHEN 'Haxorus' THEN 612
 WHEN 'Beartic' THEN 614 WHEN 'Cryogonal' THEN 615 WHEN 'Accelgor' THEN 617
 WHEN 'Stunfisk' THEN 618 WHEN 'Mienshao' THEN 620 WHEN 'Druddigon' THEN 621
 WHEN 'Golurk' THEN 623 WHEN 'Bisharp' THEN 625 WHEN 'Bouffalant' THEN 626
 WHEN 'Braviary' THEN 628 WHEN 'Mandibuzz' THEN 630 WHEN 'Heatmor' THEN 631
 WHEN 'Durant' THEN 632 WHEN 'Hydreigon' THEN 635 WHEN 'Volcarona' THEN 637
 ELSE NULL END;

CREATE TABLE EQUIPE_TREINADOR (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    id_treinador INT NOT NULL,
    id_pokemon INT NOT NULL,
    posicao INT NOT NULL,
    CONSTRAINT uq_equipe_posicao UNIQUE (id_treinador, posicao),
    CONSTRAINT ck_equipe_posicao CHECK (posicao BETWEEN 1 AND 6),
    CONSTRAINT fk_equipe_treinador FOREIGN KEY (id_treinador) REFERENCES TREINADOR(id_treinador) ON DELETE CASCADE,
    CONSTRAINT fk_equipe_pokemon FOREIGN KEY (id_pokemon) REFERENCES POKEMON(id_pokemon)
);

CREATE TABLE EQUIPE_POKEMON_ATAQUE (
    id_equipe INT NOT NULL,
    id_ataque INT NOT NULL,
    slot_ataque INT NOT NULL,
    PRIMARY KEY (id_equipe, slot_ataque),
    CONSTRAINT ck_slot_ataque CHECK (slot_ataque BETWEEN 1 AND 4),
    CONSTRAINT fk_epa_equipe FOREIGN KEY (id_equipe) REFERENCES EQUIPE_TREINADOR(id_equipe) ON DELETE CASCADE,
    CONSTRAINT fk_epa_ataque FOREIGN KEY (id_ataque) REFERENCES ATAQUE(id_ataque)
);

CREATE TABLE BATALHA (
    id_batalha BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_treinador INT NOT NULL,
    nome_bot VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'EM_ANDAMENTO',
    turno_atual INT NOT NULL DEFAULT 1,
    resultado VARCHAR(20),
    iniciada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finalizada_em TIMESTAMP,
    CONSTRAINT ck_batalha_status CHECK (status IN ('EM_ANDAMENTO','VITORIA','DERROTA','CANCELADA')) ,
    CONSTRAINT fk_batalha_treinador FOREIGN KEY (id_treinador) REFERENCES TREINADOR(id_treinador) ON DELETE CASCADE
);

CREATE TABLE BATALHA_POKEMON (
    id_batalha BIGINT NOT NULL,
    lado VARCHAR(10) NOT NULL,
    posicao INT NOT NULL,
    id_pokemon INT NOT NULL,
    hp_atual INT NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT FALSE,
    derrotado BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_batalha, lado, posicao),
    CONSTRAINT ck_bp_lado CHECK (lado IN ('JOGADOR','BOT')),
    CONSTRAINT ck_bp_posicao CHECK (posicao BETWEEN 1 AND 6),
    CONSTRAINT ck_bp_hp CHECK (hp_atual >= 0),
    CONSTRAINT fk_bp_batalha FOREIGN KEY (id_batalha) REFERENCES BATALHA(id_batalha) ON DELETE CASCADE,
    CONSTRAINT fk_bp_pokemon FOREIGN KEY (id_pokemon) REFERENCES POKEMON(id_pokemon)
);

CREATE TABLE BATALHA_LOG (
    id_log BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_batalha BIGINT NOT NULL,
    turno INT NOT NULL,
    ordem_evento INT NOT NULL,
    mensagem VARCHAR(500) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_log_batalha FOREIGN KEY (id_batalha) REFERENCES BATALHA(id_batalha) ON DELETE CASCADE
);


INSERT INTO TREINADOR (nome_treinador, senha_treinador, personagem_treinador) VALUES
('xtreme-dosamba', 'pinto123', 'men_trainer1')