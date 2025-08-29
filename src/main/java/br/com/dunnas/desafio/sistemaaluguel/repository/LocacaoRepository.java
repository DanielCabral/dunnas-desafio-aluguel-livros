package br.com.dunnas.desafio.sistemaaluguel.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;

@Repository
public interface LocacaoRepository extends JpaRepository<Locacao, Integer> {

    @Query(value = "SELECT realizar_locacao(:clienteId, :locadorId, :livroId)", nativeQuery = true)
    Integer realizarLocacao(
        @Param("clienteId") Integer clienteId,
        @Param("locadorId") Integer locadorId,
        @Param("livroId") Integer livroId
    );
    
 // Encontra todas as locações ativas para um cliente específico
    List<Locacao> findByClienteAndStatus(Usuario cliente, String status);

    // Encontra todas as locações ativas de livros de um locador específico
    List<Locacao> findByLocadorAndStatus(Usuario locador, String status);
    
    @Query(value = "SELECT finalizar_devolucao(:locacaoId)", nativeQuery = true)
    Integer finalizarDevolucao(@Param("locacaoId") Integer locacaoId);
}