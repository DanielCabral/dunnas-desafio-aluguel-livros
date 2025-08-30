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
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String exibirPaginaDeLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String processarLogin(@RequestParam String email,
                                 @RequestParam String senha,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        try {
            Usuario usuario = usuarioService.autenticar(email, senha);

            // Se a autenticação for bem-sucedida, guardamos o utilizador na sessão
            session.setAttribute("usuarioLogado", usuario);

            // Redireciona para uma página principal ou dashboard
            return "redirect:/dashboard";

        } catch (Exception e) {
            // Se a autenticação falhar, voltamos para o login com uma mensagem de erro
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate(); // Invalida a sessão (remove todos os atributos)
        redirectAttributes.addFlashAttribute("mensagem", "Você foi desconectado com sucesso.");
        return "redirect:/login";
    }
    
 // Método para EXIBIR a página de registo
    @GetMapping("/registro")
    public String exibirPaginaDeRegistro() {
        return "registro"; // Nome do novo ficheiro registro.jsp
    }

    // Método para PROCESSAR o formulário de registo
    @PostMapping("/registro")
    public String processarRegistro(@RequestParam String nome,
                                    @RequestParam String email,
                                    @RequestParam String senha,
                                    @RequestParam String tipo,
                                    RedirectAttributes redirectAttributes) {

        try {
            Usuario novoUsuario = new Usuario();
            novoUsuario.setNome(nome);
            novoUsuario.setEmail(email);
            novoUsuario.setSenha(senha);
            novoUsuario.setTipo(tipo);
            
            // Define um saldo inicial padrão para novos utilizadores
            if ("CLIENTE".equals(tipo)) {
                novoUsuario.setSaldo(new BigDecimal("100.00")); // Saldo inicial para clientes
            } else {
                novoUsuario.setSaldo(BigDecimal.ZERO);
            }

            usuarioService.registrarUsuario(novoUsuario);

            redirectAttributes.addFlashAttribute("mensagem", "Conta criada com sucesso! Por favor, faça o login.");
            return "redirect:/login";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/registro";
        }
    }
}