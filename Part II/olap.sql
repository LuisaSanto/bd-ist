  SELECT ano, mes, tipo, count(*)
  FROM fact NATURAL JOIN d_meio NATURAL JOIN d_tempo
  WHERE idEvento = 15
  GROUP BY ano, mes, tipo WITH ROLLUP 
UNION
  SELECT ano, NULL, tipo, count(*)
  FROM fact NATURAL JOIN d_meio NATURAL JOIN d_tempo
  WHERE idEvento = 15
  GROUP BY ano, tipo 
UNION
  SELECT NULL, NULL, tipo, count(*)
  FROM fact NATURAL JOIN d_meio NATURAL JOIN d_tempo
  WHERE idEvento = 15
  GROUP BY tipo
  ORDER BY ano, mes ASC;