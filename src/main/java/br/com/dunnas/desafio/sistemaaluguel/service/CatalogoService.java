package br.com.dunnas.desafio.sistemaaluguel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.dunnas.desafio.sistemaaluguel.repository.CatalogoLocadorRepository;
import java.math.BigDecimal;

@Service
public class CatalogoService {

    @Autowired
    private CatalogoLocadorRepository catalogoRepository;

    public void adicionarLivroAoCatalogo(Integer locadorId, String isbn, String titulo, String autor, BigDecimal valor, Integer quantidade) {
        catalogoRepository.gerenciarCatalogo(locadorId, isbn, titulo, autor, valor, quantidade);
    }
}