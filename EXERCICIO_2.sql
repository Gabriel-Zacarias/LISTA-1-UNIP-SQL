-- create database "EXERCICIO_02"
-- ENCODING "UTF-8"
-- TABLESPACE "pg_default"
-- OWNER POSTGRES
-- template = TEMPLATE0;

create table tb_editoras
(
    id_editora   int primary key,
    cnpj         varchar(30),
    razao_social varchar(60),
    fg_ativo     int
);


create table tb_estado
(
    id_estado int primary key,
    nm_estado varchar(60),
    sigla     char(2),
    fg_ativo  int
);

create table tb_autores
(
    id_autores int primary key,
    nm_autor   varchar(60),
    cpf        varchar(12),
    rg         varchar(12),
    fg_ativo   int
);

create table tb_categorias
(
    id_categoria int primary key,
    ds_categoria varchar(40),
    fg_ativo     int
);


create table tb_cidades
(
    id_cidade int,
    id_estado int,
    nm_cidade varchar(60),
    fg_ativo  int,
    constraint pk_tb_cidades primary key (id_cidade),
    constraint fk_id_estado_tb_cidades foreign key (id_estado) references tb_estado
);

create table tb_enderecos_editoras
(
    id_endereco int,
    id_editora  int,
    id_cidade   int,
    ds_endereco varchar(45),
    rua         varchar(60),
    numero      varchar(5),
    complemento varchar(60),
    bairro      varchar(45),
    cep         varchar(10),
    fg_ativo    int,
    constraint pk_tb_enderecos_editoras primary key (id_endereco, id_editora),
    constraint fk_id_cidade_tb_enderecos_editoras foreign key (id_cidade) references tb_cidades (id_cidade),
    constraint fk_id_editora_tb_editoras_editoras foreign key (id_editora) references tb_editoras (id_editora)
);


create table tb_enderecos_autores
(
    id_endereco int,
    id_autor    int,
    id_cidade   int,
    ds_endereco varchar(45),
    rua         varchar(60),
    numero      varchar(5),
    complemento varchar(20),
    bairro      varchar(45),
    cep         varchar(10),
    fg_ativo    int,
    primary key (id_endereco, id_autor),
    constraint fk_id_autor_enderecos_autores foreign key (id_autor) references tb_autores (id_autores),
    constraint fk_id_cidade_enderecos_autores foreign key (id_cidade) references tb_cidades (id_cidade)
);

create table tb_livros
(
    id_livro     int
        constraint pk_tb_livros primary key,
    id_categoria int
        constraint fk_id_categoria_tb_livros references tb_categorias (id_categoria),
    id_autor     int
        constraint fk_id_autor_tb_livros references tb_autores (id_autores),
    id_editora   int
        constraint fk_id_editora_tb_livros references tb_editoras (id_editora),
    isbn         varchar(30),
    titulo       varchar(60),
    preco        decimal(7, 2),
    fg_ativo     int
);

insert into tb_editoras
values (1, '01.222.111/0001-99', 'EMPRESA TESTE A', 1),
       (2, '33.444.898/0004-00', 'EMPRESA TESTE B', 1),
       (3, '66.232.111/0001-03', 'EMPRESA TESTE C', 1);

insert into tb_estado
values (1, 'SÃO PAULO', 'SP', 1),
       (2, 'RIO DE JANEIRO', 'RJ', 1),
       (3, 'SANTA CATERINA', 'SC', 1);

insert into tb_autores
values (1, 'ADÉLIO MACHADO', '22299923433', '223363308', 1),
       (2, 'CALOS LACERDA', '11122233344', '998887776', 1),
       (3, 'FREI BETTO', '34512398712', '009998881', 1);

insert into tb_categorias
values (1, 'INFORMÁTICA', 1),
       (2, 'DIREITO', 1),
       (3, 'AUTO AJUDA', 1);


insert into tb_cidades
values (1, 1, 'RIBEIRÃO PRETO', 1),
       (2, 2, 'RESENDE', 1),
       (3, 3, 'FLORIANÓPOLIS', 1);

insert into tb_enderecos_editoras
values (1, 1, 1, 'COMERCIAL', 'AV NOVE DE JULHO', '123', null, 'CENTRO', '14015-170', 1),
       (2, 2, 2, 'COMERCIAL', 'RUA RUI BARBOSA', '987', 'SALA10A', 'JARDIM NUNES', '34045-980', 1),
       (3, 3, 3, 'COMERCIAL', 'AV DAS NOÇÕES UNIDAS', '12551', null, 'BROOKLIN NOVO', '36471-320', 1);

insert into tb_enderecos_autores
values (1, 1, 1, 'RESIDENCIAL', 'RUA BONFIM', '123', 'Apto 408', 'SUMAREZINHO', '14100-901', 1),
       (2, 2, 2, 'RESIDENCIAL', 'AV JOÃO FIUZA', '9876', null, 'HIGIENÓPOLIS', '78977-902', 1),
       (3, 3, 3, 'RESIDENCIAL', 'AV SENADOR CÉSAR VERGUEIRO', '100', 'casa', 'JARDINS', '78977-903', 1);


