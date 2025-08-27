package br.com.dunnas.desafio.sistemaaluguel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.dunnas.desafio.sistemaaluguel.repository.LocacaoRepository;

@Service
public class LocacaoService {

    @Autowired
    private LocacaoRepository locacaoRepository;

    @Transactional
    public Integer alugarLivro(Integer clienteId, Integer locadorId, Integer livroId) {
        try {
            return locacaoRepository.realizarLocacao(clienteId, locadorId, livroId);
        } catch (Exception e) {
            throw new RuntimeException("Erro ao processar a locação: " + e.getMessage());
        }
    }
}