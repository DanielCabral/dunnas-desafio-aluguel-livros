package br.com.dunnas.desafio.sistemaaluguel.controller;

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
public class ContaController {

    @Autowired
    private UsuarioService usuarioService;

    // Método para EXIBIR a página "Minha Conta"
    @GetMapping("/minha-conta")
    public String exibirPaginaMinhaConta(HttpSession session) {
        if (session.getAttribute("usuarioLogado") == null) {
            return "redirect:/login";
        }
        return "minha-conta";
    }

    // Método para PROCESSAR a atualização do perfil
    @PostMapping("/minha-conta/atualizar")
    public String atualizarPerfil(@RequestParam String nome,
                                  @RequestParam(required = false) String senha, // Senha não é obrigatória
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        try {
            Usuario usuarioAtualizado = usuarioService.atualizarPerfil(usuarioLogado.getId(), nome, senha);
            
            // Atualiza o objeto na sessão com os novos dados
            session.setAttribute("usuarioLogado", usuarioAtualizado);
            
            redirectAttributes.addFlashAttribute("mensagem", "Perfil atualizado com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", "Erro ao atualizar o perfil: " + e.getMessage());
        }

        return "redirect:/minha-conta";
    }
}