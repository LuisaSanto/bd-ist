drop table if exists camara cascade;
drop table if exists video cascade;
drop table if exists segmentoVideo cascade;
drop table if exists local cascade;
drop table if exists vigia cascade;
drop table if exists processoSocorro cascade;
drop table if exists eventoEmergencia cascade;
drop table if exists entidadeMeio cascade; 
drop table if exists meio cascade;
drop table if exists meioCombate cascade;
drop table if exists meioApoio cascade;
drop table if exists meioSocorro cascade;
drop table if exists transporta cascade;
drop table if exists alocado cascade;
drop table if exists acciona cascade;
drop table if exists coordenador cascade;
drop table if exists audita cascade;
drop table if exists solicita cascade;

------------------------------------------------
--  TABLE CREATION
------------------------------------------------


create table camara( 
	numCamara numeric(3) not null unique,
	primary key(numCamara)
);

create table video(
	dataHoraInicio timestamp not null unique,
	dataHoraFim timestamp not null,
	numCamara numeric(3) not null unique,
	primary key(dataHoraInicio, numCamara),
	foreign key(numCamara) references camara(numCamara) ON UPDATE CASCADE
); 

create table segmentoVideo ( 
	numSegmento numeric(4) not null unique,
	duracao time not null,
	dataHoraInicio timestamp not null unique,
	numCamara numeric(3) not null unique,
	primary key(numSegmento, dataHoraInicio, numCamara),
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
	primary key(moradaLocal, numCamara),
	foreign key(moradaLocal) references local(moradaLocal) ON UPDATE CASCADE,
	foreign key(numCamara) references camara(numCamara) ON UPDATE CASCADE
);

create table processoSocorro( 
	numProcessoSocorro numeric(100) not null unique,
	primary key(numProcessoSocorro)
);


create table eventoEmergencia(
	numTelefone numeric(15) not null unique,
	instanteChamada time not null,
	nomePessoa varchar(80) not null unique,
	moradaLocal varchar(255) not null,
	numProcessoSocorro numeric(100) not null,
	primary key(numTelefone, instanteChamada),
	foreign key(moradaLocal) references local(moradaLocal) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);


create table entidadeMeio( 
	nomeEntidade varchar(255) not null unique,
	primary key(nomeEntidade)
);

create table meio( 
	numMeio numeric(100) not null unique,
	nomeMeio varchar(255) not null,
	nomeEntidade varchar(255) not null unique,
	primary key(numMeio, nomeEntidade),
	foreign key(nomeEntidade) references entidadeMeio(nomeEntidade) ON UPDATE CASCADE
);


create table meioCombate( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	primary key (numMeio, nomeEntidade),
	foreign key(numMeio, nomeEntidade) references meio(numMeio, nomeEntidade) ON UPDATE CASCADE
);

create table meioApoio( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	primary key (numMeio, nomeEntidade),
	foreign key(numMeio, nomeEntidade) references meio(numMeio, nomeEntidade) ON UPDATE CASCADE
);

create table meioSocorro( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	primary key (numMeio, nomeEntidade),
	foreign key(numMeio, nomeEntidade) references meio(numMeio, nomeEntidade) ON UPDATE CASCADE
);

create table transporta( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numVitimas numeric(100) not null,
	numProcessoSocorro numeric(100) not null,
	primary key(numMeio, nomeEntidade, numProcessoSocorro),
	foreign key(numMeio, nomeEntidade) references meioSocorro(numMeio, nomeEntidade) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table alocado( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numHoras numeric(3) not null,
	numProcessoSocorro numeric(100) not null,
	primary key(numMeio, nomeEntidade, numProcessoSocorro),
	foreign key(numMeio, nomeEntidade) references meioApoio(numMeio, nomeEntidade) ON UPDATE CASCADE,
  	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table acciona( 
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numProcessoSocorro numeric(100) not null,
	primary key(numMeio, nomeEntidade, numProcessoSocorro),
	foreign key(numMeio, nomeEntidade) references meio(numMeio, nomeEntidade) ON UPDATE CASCADE,
	foreign key(numProcessoSocorro) references processoSocorro(numProcessoSocorro) ON UPDATE CASCADE
);

create table coordenador( 
	idCoordenador int not null unique,
	primary key(idCoordenador)
);

create table audita( 
	idCoordenador int not null,
	numMeio numeric(100) not null,
	nomeEntidade varchar(255) not null,
	numProcessoSocorro numeric(100) not null,
	dataHoraInicio timestamp not null,
	dataHoraFim timestamp not null,
	dataAuditoria date not null,
	texto text,
	primary key(idCoordenador, numMeio, nomeEntidade, numProcessoSocorro),
	foreign key(idCoordenador) references coordenador(idCoordenador) ON UPDATE CASCADE,
	foreign key(numMeio, nomeEntidade, numProcessoSocorro) references acciona(numMeio, nomeEntidade, numProcessoSocorro) ON UPDATE CASCADE
);

create table solicita( 
	idCoordenador int not null unique,
	dataHoraInicio timestamp not null unique,
	numCamara numeric(3) not null unique,
	dataHoraInicioSolicita timestamp not null,
	dataHoraFimSolicita timestamp not null,
	primary key(idCoordenador, dataHoraInicio, numCamara),
	foreign key(idCoordenador) references coordenador(idCoordenador) ON UPDATE CASCADE,
  	foreign key(dataHoraInicio, numCamara) references video(dataHoraInicio, numCamara) ON UPDATE CASCADE
);