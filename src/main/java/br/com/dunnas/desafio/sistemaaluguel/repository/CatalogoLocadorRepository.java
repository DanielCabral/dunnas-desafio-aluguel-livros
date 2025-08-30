package br.com.dunnas.desafio.sistemaaluguel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import br.com.dunnas.desafio.sistemaaluguel.model.CatalogoLocador;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface CatalogoLocadorRepository extends JpaRepository<CatalogoLocador, Integer> {
	List<CatalogoLocador> findByLivroAndEstoqueGreaterThan(Livro livro, int estoque);
	
    @Query(value = "SELECT gerenciar_catalogo_locador(:locadorId, :isbn, :titulo, :autor, :valor, :quantidade)", nativeQuery = true)
    Integer gerenciarCatalogo(
        @Param("locadorId") Integer locadorId,
        @Param("isbn") String isbn,
        @Param("titulo") String titulo,
        @Param("autor") String autor,
        @Param("valor") BigDecimal valor,
        @Param("quantidade") Integer quantidade
    );
    
 // Adicione este novo método à interface
    List<CatalogoLocador> findByLocadorOrderByLivroTituloAsc(Usuario locador);
}