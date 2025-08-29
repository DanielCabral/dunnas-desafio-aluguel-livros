package br.com.dunnas.desafio.sistemaaluguel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.math.BigDecimal;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<Usuario> findByEmail(String email);
    @Query(value = "SELECT adicionar_saldo_usuario(:usuarioId, :valor)", nativeQuery = true)
    BigDecimal adicionarSaldo(@Param("usuarioId") Integer usuarioId, @Param("valor") BigDecimal valor);
}