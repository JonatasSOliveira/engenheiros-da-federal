-- Link script: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql

-- Exercícios

-- 01- Escreva quarto procedures de sintaxe - não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.
-- - Faça uma declarando variáveis e com select into; 
-- - Faça a segunda com uma estrutura de decisão; 
-- - Faça a terceira que gere erro, impedindo a ação;
-- - Faça a quarta com if e else. 

DROP PROCEDURE IF EXISTS pcd_var_select;

DELIMITER //
CREATE PROCEDURE pcd_var_select()
BEGIN
	DECLARE var INT;
    SELECT id INTO var FROM produto LIMIT 1;
END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS atualiza_preco

DELIMITER //
CREATE PROCEDURE atualiza_preco(id_produto INT, novo_preco_custo DOUBLE(12, 2), novo_preco_venda DOUBLE(12, 2))
BEGIN
	DECLARE produto_existe BOOL DEFAULT FALSE;
    SELECT (
		SELECT COUNT(*) 
        FROM produto 
        WHERE id = id_produto
	) = 1 INTO produto_existe;
    
    IF produto_existe THEN
		UPDATE produto
        SET preco_custo = novo_preco_custo
			,preco_venda = novo_preco_venda
        WHERE id = id_produto;
    END IF;
END;    
//
DELIMITER ;

DROP PROCEDURE IF EXISTS cadastrar_ivenda;

DELIMITER //
CREATE PROCEDURE cadastrar_ivenda(id_venda INT, id_produto INT, quantidade INT, preco_unidade DOUBLE(12, 2), desconto DECIMAL(12,2))
BEGIN
	DECLARE produto_existe BOOL DEFAULT FALSE;
    SELECT (
		SELECT COUNT(*) 
        FROM produto 
        WHERE id = id_produto
	) = 1 INTO produto_existe;
    
    IF NOT produto_existe THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PRODUTO NÃO EXISTE';
    END IF;
    
    INSERT INTO ivenda (venda_id, produto_id, quantdade, preco_unidade, desconto)
    VALUES (id_venda, id_produto, quantidade, preco_unidade, desconto);
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS atualizar_categoria_produto;

DELIMITER //
CREATE PROCEDURE atualizar_categoria_produto(id_produto INT, id_categoria INT)
BEGIN
	DECLARE produto_categoria_existe INT DEFAULT FALSE;
    SELECT (
		SELECT COUNT(*) = 1 
		FROM produto_categoria 
		WHERE produto_id = id_produto
	) INTO produto_categoria_existe;
        
	IF produto_categoria_existe THEN
		UPDATE produto_categoria 
			SET categoria_id = id_categoria
			WHERE produto_id = id_produto;
    ELSE
		INSERT INTO produto_categoria (produto_id, categoria_id)
			VALUES(id_produto, id_categoria);
    END IF;    
END;
//
DELIMITER ;

-- 02 - Escreva uma procedure que registre a baixa de um produto e já atualize devidamente o estoque do produto. Antes das ações, verifique se o produto é ativo.
-- 03 - Escreva uma procedure que altere o preço de um produto vendido (venda já realizada - necessário verificar a existência da venda). Não permita altearções abusivas - preço de venda abaixo do preço de custo. É possível implementar esta funcionalidade sem a procedure? Se sim, indique como, bem como as vantagens e desvantagens.
-- 04 - Escreva uma procedure que registre vendas de produtos e já defina o total da venda. É possível implementar a mesma funcionalidade por meio da trigger? Qual seria a diferença?
-- 05- Para o controle de salário de funcionários de uma empresa e os respectivos adiantamentos (vales):
--  - quais tabelas são necessárias?
-- 06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 procedures úteis. Discuta com os seus colegas em relação a relevância e implemente-as.
-- 07- Explique as diferenças entre trigger, função e procedure. Indique as vantagens e desvantagens em utilizar a procedure.