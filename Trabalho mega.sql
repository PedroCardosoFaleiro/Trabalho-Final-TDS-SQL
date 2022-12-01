/*
create table classe (
	nome_classe varchar(25),
    abi_class varchar(25),
primary key(nome_classe));
*/

/*
create table abilidades_de_arma (
	tipo_arma varchar(25),
    abi_1 varchar(25),
    abi_2 varchar(25),
    abi_3 varchar(25),
primary key(nome_arma));
*/

create schema Gameplay;

USE Gameplay;

create table jogador (
	id_jogador int not null,
    nome_jogador varchar(25),
    vida int not null,
    idade int not null,
    gen varchar(25),
    nome_classe varchar(25),
    id_traje int not null,
    id_arma int not null, 
    id_guilda int not null,
primary key (id_jogador),
foreign key (id_traje) references traje (id_traje) on delete cascade,
foreign key (id_arma) references arma (id_arma) on delete cascade,
foreign key (id_guilda) references guilda (id_guilda) on delete cascade);

create table guilda (
	id_guilda int not null,
    nome_guilda varchar(25),
    cor_fac varchar(25),
    id_chefe_guilda int not null,
primary key(id_guilda));

create table dungeon (
	id_dungeon int not null,
    nome_dungeon varchar(25),
    localizacao varchar(25),
    id_boss int,
    id_monstro int,
primary key(id_dungeon),
foreign key (id_boss) references boss (id_boss) on delete cascade,
foreign key (id_monstro) references monstro (id_monstro) on delete cascade);

create table traje (
	id_traje int not null,
	name_traje varchar(25),
    raridade varchar(25),
    protecao_base int not null,
primary key(id_traje));

create table arma (
	id_arma int not null,
    nome_arma varchar(25),
    tipo_arma varchar(25),
    raridade varchar(25),
    dano_base int not null,
primary key(id_arma));

create table monstro (
	id_monstro int not null,
    nome_monstro varchar(25),
    vida int not null,
    dano int not null,
primary key(id_monstro));

create table boss (
	id_boss int not null,
    nome_boss varchar(25),
    vida int not null,
    dano int not null,
primary key(id_boss));

/*Join*/

/* 1 */
select * from jogador;
select * from arma;
select id_jogador,  tipo_arma from jogador 
inner join arma on jogador.id_arma = arma.id_arma;
/*Aqui na 1 mostra a arma que o jogador está usando.*/

/* 2 */
select * from guilda;
select * from jogador;
select nome_jogador, nome_guilda from jogador
inner join guilda on jogador.id_guilda = guilda.id_guilda;
/*Aqui na 2, eu quero que ele mostre a guilda que o jogador está vinculado.*/

/* 3 */
select * from dungeon;
select * from boss;
select nome_boss, nome_dungeon from boss
inner join dungeon on boss.id_boss = dungeon.id_boss;
/* Aqui na 3, ele puxa o nome do local aonde o boss fica.*/

/* 4 */
select * from traje;
select * from jogador;
select nome_jogador, name_traje from jogador
inner join traje on jogador.id_traje = traje.id_traje;
/*No 4, fiz aparecer o nome do traje que o jogador está usando aparecendo o nome do jogador como identificação.*/

/* 5 */
select * from jogador;
select * from guilda;
select nome_jogador, nome_guilda from jogador
inner join guilda on jogador.id_jogador = guilda.id_chefe_guilda;
/*No 5, eu quis mostrar quem que é o chefe das guildas pelo nome, mostrando o nome e a guilda a que gerencia.*/

/*Order by*/
/* 1 */
select nome_boss from boss
where dano > 200 order by nome_boss;
/*Procurei o dano acima de 200 entre os bosses*/

/* 2 */
select nome_arma, dano_base from arma
where dano_base > 200 order by dano_base DESC;
/*Mostra o nome das armas acima de 200 de dano base do maior para o menor.*/

/* 3 */
select * from arma;
select nome_arma from arma
where raridade like 'Lendário' order by nome_arma;
/* Procurei as armas de raridade lendária dento da tabela arma.*/

/* 4 */
select nome_jogador, vida from jogador
where vida > 670 order by vida DESC;
/* Aparece os jogadores que tem acima 670 de vida do maior pro menor*/

/* 5 */
select * from jogador;
select nome_jogador, nome_classe from jogador order by nome_classe;
/*Aparece em ordem as classes junto com o nome dos personagens.*/

/*group by*/
/* 1 */
select nome_classe, count(nome_classe) as 'Quantidade de Classes' from jogador group by nome_classe;
/*Aparece a quantidade de classes que os jogadores estão usando.*/

/* 2 */
select * from jogador;
select gen, count(gen) as 'Quantidade de personagens M e F.' from jogador group by gen; 
/*Aparece quanto personagen Femininos e Masculinos tem no jogo.*/

/* 3 */
select idade, count(idade) as 'Quantidade de personagens com a mesma idade.' from jogador group by idade;
/*Aparece a quantidade de personagem com a mesma idade*/

