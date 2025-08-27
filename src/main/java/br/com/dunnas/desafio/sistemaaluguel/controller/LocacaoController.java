package br.com.dunnas.desafio.sistemaaluguel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.dunnas.desafio.sistemaaluguel.service.LocacaoService;

@RestController
@RequestMapping("/locacoes")
public class LocacaoController {

    @Autowired
    private LocacaoService locacaoService;

    @PostMapping("/alugar")
    public ResponseEntity<String> alugar(
            @RequestParam Integer clienteId,
            @RequestParam Integer locadorId,
            @RequestParam Integer livroId) {
        try {
            Integer novaLocacaoId = locacaoService.alugarLivro(clienteId, locadorId, livroId);
            return ResponseEntity.ok("Locação realizada com sucesso! ID da locação: " + novaLocacaoId);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}