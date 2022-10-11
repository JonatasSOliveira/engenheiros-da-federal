DROP DATABASE IF EXISTS aula; 
CREATE DATABASE aula; 
USE aula; 

CREATE TABLE cliente (
id INT NOT NULL AUTO_INCREMENT
,nome_completo VARCHAR(255) NOT NULL 
,CPF_CNPJ VARCHAR(18) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE produto (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL
,preco_custo DECIMAL(8,2) NOT NULL 
,preco_venda DECIMAL(8,2) NOT NULL 
,estoque INT NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT
,data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cliente_id INT NOT NULL 
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE item_venda(
produto_id INT NOT NULL
,venda_id INT NOT NULL
,quantidade INT NOT NULL 
,preco_unidade DECIMAL(8,2) NOT NULL 
,total_item DECIMAL(8,2) AS (quantidade * preco_unidade) STORED
);

INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('MARIO PEREIRA','111.111.111-11');
INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('JOANA MARCONDES','222.222.222-22');
INSERT INTO cliente (nome_completo,CPF_CNPJ) values ('SILVIO SANTOS','333.333.333-33');
INSERT INTO cliente (nome_completo,CPF_CNPJ,ativo) values ('MARIANA ANTUNES','444.444.444-44','N');

INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('COCA-COLA',4.0,5.5,30);
INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('CHOKITO',2.3,4.5,60);
INSERT INTO produto (nome,preco_custo,preco_venda,estoque) values ('BACONZITOS',4.7,9.0,80);



/*
******************** PROCEDURES ******************** 
- Um bloco de comandos para realizar uma ação;
- Não tem retorno;
- Como não tem retorno, NÃO podemos chamar no SELECT; Exemplo:  
		SELECT minha_procedure(); -- >>>NÃO FUNCIONA
- Como não tem retorno, é necessário fazer a chamada pelo 'CALL'; 
		Exemplo:  CALL minha_procedure(); 
Pode executar INSERT, UPDATE, DELETE ou SELECT; Podem mudar o estado do BD (commit/rollback); >>>Na função não dá...
Além do parâmetro "tradicional" (IN parameter), pode ter parâmetro de saída (OUT parameter);
******************** SINTAXE BÁSICA TRIGGER ******************** 
Legenda: [] - opcional
DELIMITER //								-- alterando o delimitador padrão de ";" para "//"
CREATE PROCEDURE 							-- comando para criar 
[IF NOT EXISTS|IF EXISTS] nome_procedure	-- nome 
BEGIN										-- início 
	[DECLARE TIPO_VARIÁVEL nome_variável;]	-- OPCIONAL - declaração de variáveis	
	--COMANDOS (AÇÃO)						
END;										-- fim 
//											-- fim da definição 
DELIMITER ;									-- alterando (retornando) o delimitador de "//" para ";"
Link script: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
Exemplos:
01 - Crie uma procedure que faça a inserção de uma venda. Caso o cliente não esteja ativo, gerar erro;
CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT
,data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cliente_id INT NOT NULL 
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

*/

DELIMITER //
CREATE PROCEDURE insere_venda (id_cliente INT)
BEGIN
    DECLARE ativo CHAR; 
    SELECT cliente.ativo INTO ativo FROM cliente WHERE cliente.id = id_cliente;
    IF ativo = 'N' THEN
    BEGIN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CLIENTE INATIVO';
    END;
    END IF;
    INSERT INTO venda (cliente_id) VALUES (id_cliente);
END;
//
DELIMITER ;

SELECT * FROM venda; -- verificando se há venda
CALL insere_venda(1); -- executando procedure

SELECT * FROM venda; -- verificando se deu certo
CALL insere_venda(4); -- deverá gerar erro

/*
02 - Crie uma procedure que faça a inserção da venda de um produto e atualize o estoque; 
CREATE TABLE item_venda(
produto_id INT NOT NULL
,venda_id INT NOT NULL
,quantidade INT NOT NULL 
,preco_unidade DECIMAL(8,2) NOT NULL 
);
*/
DELIMITER //
CREATE PROCEDURE insere_venda_atualiza_estoque 
        (id_produto INT, id_venda INT, quantidade INT, unidade_preco DECIMAL(8,2))
        
BEGIN
    DECLARE

END
//
DELIMITER ;

/*

01- Escreva quarto procedures de sintaxe - não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.
- Faça uma declarando variáveis e com select into; 
- Faça a segunda com uma estrutura de decisão; 
- Faça a terceira que gere erro, impedindo a ação;
- Faça a quarta com if e else. 
02 - Escreva uma procedure que registre a baixa de um produto e já atualize devidamente o estoque do produto. Antes das ações, verifique se o produto é ativo.
03 - Escreva uma procedure que altere o preço de um produto vendido (venda já realizada - necessário verificar a existência da venda). Não permita altearções abusivas - preço de venda abaixo do preço de custo. É possível implementar esta funcionalidade sem a procedure? Se sim, indique como, bem como as vantagens e desvantagens.
04 - Escreva uma procedure que registre vendas de produtos e já defina o total da venda. É possível implementar a mesma funcionalidade por meio da trigger? Qual seria a diferença?
05- Para o controle de salário de funcionários de uma empresa e os respectivos adiantamentos (vales):
 - quais tabelas são necessárias?
06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 procedures úteis. Discuta com os seus colegas em relação a relevância e implemente-as.
07- Explique as diferenças entre trigger, função e procedure. Indique as vantagens e desvantagens em utilizar a procedure.
*/