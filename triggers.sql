-- RI-1: Nao podem existir processos de socorro sem estarem associados a um ou mais Eventos de Emergencia

DELIMITER //
DROP TRIGGER IF EXISTS update_processosocorro;
CREATE TRIGGER update_processosocorro BEFORE INSERT ON processoSocorro
FOR EACH ROW
	IF (EXISTS (SELECT numProcessoSocorro FROM processoSocorro
				WHERE NEW.numProcessoSocorro NOT IN (
					SELECT numProcessoSocorro FROM eventoEmergencia)))
	THEN CALL nenhum_evento_de_emergencia();
	END IF;
END //
DELIMITER ;

#R2: A data e a hora do inicio da auditoria tem que ser inferior 'a data e hora do fim dessa mesma auditoria e a data da auditoria tem que ser inferior 'a data actual
DELIMITER //
DROP TRIGGER IF EXISTS update_auditoria;
CREATE TRIGGER update_auditoria BEFORE INSERT ON audita
FOR EACH ROW
BEGIN
	IF (EXISTS (SELECT datahorainicio, datahorafim, dataauditoria FROM audita 
				WHERE(NEW.datahorainicio > NEW.datahorafim 
					AND NEW.dataauditoria > NOW()))
	THEN CALL datas_mal_formatadas();
END //
DELIMITER ;
