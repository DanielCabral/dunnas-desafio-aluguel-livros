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
    -- Garante que o valor a ser adicionado é positivo
    IF p_valor_adicionar <= 0 THEN
        RAISE EXCEPTION 'O valor a ser adicionado deve ser positivo.';
    END IF;

    -- Adiciona o valor ao saldo atual do utilizador e retorna o novo saldo
    UPDATE usuarios
    SET saldo = saldo + p_valor_adicionar
    WHERE id = p_usuario_id
    RETURNING saldo INTO v_novo_saldo;

    RETURN v_novo_saldo;
END;
$$;