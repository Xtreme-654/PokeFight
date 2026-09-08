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
