package br.com.dunnas.desafio.sistemaaluguel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;
import br.com.dunnas.desafio.sistemaaluguel.repository.LivroRepository; // Crie este repositório
import br.com.dunnas.desafio.sistemaaluguel.model.CatalogoLocador;
import br.com.dunnas.desafio.sistemaaluguel.repository.CatalogoLocadorRepository;
import java.util.List;
import java.util.Optional;

@Service
public class LivroService {

    @Autowired
    private LivroRepository livroRepository;

    public List<Livro> listarTodos() {
        return livroRepository.findAll();
    }
    
    @Autowired
    private CatalogoLocadorRepository catalogoLocadorRepository;

    public List<CatalogoLocador> encontrarLocadoresComEstoque(Integer livroId) {
        Livro livro = livroRepository.findById(livroId)
            .orElseThrow(() -> new RuntimeException("Livro não encontrado."));
        return catalogoLocadorRepository.findByLivroAndEstoqueGreaterThan(livro, 0);
    }
    

    public Optional<Livro> buscarPorId(Integer id) {
        return livroRepository.findById(id);
    }
}