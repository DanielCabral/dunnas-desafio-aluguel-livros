package br.com.dunnas.desafio.sistemaaluguel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.repository.LocacaoRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @Autowired
    private LocacaoRepository locacaoRepository;

    @GetMapping("/dashboard")
    public String exibirDashboard(HttpSession session, Model model) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        model.addAttribute("usuario", usuarioLogado);

        if ("CLIENTE".equals(usuarioLogado.getTipo())) {
            // Se for um cliente, busca as suas locações ativas
            List<Locacao> locacoesAtivas = locacaoRepository.findByClienteAndStatus(usuarioLogado, "ATIVA");
            model.addAttribute("minhasLocacoes", locacoesAtivas);
        } else if ("LOCADOR".equals(usuarioLogado.getTipo())) {
            // Se for um locador, busca os livros dele que estão atualmente alugados
            List<Locacao> livrosAlugados = locacaoRepository.findByLocadorAndStatus(usuarioLogado, "ATIVA");
            model.addAttribute("livrosAlugadosDele", livrosAlugados);
        }

        // 4. Retorna o nome do ficheiro JSP da dashboard
        return "dashboard";
    }
}