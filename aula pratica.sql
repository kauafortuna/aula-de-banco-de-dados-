-- =====================================================================
-- Banco de pratica para SELECT (MySQL 8 / MySQL Workbench)
-- Executar o script inteiro: Ctrl + Shift + Enter
-- ATENCAO: o DROP abaixo apaga o banco loja_pratica, caso ja exista.
-- =====================================================================

DROP DATABASE IF EXISTS loja_pratica;
CREATE DATABASE loja_pratica CHARACTER SET utf8mb4;
USE loja_pratica;

-- ---------------------------------------------------------------------
-- Tabela 1: clientes
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(80)  NOT NULL,
    email           VARCHAR(100) NULL,
    cidade          VARCHAR(60)  NOT NULL,
    uf              CHAR(2)      NOT NULL,
    data_nascimento DATE         NOT NULL,
    data_cadastro   DATE         NOT NULL
);

INSERT INTO clientes (id, nome, email, cidade, uf, data_nascimento, data_cadastro) VALUES
( 1, 'Ana Souza',        'ana.souza@email.com',     'Brasília',       'DF', '1990-03-15', '2024-01-10'),
( 2, 'Bruno Lima',       'bruno.lima@email.com',    'Goiânia',        'GO', '1985-07-22', '2024-02-05'),
( 3, 'Carla Mendes',     NULL,                      'Brasília',       'DF', '1998-11-30', '2024-03-18'),
( 4, 'Diego Ferreira',   'diego.f@email.com',       'São Paulo',      'SP', '1979-01-08', '2024-05-02'),
( 5, 'Elaine Rocha',     'elaine.rocha@email.com',  'Belo Horizonte', 'MG', '2001-06-12', '2024-08-21'),
( 6, 'Fábio Almeida',    NULL,                      'Goiânia',        'GO', '1993-09-03', '2024-11-11'),
( 7, 'Gabriela Santos',  'gabi.santos@email.com',   'São Paulo',      'SP', '1988-12-25', '2025-01-07'),
( 8, 'Henrique Costa',   'henrique.c@email.com',    'Rio de Janeiro', 'RJ', '1975-04-19', '2025-03-30'),
( 9, 'Isabela Martins',  'isa.martins@email.com',   'Brasília',       'DF', '2003-02-27', '2025-06-14'),
(10, 'João Pereira',     'joao.pereira@email.com',  'Anápolis',       'GO', '1996-10-05', '2025-09-01');

-- ---------------------------------------------------------------------
-- Tabela 2: produtos
-- ---------------------------------------------------------------------
CREATE TABLE produtos (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(80)   NOT NULL,
    categoria VARCHAR(40)   NOT NULL,
    preco     DECIMAL(10,2) NOT NULL,
    estoque   INT           NOT NULL
);

INSERT INTO produtos (id, nome, categoria, preco, estoque) VALUES
( 1, 'Notebook Pro 15',         'Informática',  4599.90,  12),
( 2, 'Mouse sem fio',           'Informática',    89.90, 150),
( 3, 'Teclado mecânico',        'Informática',   349.00,  40),
( 4, 'Monitor 27 polegadas',    'Informática',  1299.00,   0),
( 5, 'Cadeira gamer',           'Móveis',       1150.00,   8),
( 6, 'Mesa de escritório',      'Móveis',        780.50,   5),
( 7, 'Fone Bluetooth',          'Áudio',         259.90,  60),
( 8, 'Caixa de som portátil',   'Áudio',         399.00,  25),
( 9, 'Webcam Full HD',          'Informática',   219.90,   0),
(10, 'Luminária de mesa',       'Móveis',        129.90,  30);

