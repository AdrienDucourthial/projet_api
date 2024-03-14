CREATE DATABASE db_games;
CREATE DATABASE db_players;

CREATE TABLE rating (
  id_player int FOREIGN KEY REFERENCES players(id_player),
  id_game int FOREIGN KEY REFERENCES games(id_game),
  note int,
  PRIMARY KEY (id_player, id_game)
);


CREATE TABLE play (
  id_player int FOREIGN KEY REFERENCES players(id_player),
  id_game int FOREIGN KEY REFERENCES games(id_game),
  id_platform int FOREIGN KEY REFERENCES platform(id_platform),
  date_purchase date,
  time_play timestamp
  PRIMARY KEY (id_player, id_game, id_platform)
);