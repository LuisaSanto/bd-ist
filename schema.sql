drop table if exists camara;
drop table if exists video;
drop table if exists segmentoVideo;
drop table if exists local;
drop table if exists vigia;
drop table if exists eventoEmergencia;
drop table if exists processoSocorro;
drop table if exists entidadeMeio;
drop table if exists meio;
drop table if exists meioCombate;
drop table if exists meioApoio;
drop table if exists meioSocorro;
drop table if exists transporta;
drop table if exists alocado;
drop table if exists acciona;
drop table if exists coordenador;
drop table if exists audita;
drop table if exists solicita;

------------------------------------------------
--  TABLE CREATION
------------------------------------------------


create table camara 
	( numCamara numeric(3) not null unique,
	  constraint pk_camara primary key(numCamara) 
	);

create table video 
	( dataHoraInicio datetime not null unique,
	  dataHoraFim datetime not null,
	  numCamara numeric(3) not null unique,
	  constraint pk_video primary key(dataHoraInicio),
	  constraint fk_video_camara foreign key(numCamara) references camara(numCamara)
	); 

create table segmentoVideo 
	( numSegmento numeric(4) not null unique,
	  duracao interval not null, -- FIXME: nao sei se deve ser numeric, datetime ou interval?
	  dataHoraInicio datetime not null unique,
	  numCamara numeric(3) not null unique,
	  constraint fk_segmentoVideo_video foreign key(dataHoraInicio) references video(dataHoraInicio),
	  constraint fk_segmentoVideo_video foreign key(numCamara) references video(numCamara)
	);

create table local 
	( moradaLocal varchar(255) not null unique,
	 constraint pk_local primary key(moradaLocal)
	);

create table vigia
	( moradaLocal varchar(255) not null unique,
	  numCamara numeric(3) not null unique,
	  constraint fk_vigia_local foreign key(moradaLocal) references local(moradaLocal),
	  constraint fk_vigia_camara foreign key(numCamara) references camara(numCamara)
	);

create table eventoEmergencia 
	( numTelefone numeric(15) not null unique,
	  instanteChamada timestamp not null,
	  nomePessoa varchar(80) not null unique,
	  moradaLocal varchar(255) not null,
	  numProcessoSocorro numeric(100) not null, --FIXME: verificar este valor do numeric. -- RI:pode ser vazio/null
	  constraint fk_eventoEmergencia_local foreign key(moradaLocal) references local(moradaLocal),
	  constraint fk_eventoEmergencia_processoSocorro foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro)
	);

create table processoSocorro 
	( numProcessoSocorro numeric(100) not null unique,
	  constraint pk_processoSocorro primary key(numProcessoSocorro),
		check numProcessoSocorro in ( 
			select E
			from eventoEmergencia
			where E.numProcessoSocorro = numProcessoSocorro)
	);

create table entidadeMeio 
	( nomeEntidade varchar(255) not null unique,
	  constraint pk_entidadeMeio primary key(nomeEntidade)
	);

create table meio 
	( numMeio numeric(100) not null,
	  nomeMeio varchar(255) not null unique,
	  nomeEntidade varchar(255) not null unique,
	  constraint pk_meio primary key(numMeio), 
	  constraint pk_meio primary key(nomeEntidade),
	  constraint fk_meio_entidadeMeio foreign key(nomeEntidade) references entidadeMeio(nomeEntidade)
	);


create table meioCombate 
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  constraint fk_meioCombate_meio foreign key(numMeio) references meio(numMeio),
	  constraint fk_meioCombate_meio foreign key(nomeEntidade) references meio(nomeEntidade)
	);

create table meioApoio 
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  constraint fk_meioApoio_meio foreign key(numMeio) references meio(numMeio),
	  constraint fk_meioApoio_meio foreign key(nomeEntidade) references meio(nomeEntidade)
	);

create table meioSocorro
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  constraint fk_meioSocorro_meio foreign key(numMeio) references meio(numMeio),
	  constraint fk_meioSocorro_meio foreign key(nomeEntidade) references meio(nomeEntidade)
	);

create table transporta 
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  numVitimas numeric(100) not null,
	  numProcessoSocorro numeric(100) not null,
	  constraint fk_transporta_meio foreign key(numMeio) references meioSocorro(numMeio),
	  constraint fk_transporta_meio foreign key(nomeEntidade) references meioSocorro(nomeEntidade),
	  constraint fk_transporta_processoSocorro foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro)
	);

create table alocado 
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  numHoras numeric(3) not null,
	  numProcessoSocorro numeric(100) not null,
	  constraint fk_alocado_meio foreign key(numMeio) references meioApoio(numMeio),
	  constraint fk_alocado_meio foreign key(nomeEntidade) references meioApoio(nomeEntidade),
  	constraint fk_alocado_processoSocorro foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro)
	);

create table acciona 
	( numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  numProcessoSocorro numeric(100) not null,
	  constraint fk_acciona_meio foreign key(numMeio) references meio(numMeio),
	  constraint fk_acciona_meio foreign key(nomeEntidade) references meio(nomeEntidade),
	  constraint fk_acciona_processoSocorro foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro)
	);

create table coordenador 
	( idCoordenador int not null,
	  constraint pk_coordenador primary key(idCoordenador)
	);

create table audita 
	( idCoordenador int not null,
	  numMeio numeric(100) not null,
	  nomeEntidade varchar(255) not null, -- FIXME: unique ??
	  numProcessoSocorro numeric(100) not null,
		dataHoraInicio datetime not null,
		dataHoraFim datetime not null,
		dataAuditoria date not null,
		texto text,
	  constraint fk_audita_coordenador foreign key(idCoordenador) references coordenador(idCoordenador),
	  constraint fk_audita_acciona foreign key(numMeio) references acciona(numMeio),
  	constraint fk_audita_acciona foreign key(nomeEntidade) references acciona(nomeEntidade),
    constraint fk_audita_acciona foreign key(numProcessoSocorro) references acciona(numProcessoSocorro)
		check ( dataHoraInicio < dataHoraFim and dataAuditoria <= dataAtual) -- FIXME: como obter a data atual ??
	);

create table solicita 
	( idCoordenador int not null,
	  dataHoraInicioVideo datetime not null unique,
	  numCamara numeric(3) not null unique,
	  dataHoraInicio datetime not null,
	  dataHoraFim datetime not null,
	  constraint fk_solicita_coordenador foreign key(idCoordenador) references coordenador(idCoordenador),
  	constraint fk_solicita_video foreign key(numCamara) references video(numCamara),
  	constraint fk_solicita_video foreign key(dataHoraInicioVideo) references video(dataHoraInicioVideo)
	);