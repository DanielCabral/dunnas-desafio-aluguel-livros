CREATE OR REPLACE FUNCTION adicionar_saldo_usuario(
    p_usuario_id INTEGER,
    p_valor_adicionar NUMERIC
)
RETURNS NUMERIC -- Retorna o novo saldo do utilizador
LANGUAGE plpgsql
AS $$
DECLARE
    v_novo_saldo NUMERIC;
BEGIN
    IF p_valor_adicionar <= 0 THEN
        RAISE EXCEPTION 'O valor a ser adicionado deve ser positivo.';
    END IF;

    UPDATE usuarios
    SET saldo = saldo + p_valor_adicionar
    WHERE id = p_usuario_id
    RETURNING saldo INTO v_novo_saldo;

    -- INÍCIO DA ATUALIZAÇÃO: Registar no histórico de transações
    INSERT INTO transacoes (usuario_id, tipo_transacao, valor)
    VALUES (p_usuario_id, 'DEPOSITO', p_valor_adicionar);
    -- FIM DA ATUALIZAÇÃO

    RETURN v_novo_saldo;
END;
$$;