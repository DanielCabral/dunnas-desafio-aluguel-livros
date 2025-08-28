package br.com.dunnas.desafio.sistemaaluguel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import br.com.dunnas.desafio.sistemaaluguel.model.CatalogoLocador;
import java.math.BigDecimal;

@Repository
public interface CatalogoLocadorRepository extends JpaRepository<CatalogoLocador, Integer> {

    @Query(value = "SELECT gerenciar_catalogo_locador(:locadorId, :isbn, :titulo, :autor, :valor, :quantidade)", nativeQuery = true)
    Integer gerenciarCatalogo(
        @Param("locadorId") Integer locadorId,
        @Param("isbn") String isbn,
        @Param("titulo") String titulo,
        @Param("autor") String autor,
        @Param("valor") BigDecimal valor,
        @Param("quantidade") Integer quantidade
    );
}