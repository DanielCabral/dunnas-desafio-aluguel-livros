package br.com.dunnas.desafio.sistemaaluguel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import br.com.dunnas.desafio.sistemaaluguel.model.CatalogoLocador;

import br.com.dunnas.desafio.sistemaaluguel.service.LivroService;

import java.util.List;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;

@Controller
public class LivroPageController {

    @Autowired
    private LivroService livroService;
    
    @GetMapping("/livro/{id}")
    public String exibirDetalhesDoLivro(@PathVariable("id") Integer id, Model model) {
        try {
            Livro livro = livroService.buscarPorId(id)
                .orElseThrow(() -> new RuntimeException("Livro não encontrado"));

            List<CatalogoLocador> locadoresComEstoque = livroService.encontrarLocadoresComEstoque(id);

            model.addAttribute("livro", livro);
            model.addAttribute("locadoresDisponiveis", locadoresComEstoque);

            return "detalhe-livro"; 
        } catch (Exception e) {
            return "redirect:/livros"; // Se o livro não existir, volta para a lista
        }
    }

    @GetMapping("/livros")
    public String listarLivros(Model model) {
        List<Livro> livros = livroService.listarTodos();
        model.addAttribute("livros", livros);
        return "lista-livros"; 
    }
}