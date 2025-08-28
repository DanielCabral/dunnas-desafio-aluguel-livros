package br.com.dunnas.desafio.sistemaaluguel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;
import br.com.dunnas.desafio.sistemaaluguel.service.CatalogoService;
import br.com.dunnas.desafio.sistemaaluguel.service.LivroService;
import java.math.BigDecimal;
import java.util.List;

@Controller
public class CatalogoPageController {

    @Autowired
    private LivroService livroService;

    @Autowired
    private CatalogoService catalogoService;

    @GetMapping("/locador/catalogo")
    public String exibirPaginaCatalogo(Model model) {
        List<Livro> todosOsLivros = livroService.listarTodos();
        model.addAttribute("livros", todosOsLivros);
        return "locador/catalogo"; 
    }

    @PostMapping("/locador/catalogo/adicionar")
    public String adicionarLivroAoCatalogo(
            @RequestParam String isbn,
            @RequestParam String titulo,
            @RequestParam String autor,
            @RequestParam BigDecimal valorObra,
            @RequestParam Integer quantidade,
            RedirectAttributes redirectAttributes) { // Adicione este parâmetro
        
        // Usar o Locador com ID=1 de forma estatica e temporaria para testes
        Integer locadorId = 1;
        
        try {
            catalogoService.adicionarLivroAoCatalogo(locadorId, isbn, titulo, autor, valorObra, quantidade);
            // Em caso de sucesso, envia uma mensagem de sucesso
            redirectAttributes.addFlashAttribute("mensagem", "Livro adicionado/atualizado no catálogo com sucesso!");
        } catch (Exception e) {
            // Em caso de erro, envia a mensagem de erro
            redirectAttributes.addFlashAttribute("erro", "Erro ao processar a sua solicitação: " + e.getMessage());
        }
        
        return "redirect:/locador/catalogo";
    }
    
}