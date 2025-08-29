package br.com.dunnas.desafio.sistemaaluguel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
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
    
    @Transactional
    public void devolverLivro(Integer locacaoId, Usuario cliente) {
        Locacao locacao = locacaoRepository.findById(locacaoId)
            .orElseThrow(() -> new RuntimeException("Locação não encontrada."));

        // Validação extra para garantir que o cliente só devolve o que é seu
        if (!locacao.getCliente().getId().equals(cliente.getId())) {
            throw new SecurityException("Operação não permitida.");
        }

        locacaoRepository.finalizarDevolucao(locacaoId);
    }
}