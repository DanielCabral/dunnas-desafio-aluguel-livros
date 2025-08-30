package br.com.dunnas.desafio.sistemaaluguel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.repository.LocacaoRepository;
import br.com.dunnas.desafio.sistemaaluguel.service.LocacaoService;
import br.com.dunnas.desafio.sistemaaluguel.service.UsuarioService; // <-- 1. IMPORTAR O USUARIO SERVICE
import jakarta.servlet.http.HttpSession;

@Controller
public class LocacaoController {

    @Autowired
    private LocacaoService locacaoService;
    
    @Autowired
    private LocacaoRepository locacaoRepository;

    @Autowired
    private UsuarioService usuarioService; // <-- 2. INJETAR O USUARIO SERVICE

    /**
     * Processa a requisição para alugar um livro.
     */
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

            // --- INÍCIO DA CORREÇÃO ---
            // 3. Busca o utilizador com o saldo atualizado da base de dados
            Usuario clienteAtualizado = usuarioService.buscarPorId(cliente.getId()).get();
            // 4. Substitui o utilizador antigo na sessão pelo novo
            session.setAttribute("usuarioLogado", clienteAtualizado);
            // --- FIM DA CORREÇÃO ---

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao alugar livro: " + e.getMessage());
        }
        return "redirect:/dashboard";
    }
    
    @GetMapping("/meus-alugueis")
    public String exibirMeusAlugueis(HttpSession session, Model model) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null || !"CLIENTE".equals(usuarioLogado.getTipo())) {
            return "redirect:/login";
        }
        List<Locacao> todosOsAlugueis = locacaoRepository.findByClienteOrderByDataLocacaoDesc(usuarioLogado);
        model.addAttribute("meusAlugueis", todosOsAlugueis);
        return "meus-alugueis";
    }

    /**
     * Processa a devolução de um livro.
     */
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

            // --- INÍCIO DA CORREÇÃO ---
            // 3. Busca o utilizador com o saldo atualizado da base de dados
            Usuario clienteAtualizado = usuarioService.buscarPorId(usuarioLogado.getId()).get();
            // 4. Substitui o utilizador antigo na sessão pelo novo
            session.setAttribute("usuarioLogado", clienteAtualizado);
            // --- FIM DA CORREÇÃO ---

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao devolver o livro: " + e.getMessage());
        }
        return "redirect:/meus-alugueis";
    }
}