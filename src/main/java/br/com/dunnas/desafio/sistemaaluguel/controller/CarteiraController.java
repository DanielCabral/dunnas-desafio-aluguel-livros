package br.com.dunnas.desafio.sistemaaluguel.controller;

import java.math.BigDecimal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.service.UsuarioService;
import jakarta.servlet.http.HttpSession;

@Controller
public class CarteiraController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/carteira")
    public String exibirPaginaCarteira(HttpSession session) {
        // Apenas para garantir que o utilizador está logado
        if (session.getAttribute("usuarioLogado") == null) {
            return "redirect:/login";
        }
        return "carteira";
    }

    @PostMapping("/carteira/adicionar")
    public String adicionarSaldo(@RequestParam BigDecimal valor,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        try {
            usuarioService.adicionarSaldo(usuarioLogado.getId(), valor);

            // Atualiza o objeto de utilizador na sessão com o novo saldo
            Usuario usuarioAtualizado = usuarioService.buscarPorId(usuarioLogado.getId()).get();
            session.setAttribute("usuarioLogado", usuarioAtualizado);

            redirectAttributes.addFlashAttribute("mensagem", "Saldo adicionado com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao adicionar saldo: " + e.getMessage());
        }

        return "redirect:/carteira";
    }
}