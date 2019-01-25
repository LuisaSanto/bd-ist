--1)
SELECT numProcessoSocorro 
FROM ( SELECT numProcessoSocorro, count(numMeio) AS nr_Meios 
        FROM acciona GROUP BY numProcessoSocorro 
        HAVING(nr_Meios ) > max(nr_Meios ));

--2)
2) SELECT nomeEntidade 
    FROM (SELECT nomeEntidade, count(numProcessoSocorro) AS nr_PS 
            FROM acciona 
            GROUP BY nomeEntidade 
            having (nr_PS) > max(nr_PS)) AS T 
            NATURAL JOIN eventoEmergencia 
            WHERE ( instanteChamada > '2018-06-21 00:00:00' AND instanteChamada < '2018-09-21 23:59:59' );

--3)
SELECT numProcessoSocorro 
FROM (SELECT numProcessoSocorro, nomeEntidade
        FROM acciona  
        WHERE numProcessoSocorro NOT IN (SELECT numProcessoSocorro FROM audita)) AS T
NATURAL JOIN eventoEmergencia 
WHERE ( nomeEntidade = 'Oliveira do Hospital' AND  instanteChamada > '2018-01-01 00:00:00' AND instanteChamada < '2018-12-12 23:59:59' );

--4)

SELECT count(numSegmento) FROM segmentoVideo NATURAL JOIN vigia 
WHERE (moradaLocal='Monchique' AND duracao >'0:01:00' 
        AND dataHoraInicio >' 2018-08-01 00:00:00' 
        AND dataHoraInicio < ' 2018-08-31 23:59:59');

--5)

SELECT numMeio 
FROM (SELECT numMeio 
        FROM (meio NATURAL JOIN acciona) 
        WHERE numMeio NOT IN (SELECT numMeio FROM ( SELECT numMeio FROM (meio NATURAL JOIN acciona)  WHERE ( nomeMeio = 'Apoio') )  ) AS T2
natural join (meio NATURAL JOIN acciona) where nomeMeio='Combate';
--6)
SELECT nomeEntidade
FROM processoSocorro NATURAL JOIN acciona
WHERE nomeEntidade IN (SELECT nomeEntidade FROM meioCombate);