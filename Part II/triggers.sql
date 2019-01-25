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

-- R3: Um Coordenador só pode solicitar vídeos de câmaras colocadas num local cujo accionamento de meios esteja a ser (ou tenha sido) auditado por ele proprio
CREATE OR REPLACE FUNCTION coordenador_nao_pode_solicitar() RETURNS TRIGGER AS
$$
	BEGIN
		IF NOT (EXISTS (SELECT numcamara FROM solicita WHERE numcamara IN(
						SELECT numcamara FROM vigia NATURAL JOIN eventoemergencia NATURAL JOIN acciona 
						WHERE numprocessosocorro IN(
							SELECT numprocessosocorro 
							FROM solicita s, audita a WHERE s.idcoordenador = a.idcoordenador))))
		THEN RAISE 'O coordenador nao accionou o evento correspondente a camara solicitada'
			USING HINT = 'ver lista de coordenador';
		END IF;
	RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_solicita_coordenador ON solicita;
CREATE TRIGGER update_solicita_coordenador
BEFORE INSERT OR UPDATE ON solicita
FOR EACH ROW
EXECUTE PROCEDURE coordenador_nao_pode_solicitar();

-- R4:Um Meio de Apoio só pode ser alocado a Processos de Socorro para os quais tenha sido accionado
CREATE OR REPLACE FUNCTION apoio_nao_pode_alocar() RETURNS TRIGGER AS
$$
	BEGIN
		IF NOT (EXISTS (
			SELECT * from meioapoio NATURAL JOIN acciona NATURAL JOIN processosocorro 
			WHERE numprocessosocorro IN(
				SELECT numprocessosocorro FROM alocado)))
		THEN RAISE 'O meio de apoio nao pode alocar processos de socorro nao selecionados por eles'
			USING HINT = 'ver lista acciona';
		END IF;
	RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_aloca_processo ON alocado;
CREATE TRIGGER update_aloca_processo
BEFORE INSERT OR UPDATE ON alocado
FOR EACH ROW
EXECUTE PROCEDURE apoio_nao_pode_alocar();

