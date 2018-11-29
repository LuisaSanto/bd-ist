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


create table camara ( 
	numCamara numeric(3) not null unique,
	primary key(numCamaram)
);

create table video(
	dataHoraInicio timestamp not null unique,
	dataHoraFim timestamp not null,
	numCamara numeric(3) not null unique,
	primary key(dataHoraInicio),
	foreign key(numCamara) references camara(numCamara) ON UPDATE CASCADE
); 

create table segmentoVideo ( 
	numSegmento numeric(4) not null unique,
	duracao time not null,
	dataHoraInicio timestamp not null unique,
	numCamara numeric(3) not null unique,
	foreign key(dataHoraInicio) references video(dataHoraInicio) ON UPDATE CASCADE,
	foreign key(numCamara) references video(numCamara) ON UPDATE CASCADE
);

create table local( 
	moradaLocal varchar(255) not null unique,
	primary key(moradaLocal)
);

create table vigia(
	moradaLocal varchar(255) not null unique,
	numCamara numeric(3) not null unique,
	foreign key(moradaLocal) references local(moradaLocal) ON UPDATE CASCADE,
	foreign key(numCamara) references camara(numCamara) ON UPDATE CASCADE
);

create table eventoEmergencia(
	numTelefone numeric(15) not null unique,
	instanteChamada time not null,
	nomePessoa varchar(80) not null unique,
	moradaLocal varchar(255) not null,
	numProcessoSocorro numeric(100) not null,
	foreign key(moradaLocal) references local(moradaLocal) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table processoSocorro( 
	numProcessoSocorro numeric(100) not null unique,
	primary key(numProcessoSocorro)
);

create table entidadeMeio( 
	nomeEntidade varchar(255) not null unique,
	primary key(nomeEntidade)
);

create table meio( 
	numMeio numeric(100) not null,
	nomeMeio varchar(255) not null unique,
	nomeEntidade varchar(255) not null unique,
	primary key(numMeio), 
	primary key(nomeEntidade),
	foreign key(nomeEntidade) references entidadeMeio(nomeEntidade) ON UPDATE CASCADE
);


create table meioCombate( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	foreign key(numMeio) references meio(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meio(nomeEntidade) ON UPDATE CASCADE
);

create table meioApoio( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	foreign key(numMeio) references meio(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meio(nomeEntidade) ON UPDATE CASCADE
);

create table meioSocorro( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	foreign key(numMeio) references meio(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meio(nomeEntidade) ON UPDATE CASCADE
);

create table transporta( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numVitimas numeric(100) not null,
	numProcessoSocorro numeric(100) not null,
	foreign key(numMeio) references meioSocorro(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meioSocorro(nomeEntidade) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table alocado( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numHoras numeric(3) not null,
	numProcessoSocorro numeric(100) not null,
	foreign key(numMeio) references meioApoio(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meioApoio(nomeEntidade) ON UPDATE CASCADE,
  	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table acciona( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null, -- FIXME: unique ??
	numProcessoSocorro numeric(100) not null,
	foreign key(numMeio) references meio(numMeio) ON UPDATE CASCADE,
	foreign key(nomeEntidade) references meio(nomeEntidade) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table coordenador( 
	idCoordenador int not null,
	primary key(idCoordenador)
);

create table audita( 
	idCoordenador int not null,
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null, -- FIXME: unique ??
	numProcessoSocorro numeric(100) not null,
	dataHoraInicio timestamp not null,
	dataHoraFim timestamp not null,
	dataAuditoria date not null,
	texto text,
	foreign key(idCoordenador) references coordenador(idCoordenador) ON UPDATE CASCADE,
	foreign key(numMeio) references acciona(numMeio) ON UPDATE CASCADE,
  	foreign key(nomeEntidade) references acciona(nomeEntidade) ON UPDATE CASCADE,
    foreign key(numProcessoSocorro) references acciona(numProcessoSocorro) ON UPDATE CASCADE
);

create table solicita( 
	idCoordenador int not null,
	dataHoraInicioVideo timestamp not null unique,
	numCamara numeric(3) not null unique,
	dataHoraInicio timestamp not null,
	dataHoraFim timestamp not null,
	foreign key(idCoordenador) references coordenador(idCoordenador) ON UPDATE CASCADE,
  	foreign key(numCamara) references video(numCamara) ON UPDATE CASCADE,
  	foreign key(dataHoraInicioVideo) references video(dataHoraInicioVideo) ON UPDATE CASCADE
);