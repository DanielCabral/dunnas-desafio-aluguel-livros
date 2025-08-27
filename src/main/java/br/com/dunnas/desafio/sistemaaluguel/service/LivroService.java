package br.com.dunnas.desafio.sistemaaluguel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;
import br.com.dunnas.desafio.sistemaaluguel.repository.LivroRepository; // Crie este repositório
import java.util.List;

@Service
public class LivroService {

    @Autowired
    private LivroRepository livroRepository;

    public List<Livro> listarTodos() {
        return livroRepository.findAll();
    }
}