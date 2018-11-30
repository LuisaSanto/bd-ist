  -- RI-1: Nao podem existir ofertas com datas sobrepostas
DELIMITER //
DROP TRIGGER IF EXISTS update_oferta;
CREATE TRIGGER update_oferta BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
  IF (EXISTS (SELECT data_inicio FROM oferta o
              WHERE o.codigo = NEW.codigo AND o.morada = NEW.morada
              AND NEW.data_fim > o.data_inicio AND NEW.data_inicio < o.data_fim))
  THEN CALL interseccao_datas();
END IF;
END //
DELIMITER ;

-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do último estado dessa reserva
DELIMITER //
DROP TRIGGER IF EXISTS update_paga;
CREATE TRIGGER update_paga BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
  IF (EXISTS (SELECT numero FROM estado e
              WHERE e.numero = NEW.numero AND e.time_stamp > NEW.data) )
  THEN CALL pagamento_data_incorrecta();
END IF;
END //
DELIMITER ;
