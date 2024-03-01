CREATE TABLE entities (
  id_entity int PRIMARY KEY NOT NULL,
  name_entity varchar(128),
  address varchar(128)
);

CREATE TABLE platforms (
  id_platform int PRIMARY KEY NOT NULL,
  label varchar(32)
);

CREATE TABLE tags (
  id_tag int PRIMARY KEY NOT NULL,
  label varchar(32)
);

CREATE TABLE languages (
  id_language int PRIMARY KEY NOT NULL,
  language varchar(32)
);

CREATE TABLE games (
  id_game int NOT NULL,
  name_game varchar(128),
  price int,
  release_date date,
  sales int,
  editor int,
  developper int,
  FOREIGN KEY (editor) REFERENCES entities(id_entity),
  FOREIGN KEY (developper) REFERENCES entities(id_entity),
  PRIMARY KEY (id_game)
);

CREATE TABLE support (
  id_game int,
  id_platform int,
  PRIMARY KEY (id_game, id_platform),
  FOREIGN KEY (id_game) REFERENCES games(id_game),
  FOREIGN KEY (id_platform) REFERENCES platforms(id_platform)
);

CREATE TABLE translate (
  id_game int,
  id_language int,
  PRIMARY KEY (id_game, id_language),
  FOREIGN KEY (id_game) REFERENCES games(id_game),
  FOREIGN KEY (id_language) REFERENCES languages(id_language)
);

CREATE TABLE tagged (
  id_game int,
  id_tag int,
  PRIMARY KEY (id_game, id_tag),
  FOREIGN KEY (id_game) REFERENCES games(id_game),
  FOREIGN KEY (id_tag) REFERENCES tags(id_tag)
);