package br.com.dunnas.desafio.sistemaaluguel.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // <-- MUDANÇA 1: Usar @Controller
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.repository.LocacaoRepository;
import br.com.dunnas.desafio.sistemaaluguel.service.LocacaoService;
import jakarta.servlet.http.HttpSession;

@Controller
public class LocacaoController {

    @Autowired
    private LocacaoService locacaoService;
    
    @Autowired
    private LocacaoRepository locacaoRepository;

    @PostMapping("/alugar")
    public String alugar(@RequestParam Integer livroId,
                         @RequestParam Integer locadorId,
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {
        
        Usuario cliente = (Usuario) session.getAttribute("usuarioLogado");
        if (cliente == null) {
            return "redirect:/login";
        }
        try {
            locacaoService.alugarLivro(cliente.getId(), locadorId, livroId);
            redirectAttributes.addFlashAttribute("mensagem", "Livro alugado com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao alugar livro: " + e.getMessage());
        }
        return "redirect:/dashboard";
    }
    
    @PostMapping("/devolver")
    public String devolverLivro(@RequestParam Integer locacaoId, 
                                HttpSession session, 
                                RedirectAttributes redirectAttributes) {
        
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        try {
            locacaoService.devolverLivro(locacaoId, usuarioLogado);
            redirectAttributes.addFlashAttribute("mensagem", "Livro devolvido com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao devolver o livro: " + e.getMessage());
        }

        return "redirect:/meus-alugueis";
    }
    
    @GetMapping("/meus-alugueis")
    public String exibirMeusAlugueis(HttpSession session, Model model) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        if (usuarioLogado == null || !"CLIENTE".equals(usuarioLogado.getTipo())) {
            return "redirect:/login";
        }

        List<Locacao> locacoesAtivas = locacaoRepository.findByClienteAndStatus(usuarioLogado, "ATIVA");
        model.addAttribute("minhasLocacoes", locacoesAtivas);
        
        return "meus-alugueis";
    }
}