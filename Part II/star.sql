DROP TABLE IF EXISTS fact;
DROP TABLE IF EXISTS d_tempo;
DROP TABLE IF EXISTS d_meio;
DROP TABLE IF EXISTS d_evento;

CREATE TABLE d_evento(
  idEvento SERIAL NOT NULL ,
  numTelefone INT NOT NULL,
  instanteChamada TIMESTAMP NOT NULL,
  PRIMARY KEY (idEvento)
);
    
CREATE TABLE d_meio(
  idMeio SERIAL NOT NULL ,
  numMeio INT NOT NULL,
  nomeMeio VARCHAR(255) NOT NULL,
  nomeEntidade VARCHAR(255) NOT NULL,
  tipo VARCHAR(255) NOT NULL,
  PRIMARY KEY (idMeio)

);

CREATE TABLE d_tempo (
  idTempo SERIAL NOT NULL ,
  dia INT NOT NULL,
  mes INT NOT NULL,
  ano INT NOT NULL,
  PRIMARY KEY (idTempo)
);

CREATE TABLE fact (
    idxFact SERIAL NOT NULL ,
    idTempo INT NOT NULL,
    idEvento INT NOT NULL,
    idMeio INT NOT NULL,
    PRIMARY KEY(idxFact),
    FOREIGN KEY(idTempo) REFERENCES d_tempo(idTempo),
    FOREIGN KEY(idEvento) REFERENCES d_evento(idEvento),
    FOREIGN KEY(idMeio) REFERENCES d_meio(idMeio)
);

INSERT INTO d_evento (numTelefone, instanteChamada)
    SELECT DISTINCT numTelefone, instanteChamada
      FROM eventoEmergencia;

INSERT INTO  d_meio(numMeio,nomeMeio,nomeEntidade, tipo)
  SELECT
    numMeio,
    nomeMeio,
    nomeEntidade,
    'Combate' AS tipo
  FROM meio NATURAL JOIN meioCombate;

INSERT INTO  d_meio (numMeio,nomeMeio,nomeEntidade, tipo)
  SELECT
    numMeio,
    nomeMeio,
    nomeEntidade,
    'Apoio' AS tipo
  FROM meio NATURAL JOIN meioApoio;

INSERT INTO  d_meio (numMeio,nomeMeio,nomeEntidade, tipo)
  SELECT
    numMeio,
    nomeMeio,
    nomeEntidade,
    'Socorro' AS tipo
  FROM meio NATURAL JOIN meioSocorro;

INSERT INTO d_tempo(dia,mes, ano)
  SELECT 
    date_part('day', TIMESTAMP instanteChamada) AS dia,
    date_part('month', TIMESTAMP instanteChamada) AS mes,
    date_part('year', TIMESTAMP instanteChamada) AS ano
  FROM eventoEmergencia;

  INSERT INTO fact (idTempo, idEvento, idMeio)
    SELECT DISTINCT idTempo, idEvento, idMeio
    FROM d_tempo NATURAL JOIN d_evento NATURAL JOIN d_meio;
    
