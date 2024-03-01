CREATE TABLE players (
  id_player int NOT NULL,
  player_name varchar(128),
  PRIMARY KEY (id_player)
);

CREATE TABLE are_friend (
  id_player1 int,
  id_player2 int,
  date_friendship date,
  PRIMARY KEY (id_player1, id_player2),
  FOREIGN KEY (id_player1) REFERENCES players(id_player),
  FOREIGN KEY (id_player2) REFERENCES players(id_player)
);