-- ---------------------------------------------------------------------
-- Tabela 3: pedidos (cada pedido = 1 produto, para simplificar)
-- ---------------------------------------------------------------------
CREATE TABLE pedidos (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id  INT  NOT NULL,
    produto_id  INT  NOT NULL,
    quantidade  INT  NOT NULL,
    data_pedido DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,   -- 'Entregue', 'Enviado', 'Pendente', 'Cancelado'
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT fk_pedidos_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO pedidos (id, cliente_id, produto_id, quantidade, data_pedido, status) VALUES
( 1, 1,  1, 1, '2025-01-15', 'Entregue'),
( 2, 1,  2, 2, '2025-01-15', 'Entregue'),
( 3, 2,  5, 1, '2025-02-03', 'Entregue'),
( 4, 3,  7, 1, '2025-02-20', 'Cancelado'),
( 5, 4,  3, 1, '2025-03-11', 'Entregue'),
( 6, 4,  4, 2, '2025-03-11', 'Entregue'),
( 7, 2,  2, 3, '2025-04-07', 'Entregue'),
( 8, 5,  8, 1, '2025-05-19', 'Entregue'),
( 9, 7,  1, 1, '2025-06-02', 'Entregue'),
(10, 7,  6, 1, '2025-06-02', 'Cancelado'),
(11, 1,  7, 2, '2025-07-23', 'Entregue'),
(12, 8,  5, 2, '2025-08-14', 'Entregue'),
(13, 3,  2, 1, '2025-09-09', 'Entregue'),
(14, 9,  3, 1, '2025-10-01', 'Entregue'),
(15, 4,  8, 1, '2025-11-28', 'Entregue'),
(16, 2,  9, 1, '2025-12-12', 'Entregue'),
(17, 7,  7, 1, '2026-01-20', 'Entregue'),
(18, 1,  3, 1, '2026-03-05', 'Enviado'),
(19, 5,  2, 4, '2026-04-17', 'Enviado'),
(20, 9,  1, 1, '2026-05-22', 'Pendente'),
(21, 8,  8, 2, '2026-06-30', 'Pendente'),
(22, 4,  2, 1, '2026-07-08', 'Cancelado');

-- Conferencia rapida
SELECT 'clientes' AS tabela, COUNT(*) AS linhas FROM clientes
UNION ALL SELECT 'produtos', COUNT(*) FROM produtos
UNION ALL SELECT 'pedidos',  COUNT(*) FROM pedidos;

-- lista todos os dados dos clientes 
SELECT * FROM clientes.loja_pratica;

-- nome e preço dos produtos
SELECT nome, preco FROM produtos;

-- listar categorias com e sem repetição
SELECT categoria FROM produtos;
SELECT DISTINCT categoria FROM produtos;

-- Liste nome e preço dos produtos, 
-- com uma coluna calculada preco_com_desconto (10% de desconto).
SELECT nome AS nomenclatura, 
	   preco AS BAGATELA,
       ROUND(preco  * 0.9, 2) AS preco_com_desconto
FROM produtos;

-- quais clientes são do DF?
SELECT  * FROM clientes WHERE UF = 'GO';

-- teste de adicionar 
INSERT INTO clientes VALUES
( 11, 'Kaka',        'kaka.swe@email.com',     'Brasília',       'DF', '2007-02-13', '2024-01-10');

-- quais produtos custam mais de de R$ 500,00?
SELECT nome, preco FROM produtos WHERE preco > 500;

-- PRODUTOS ENTRE 200 E 800
SELECT nome, preco FROM produtos WHERE preco BETWEEN 200 and 800;
-- sintaxe igual mesmo efeito porem mais complexa
SELECT nome, preco FROM produtos WHERE preco >= 200 AND preco <=800;

-- quais clientes moram em goias ou sao paulo (USE IN)
SELECT nome, cidade, uf FROM clientes WHERE uf = 'GO' OR uf = 'SP';

-- teste de adicionar 
INSERT INTO clientes VALUES
( 12, 'Heloysa Heglaya',        'heloheglaya.swe@email.com',     'São Paulo',       'SP', '2007-02-11', '2024-01-10');


-- quais clientes moram em goias ou sao paulo (USE IN)
SELECT nome, cidade, uf FROM clientes WHERE uf = 'GO' OR uf = 'SP';
SELECT nome, cidade, uf FROM clientes WHERE uf IN ('GO', 'SP');


-- lista todos os dados dos clientes 
SELECT * FROM clientes.loja_pratica;

-- CHAMAR EMAIL E nome
SELECT nome, email FROM clientes;

-- CLIENTE SEM EMAIL
SELECT nome, email FROM clientes WHERE email is NULL;

-- cliente que mora no DF e em SP
SELECT nome, cidade, uf FROM clientes WHERE uf IN('DF', 'SP');

-- PRODUTOS com nome especifico 
SELECT nome, email FROM clientes WHERE nome LIKE '%HELOYSA%';

-- pedidos de 2026 não cancelado 
SELECT *
FROM pedidos
WHERE data_pedido >= '2026-01-01'
AND data_pedido < '2027-01-01'
AND status <> 'Cancelado';

-- pedidos de 2026  CANCELADO
SELECT *
FROM pedidos
WHERE data_pedido >= '2026-01-01'
AND data_pedido < '2027-01-01'
AND status = 'Cancelado';

-- listar produto do mais caroo para o mais barato 
-- order by -> asc / desc
SELECT nome, preco FROM produtos ORDER BY preco DESC;

-- INSERIR PRODUTO em produtos
INSERT INTO produtos VALUES
( 11, 'CROCS AURA MAX 19',         'SECRETO',  999.90,  2);

-- VER os produtos 
SELECT * FROM produtos;

INSERT INTO pedidos (id, cliente_id, produto_id, quantidade, data_pedido, status) VALUES
( 23, 11,  11, 1, '2026-11-10', 'Enviado'),
( 24, 12,  11, 1, '2026-01-15', 'Enviado');

-- ver ppedido
SELECT * FROM pedidos;

-- LISTAR OS 3 PRODUTOS CO MAIOR ESTOQUE[
SELECT nome, estoque FROM produtos
ORDER BY estoque DESC LIMIT 3;

-- LISTAR OS 5 PRODUTOS COM MENORS ESTOQUE 
SELECT nome, estoque FROM produtos
ORDER BY estoque ASC LIMIT 5;

-- LISTAR OS CLIENTES ORDENADOS POR UF e, dentro dea UF,
-- por nome
SELECT nome, cidade, uf FROM clientes ORDER BY uf, nome; 

-- listar cliente mais velho
SELECT nome, data_nascimento FROM clientes 
ORDER BY data_nascimento LIMIT 2;

-- paginação 
-- paginas 012: notebook mouse e teclado
SELECT id, nome, preco FROM produtos
ORDER BY id LIMIT 3 OFFSET 0;

-- pagina 02: Monitor cadeira crocss
SELECT id, nome, preco FROM produtos
ORDER BY id LIMIT 3 OFFSET 3;
-- pulie a pagina 03 e fui pra 4 ja 
-- pagina 04: Monitor cadeira crocss
SELECT id, nome, preco FROM produtos
ORDER BY id LIMIT 3 OFFSET 9;

-- pedido maior que 500 em 2026
-- pedido = p
-- clinete = c AS
-- apelido (label) - > AS

SELECT p.id, 
	   p.data_pedido,
       pr.nome 					AS produto, 
       p.quantidade,
       p.quantidade * pr.preco  AS  valor_total
FROM pedidos AS p
JOIN produtos AS pr ON  pr.id = p.produto_id
WHERE p.data_pedido >= '2026-01-01'
	AND p.data_pedido < '2027-01-01'
    AND p.quantidade * pr.preco > 500; 
    
    --
    SELECT
    c.nome AS nome_cliente,
    p.status AS status_pedido,
    p.data AS data_pedido
FROM cliente c 
JOIN pedidos p ON c.id - p.client_id
JOIN produtos pr ON p.produto_id = pr.id
WHERE pr.nome = 'CROCS AURA MAX 19';
