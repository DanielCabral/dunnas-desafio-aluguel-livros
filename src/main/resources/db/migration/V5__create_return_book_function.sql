CREATE OR REPLACE FUNCTION finalizar_devolucao(
    p_locacao_id INTEGER
)
RETURNS INTEGER -- Retorna 1 em caso de sucesso
LANGUAGE plpgsql
AS $$
DECLARE
    v_locacao RECORD;
    v_livro RECORD;
    v_valor_restante NUMERIC;
    v_saldo_cliente NUMERIC;
BEGIN
    -- 1. Encontra a locação e garante que ela está ATIVA
    SELECT * INTO v_locacao FROM locacoes WHERE id = p_locacao_id AND status = 'ATIVA';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Locação não encontrada ou já finalizada.';
    END IF;

    -- 2. Busca os dados do livro para obter o valor total
    SELECT * INTO v_livro FROM livros WHERE id = v_locacao.livro_id;
    v_valor_restante := v_livro.valor_obra - v_locacao.valor_pago_sinal;

    -- 3. Verifica se o cliente tem saldo suficiente para pagar o restante
    SELECT saldo INTO v_saldo_cliente FROM usuarios WHERE id = v_locacao.cliente_id;
    IF v_saldo_cliente < v_valor_restante THEN
        RAISE EXCEPTION 'Saldo insuficiente para finalizar a devolução.';
    END IF;

    -- 4. Executa as transações financeiras e de estoque
    UPDATE usuarios SET saldo = saldo - v_valor_restante WHERE id = v_locacao.cliente_id;
    UPDATE usuarios SET saldo = saldo + v_valor_restante WHERE id = v_locacao.locador_id;

    -- INÍCIO DA ATUALIZAÇÃO: Registar no histórico de transações
    INSERT INTO transacoes (usuario_id, tipo_transacao, valor)
    VALUES (v_locacao.cliente_id, 'PAGAMENTO_DEVOLUCAO', -v_valor_restante);
    INSERT INTO transacoes (usuario_id, tipo_transacao, valor)
    VALUES (v_locacao.locador_id, 'RECEBIMENTO_DEVOLUCAO', v_valor_restante);
    -- FIM DA ATUALIZAÇÃO

    UPDATE catalogo_locadores SET estoque = estoque + 1 WHERE livro_id = v_locacao.livro_id AND locador_id = v_locacao.locador_id;
    UPDATE locacoes 
    SET status = 'FINALIZADA', data_devolucao = CURRENT_TIMESTAMP
    WHERE id = p_locacao_id;

    RETURN 1; -- Sucesso
END;
$$;