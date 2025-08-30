package br.com.dunnas.desafio.sistemaaluguel.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.dunnas.desafio.sistemaaluguel.model.Transacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.repository.TransacaoRepository;
import br.com.dunnas.desafio.sistemaaluguel.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import br.com.dunnas.desafio.sistemaaluguel.model.dto.TransacaoDTO;

@Controller
public class CarteiraController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private TransacaoRepository transacaoRepository;

    /**
     * Exibe a página da carteira, mostrando o saldo atual e o histórico de transações.
     */
    @GetMapping("/carteira")
    public String exibirPaginaCarteira(HttpSession session, Model model) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        // 1. Busca o histórico de transações original (com LocalDateTime)
        List<Transacao> transacoesOriginais = transacaoRepository.findByUsuarioOrderByDataTransacaoDesc(usuarioLogado);

        // 2. Cria uma nova lista para os nossos DTOs
        List<TransacaoDTO> historicoFormatado = new ArrayList<>();
        
        // 3. Define o padrão de formatação da data
        DateTimeFormatter formatador = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        // 4. Converte cada Transacao para uma TransacaoDTO com a data já formatada
        for (Transacao tx : transacoesOriginais) {
            TransacaoDTO dto = new TransacaoDTO();
            dto.setTipoTransacao(tx.getTipoTransacao());
            dto.setValor(tx.getValor());
            dto.setDataTransacao(tx.getDataTransacao().format(formatador)); // <-- A conversão acontece aqui!
            historicoFormatado.add(dto);
        }
        
        // 5. Envia a lista JÁ FORMATADA para a página
        model.addAttribute("historicoTransacoes", historicoFormatado);
        
        return "carteira";
    }

    /**
     * Processa a adição de saldo à carteira do utilizador.
     */
    @PostMapping("/carteira/adicionar")
    public String adicionarSaldo(@RequestParam BigDecimal valor,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        try {
            // Chama o serviço para adicionar o saldo (que chama a função do PostgreSQL)
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