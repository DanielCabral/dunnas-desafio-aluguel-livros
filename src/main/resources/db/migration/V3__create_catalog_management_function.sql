CREATE OR REPLACE FUNCTION gerenciar_catalogo_locador(
    p_locador_id INTEGER,
    p_isbn_livro VARCHAR,
    p_titulo_livro VARCHAR,
    p_autor_livro VARCHAR,
    p_valor_obra NUMERIC,
    p_quantidade_adicionar INTEGER
)
RETURNS INTEGER -- Retorna o novo estoque do livro no catálogo
LANGUAGE plpgsql
AS $$
DECLARE
    v_livro_id INTEGER;
    v_estoque_atual INTEGER;
BEGIN
    -- Passo 1: Verifica se o livro (obra global) já existe pelo ISBN. Se não, cria.
    SELECT id INTO v_livro_id FROM livros WHERE isbn = p_isbn_livro;

    IF NOT FOUND THEN
        INSERT INTO livros (isbn, titulo, autor, valor_obra, sinopse, conteudo_restrito)
        VALUES (p_isbn_livro, p_titulo_livro, p_autor_livro, p_valor_obra, 'Sinopse pendente.', 'Conteúdo pendente.')
        RETURNING id INTO v_livro_id;
    END IF;

    -- Passo 2: Verifica se o locador já tem este livro no seu catálogo.
    SELECT estoque INTO v_estoque_atual FROM catalogo_locadores
    WHERE locador_id = p_locador_id AND livro_id = v_livro_id;

    IF NOT FOUND THEN
        -- Se não tem, insere um novo registo no catálogo.
        INSERT INTO catalogo_locadores (locador_id, livro_id, estoque)
        VALUES (p_locador_id, v_livro_id, p_quantidade_adicionar);
        RETURN p_quantidade_adicionar;
    ELSE
        -- Se já tem, apenas atualiza o estoque.
        UPDATE catalogo_locadores
        SET estoque = estoque + p_quantidade_adicionar
        WHERE locador_id = p_locador_id AND livro_id = v_livro_id
        RETURNING estoque INTO v_estoque_atual;
        RETURN v_estoque_atual;
    END IF;

END;
$$;