package br.com.dunnas.desafio.sistemaaluguel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.dunnas.desafio.sistemaaluguel.model.Locacao;

@Repository
public interface LocacaoRepository extends JpaRepository<Locacao, Integer> {

    @Query(value = "SELECT realizar_locacao(:clienteId, :locadorId, :livroId)", nativeQuery = true)
    Integer realizarLocacao(
        @Param("clienteId") Integer clienteId,
        @Param("locadorId") Integer locadorId,
        @Param("livroId") Integer livroId
    );
}