/* 4 */
select * from dungeon;
select localizacao, count(localizacao) from dungeon group by localizacao;
/*aparece a quantidade de dungeons que ficam no mesma localizacao ou seja o bioma aonde habitam.*/

/* 5 */
select * from jogador;
select * from guilda;
select nome_guilda,count(jogador.id_guilda) as 'Quantidade de jogadores na mesma guilda.' from jogador 
inner join guilda on jogador.id_guilda = guilda.id_guilda group by nome_guilda; 
/*Aparece a quantidade de pessoal que tem na mesma guilda.*/ 

/*join com order by*/
/* 1 */
select * from jogador;
select * from arma;
select nome_jogador, nome_arma, dano_base from jogador
inner join arma on jogador.id_arma = arma.id_arma order by dano_base DESC;
/*Aqui aparece o nome do jogador junto do nome da arma e o dano, colocando em ordem o dano do maior pro menor.*/

/* 2 */
select * from dungeon;
select * from monstro;
select nome_dungeon, nome_monstro, vida from dungeon
inner join monstro on dungeon.id_monstro = monstro.id_monstro order by vida;
/* Aqui aparece o monstro que tem menos vida, junto da dungeon aonde vive e o nome.*/

/* 3 */
select * from traje;
select * from jogador;
select nome_jogador, name_traje, protecao_base from jogador
inner join traje on jogador.id_traje = traje.id_traje order by protecao_base DESC;

/* MIN, MAX, AVG ...*/

select nome_monstro ,MAX(dano) as 'Dano maximo do monstro.' from monstro;
/* Vai aparecer o nome do monstro que tem o maior dano.*/

select nome_jogador ,MIN(vida) as 'Vida minino do jogador.' from jogador;
/* Vai aparecer o nome do jogador que tem a menor vida do jogo.*/

select AVG(vida) as 'A média de vida do jogador.' from jogador;
/* Aparecera a média de vida dos jogadores.*/

select count(nome_boss) as 'Quantidade de dungeons no jogo.' from boss;
/* Vai aparecer a quantidade de dungeons no jogo*/

select AVG(dano_base) as 'A média de dano das armas.' from arma;
/* A média de dano das armas*/

select nome_boss, MAX(dano) as 'O maior dano dentre os boss.' from boss;
/* Aparecera o nome do boss, e o maior dano que ele tem*/

select count(raridade) from traje
where raridade = 'Lendário';
/* Quantidade de trajes com a raridade Léndario no jogo*/

/* Visões */
select * from jogador;
create view jogador_masculino as select nome_jogador from jogador where gen = 'M';
select * from jogador_masculino;

create view jogador_feminino as select nome_jogador from jogador where gen = 'F';
select * from jogador_feminino;

create view jogador_guerreiro as select nome_jogador from jogador where nome_classe = 'Guerreiro';
select * from jogador_guerreiro;

create view jogador_arqueiro as select nome_jogador from jogador where nome_classe = 'Arqueiro';
select * from jogador_arqueiro;

create view jogador_mago as select nome_jogador from jogador where nome_classe = 'Mago';
select * from jogador_mago;

/* Savepoint */
start transaction;

/* 1 */
savepoint savepoint_1;
insert into jogador values(16 , 'Ferdinando', 583, 17, 'M', 'Guerreiro', 8, 1 ,5);

/* 2 */
savepoint savepoint_2;
insert into jogador values(17, 'Roberta', 327, 18, 'F', 'Mago', 6, 13, 3);

/* 3 */
savepoint savepoint_3;
insert into jogador values(18, 'Faleiro', 678, 27, 'M', 'Barbaro', 1, 6, 6);

/* 4 */
savepoint savepoint_4;
insert into dungeon values(11, 'Olimpo', 'Ruina', 8, 7);

/* 5 */
savepoint savepoint_5; 
insert into dungeon values(12, 'Delfos', 'Ruina', 3, 8);

/* User */
create user 
'Cardoso'@'localhost' identified by '1234';
grant select on gameplay.jogador_masculino
to 'Cardoso'@'locashost';
grant select on gameplay.jogador_feminino
to 'Cardoso'@'locashost';
grant select on gameplay.jogador_guerreiro
to 'Cardoso'@'locashost';
grant select on gameplay.jogador_arqueiro
to 'Cardoso'@'locashost';
grant select on gameplay.jogador_mago
to 'Cardoso'@'locashost';
/*O usuario Cardoso tem acesso só as views.*/

create user 
'Arthur'@'localhost' identified by '5678';
grant create, insert on traje to 'Arthur'@'locashost';
/*O usuario Arthur só tem acesso para inserir novos dados.*/

create user 
'Kaiser'@'localhost' identified by '6789';
grant select on dungeon
to 'Kaiser'@'locashost';
/*O usuario Kaiser só tem acesso para ver a tabela dungeon.*/

/*------------------------------*/
select * from jogador;
select * from dungeon;
select * from boss;
select * from arma;
select * from guilda;
select * from monstro;
select * from traje;