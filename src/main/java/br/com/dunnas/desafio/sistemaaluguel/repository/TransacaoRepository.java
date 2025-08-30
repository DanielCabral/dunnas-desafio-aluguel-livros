package br.com.dunnas.desafio.sistemaaluguel.repository;

import br.com.dunnas.desafio.sistemaaluguel.model.Transacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TransacaoRepository extends JpaRepository<Transacao, Integer> {
    
    List<Transacao> findByUsuarioOrderByDataTransacaoDesc(Usuario usuario);
}