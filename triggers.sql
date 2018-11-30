-- RI-1: Nao podem existir processos de socorro sem estarem associados a um ou mais Eventos de Emergencia
CREATE OR REPLACE FUNCTION nenhum_evento_de_emergencia() RETURNS TRIGGER AS
$$
	BEGIN
		IF (NEW.numProcessoSocorro  NOT IN (
			SELECT numProcessoSocorro FROM eventoEmergencia)) THEN 
			RAISE 'O numero de processo % nao equivale a nenhum evento de emergencia', NEW.numProcessoSocorro
			USING HINT = 'Ver lista de eventos de emergencia';
		END IF;
	RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_processosocorro ON processoSocorro;
CREATE TRIGGER update_processosocorro 
BEFORE INSERT OR UPDATE ON processoSocorro
FOR EACH ROW
EXECUTE PROCEDURE nenhum_evento_de_emergencia();

-- R2: A data e a hora do inicio da auditoria tem que ser inferior 'a data e hora do fim dessa mesma auditoria e a data da auditoria tem que ser inferior 'a data actual
CREATE OR REPLACE FUNCTION datas_mal_formatadas() RETURNS TRIGGER AS
$$
	BEGIN
		IF (NEW.datahorainicio > NEW.datahorafim) THEN
			RAISE 'data hora inicio nao pode ser superior a data hora fim'
			USING HINT = 'hora inicio < hora fim';
		END IF;
		IF (NEW.dataauditoria > NOW()) THEN
			RAISE '% e superior a data de hoje', NEW.dataauditoria
			USING HINT = 'data auditoria inferior a ';
		END IF;
	RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_auditoria ON audita;
CREATE TRIGGER update_auditoria
BEFORE INSERT OR UPDATE ON audita
FOR EACH ROW
EXECUTE PROCEDURE datas_mal_formatadas();
