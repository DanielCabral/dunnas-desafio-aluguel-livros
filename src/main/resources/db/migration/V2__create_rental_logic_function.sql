CREATE OR REPLACE FUNCTION realizar_locacao(
    p_cliente_id INTEGER,
    p_locador_id INTEGER,
    p_livro_id INTEGER
)
RETURNS INTEGER -- Vai retornar o ID da nova locação
LANGUAGE plpgsql
AS $$
DECLARE
    v_valor_sinal NUMERIC(10, 2);
    v_estoque_atual INTEGER;
    v_saldo_cliente NUMERIC(10, 2);
    v_id_locacao INTEGER;
BEGIN
    -- Passo 1: Validar o estoque e obter o valor do livro
    SELECT
        l.valor_obra * 0.5, -- Calcula 50% do valor da obra 
        cl.estoque
    INTO
        v_valor_sinal,
        v_estoque_atual
    FROM livros l
    JOIN catalogo_locadores cl ON l.id = cl.livro_id
    WHERE l.id = p_livro_id AND cl.locador_id = p_locador_id;

    -- Se não encontrou livro ou catálogo, a consulta acima retorna NULL
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Livro ou locador não encontrado no catálogo.';
    END IF;

    -- Valida se há estoque disponível
    IF v_estoque_atual <= 0 THEN
        RAISE EXCEPTION 'Estoque indisponível para este livro.';
    END IF;

    -- Passo 2: Validar o saldo do cliente
    SELECT saldo INTO v_saldo_cliente FROM usuarios WHERE id = p_cliente_id;
    IF v_saldo_cliente < v_valor_sinal THEN
        RAISE EXCEPTION 'Saldo insuficiente para pagar o sinal.';
    END IF;

    -- Passo 3: Executar as transações (tudo a partir daqui é uma única operação)
    
    -- Debitar do cliente
    UPDATE usuarios SET saldo = saldo - v_valor_sinal WHERE id = p_cliente_id;
    
    -- Creditar para o locador
    UPDATE usuarios SET saldo = saldo + v_valor_sinal WHERE id = p_locador_id;
    
    -- Diminuir o estoque
    UPDATE catalogo_locadores SET estoque = estoque - 1 WHERE livro_id = p_livro_id AND locador_id = p_locador_id;
    
    -- Inserir o registro da locação
    INSERT INTO locacoes (cliente_id, locador_id, livro_id, status, valor_pago_sinal)
    VALUES (p_cliente_id, p_locador_id, p_livro_id, 'ATIVA', v_valor_sinal)
    RETURNING id INTO v_id_locacao; -- Pega o ID da locação recém-criada

    -- Passo 4: Retornar o ID da nova locação para confirmar o sucesso
    RETURN v_id_locacao;

END;
$$;