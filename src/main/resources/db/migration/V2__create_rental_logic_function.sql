CREATE OR REPLACE FUNCTION realizar_locacao(
    p_cliente_id INTEGER,
    p_locador_id INTEGER,
    p_livro_id INTEGER
)
RETURNS INTEGER
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
        l.valor_obra * 0.5,
        cl.estoque
    INTO
        v_valor_sinal,
        v_estoque_atual
    FROM livros l
    JOIN catalogo_locadores cl ON l.id = cl.livro_id
    WHERE l.id = p_livro_id AND cl.locador_id = p_locador_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Livro ou locador não encontrado no catálogo.';
    END IF;

    IF v_estoque_atual <= 0 THEN
        RAISE EXCEPTION 'Estoque indisponível para este livro.';
    END IF;

    -- Passo 2: Validar o saldo do cliente
    SELECT saldo INTO v_saldo_cliente FROM usuarios WHERE id = p_cliente_id;
    IF v_saldo_cliente < v_valor_sinal THEN
        RAISE EXCEPTION 'Saldo insuficiente para pagar o sinal.';
    END IF;

    -- Passo 3: Executar as transações
    UPDATE usuarios SET saldo = saldo - v_valor_sinal WHERE id = p_cliente_id;
    UPDATE usuarios SET saldo = saldo + v_valor_sinal WHERE id = p_locador_id;
    UPDATE catalogo_locadores SET estoque = estoque - 1 WHERE livro_id = p_livro_id AND locador_id = p_locador_id;

    -- Registar no histórico de transações
    INSERT INTO transacoes (usuario_id, tipo_transacao, valor)
    VALUES (p_cliente_id, 'PAGAMENTO_ALUGUEL', -v_valor_sinal);
    INSERT INTO transacoes (usuario_id, tipo_transacao, valor)
    VALUES (p_locador_id, 'RECEBIMENTO_ALUGUEL', v_valor_sinal);
    
    -- Inserir o registo da locação
    INSERT INTO locacoes (cliente_id, locador_id, livro_id, status, valor_pago_sinal)
    VALUES (p_cliente_id, p_locador_id, p_livro_id, 'ATIVA', v_valor_sinal)
    RETURNING id INTO v_id_locacao;

    RETURN v_id_locacao;

END;
$$;