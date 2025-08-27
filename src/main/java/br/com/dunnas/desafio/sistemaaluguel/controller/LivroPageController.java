package br.com.dunnas.desafio.sistemaaluguel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.dunnas.desafio.sistemaaluguel.service.LivroService;
import br.com.dunnas.desafio.sistemaaluguel.service.LocacaoService;

import java.util.List;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;

@Controller
public class LivroPageController {

    @Autowired
    private LivroService livroService;
    
    @Autowired
    private LocacaoService locacaoService;

    @PostMapping("/alugar")
    public String alugarLivro(@RequestParam("livroId") Integer livroId, RedirectAttributes redirectAttributes) {
        
        // SIMULAÇÃO: Hardcoding dos IDs de cliente e locador
        Integer clienteId = 1;
        Integer locadorId = 2;
        
        try {
            locacaoService.alugarLivro(clienteId, locadorId, livroId);
            redirectAttributes.addFlashAttribute("mensagem", "Livro alugado com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao alugar livro: " + e.getMessage());
        }
        
        return "redirect:/livros"; // Redireciona de volta para a lista de livros
    }
    
    @GetMapping("/login")
    public String exibirPaginaDeLogin() {
        return "login"; // Retorna o nome do arquivo "login.jsp"
    }
    
    @GetMapping("/livros")
    public String listarLivros(Model model) {
        List<Livro> livros = livroService.listarTodos();
        model.addAttribute("livros", livros); // Envia a lista de livros para a página
        return "lista-livros"; // Retorna o nome do arquivo JSP (sem a extensão .jsp)
    }
}