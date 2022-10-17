
/******************** PROCEDURES ******************** */


-- 01 - Escreva quarto procedures de sintaxe - não precisa ter funcionalidade, 
-- basta não dar erro de sintaxe. 
-- Use variável global para testar. a uma


-- #1 -  declarando variáveis e com select into;  
DELIMITER //
CREATE PROCEDURE verifica_par_impar (numero INT)
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

-- #2 - Faça a segunda com uma estrutura de decisão; 

-- #3 - Faça a terceira que gere erro, impedindo a ação;

-- #4 - Faça a quarta com if e else. 


-- 02 - Escreva uma procedure que registre a baixa de um produto e já atualize devidamente o estoque do produto. Antes das ações, verifique se o produto é ativo.


DELIMITER //
CREATE PROCEDURE insere_venda_atualiza_estoque 
        (id_produto INT, id_venda INT, quantidade INT, unidade_preco DECIMAL(8,2))
        
BEGIN
    DECLARE

END
//
DELIMITER ;


-- 03 - Escreva uma procedure que altere o preço de um produto vendido (venda já realizada - necessário verificar a existência da venda). Não permita altearções abusivas - preço de venda abaixo do preço de custo. É possível implementar esta funcionalidade sem a procedure? Se sim, indique como, bem como as vantagens e desvantagens.


-- 04 - Escreva uma procedure que registre vendas de produtos e já defina o total da venda. É possível implementar a mesma funcionalidade por meio da trigger? Qual seria a diferença?


-- 05- Para o controle de salário de funcionários de uma empresa e os respectivos adiantamentos (vales):  
    -- quais tabelas são necessárias?

-- 06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 procedures úteis. Discuta com os seus colegas em relação a relevância e implemente-as.


-- 07- Explique as diferenças entre trigger, função e procedure. Indique as vantagens e desvantagens em utilizar a procedure.
