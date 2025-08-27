CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    saldo NUMERIC(10, 2) NOT NULL DEFAULT 0.00
);

CREATE TABLE livros (
    id SERIAL PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255),
    valor_obra NUMERIC(10, 2) NOT NULL,
    sinopse TEXT,
    conteudo_restrito TEXT
);

CREATE TABLE catalogo_locadores (
    id SERIAL PRIMARY KEY,
    locador_id INTEGER NOT NULL REFERENCES usuarios(id),
    livro_id INTEGER NOT NULL REFERENCES livros(id),
    estoque INTEGER NOT NULL CHECK (estoque >= 0),
    UNIQUE (locador_id, livro_id)
);

CREATE TABLE locacoes (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES usuarios(id),
    locador_id INTEGER NOT NULL REFERENCES usuarios(id),
    livro_id INTEGER NOT NULL REFERENCES livros(id),
    data_locacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_devolucao TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    valor_pago_sinal NUMERIC(10, 2)
);