insert into tb_livros
values (1, 1, 1, 1, '8521201230', 'DESENVOLVIMENTO PARA WEB COM NODE JS', 120.1, 1),
       (2, 2, 2, 2, '9788502070066', 'DIREITO CONSTITUCIONAL ESQUEMATIZADO', 69.3, 1),
       (3, 3, 3, 3, '8535218920', 'O SEU ÚTIMO LIVRO DE AUTO-AJUDA, REPRIMA SUA RAIVA', 39.78, 1);


-- Recupere as  respectivas colunas ISBN,  TÍTULO,  NOME  DA  EDITORA, DESCRIÇÃO  DA CATEGORIA  DO LIVRO, NOME DO AUTOR e PREÇO, ordenados pelo TÍTULO.
-- Todos os registros devem estar ativos (FG_ATIVO = 1)

select l.isbn,
       e.razao_social,
       c.ds_categoria,
       a.nm_autor,
       l.preco
from tb_livros l
         inner join tb_autores a on l.id_autor = a.id_autores
         inner join tb_categorias c on l.id_categoria = c.id_categoria
         inner join tb_editoras e on l.id_editora = e.id_editora
where l.fg_ativo = 1
  and a.fg_ativo = 1
  and c.fg_ativo = 1
  and e.fg_ativo = 1
order by l.titulo;


-- .Recupere  a  quantidade  de  LIVROS  baseando-se  em  suas  CATEGORIAS,  ou  seja,  quantidade  de  LIVROS de INFORMÁTICA, de DIREITO e AUTO AJUDA.
-- Todos os registros devem estar ativos (FG_ATIVO = 1)

select c.ds_categoria,
       count(*)
from tb_livros l
         inner join tb_categorias c on c.id_categoria = l.id_categoria
where l.fg_ativo = 1
  and c.fg_ativo = 1
group by c.id_categoria;


-- Realize   a SOMATÓRIA dos   valores   de   todos   os   livros   disponíveis   para   comercialização,
-- cuja   sua CATEGORIA seja diferente de (AUTO AJUDA).OBSERVAÇÃO:utilizar IN;Todos os registros devem estar ativos (FG_ATIVO = 1)

select sum(l.preco) as valor
from tb_livros l
         inner join tb_categorias c on c.id_categoria = l.id_categoria
where l.fg_ativo = 1
  and c.fg_ativo = 1
  and c.ds_categoria in ('INFORMÁTICA', 'DIREITO');

-- Recupere as colunas(ISBN, TÍTULO, CATEGORIA e PREÇO) cujosvalores associados à coluna (PREÇO) não se encontre no
-- intervalo (R$ 35,00 à R$ 80,00), ordenados pelo PREÇO.OBSERVAÇÃO:utilizar BETWEEN paradeterminação do intervalo;
-- Todos os registros devem estar ativos (FG_ATIVO = 1)

select l.isbn,
       l.titulo,
       c.ds_categoria,
       l.preco
from tb_livros l
         inner join tb_categorias c on c.id_categoria = l.id_categoria
where l.fg_ativo = 1
  and c.fg_ativo = 1
  and l.preco not between 35.00 and 80.00
order by l.preco;


-- Recupere as respectivas colunas ISBN, TÍTULO, NOME DA EDITORA, CATEGORIA DO LIVRO, NOME DO AUTOR e PREÇO, onde suas
-- CATEGORIAS sejam diferentes de (DIREITO e INFORMÁTICA).OBSERVAÇÃO:utilizar NOT IN;
-- Todos os registros devem estar ativos (FG_ATIVO = 1)


select l.isbn,
       l.titulo,
       e.razao_social,
       c.ds_categoria,
       a.nm_autor,
       l.preco
from tb_livros l
         inner join tb_categorias c on c.id_categoria = l.id_categoria
         inner join tb_editoras e on l.id_editora = e.id_editora
         inner join tb_autores a on l.id_autor = a.id_autores
where l.fg_ativo = 1
  and c.fg_ativo = 1
  and e.fg_ativo = 1
  and a.fg_ativo = 1
  and c.ds_categoria not in ('DIREITO', 'INFORMÁTICA')
order by l.preco;

create table tb_usuarios
(
    user_name  varchar(25) primary key,
    nm_usuario varchar(60),
    password   varchar(30),
    fg_ativo   int
);

INSERT INTO tb_usuarios
VALUES ('teste', 'teste 1', MD5('teste1'), 1),
       ('teste2', 'teste 2', MD5('teste2'), 1);
-- Retorna erro por conta do tamanho

ALTER TABLE tb_usuarios
    ALTER COLUMN password TYPE VARCHAR(32);


INSERT INTO tb_usuarios
VALUES ('teste', 'teste 1', MD5('teste1'), 1),
       ('teste2', 'teste 2', MD5('teste2'), 1);

select *
from tb_usuarios
where password = (select (md5('teste1')));