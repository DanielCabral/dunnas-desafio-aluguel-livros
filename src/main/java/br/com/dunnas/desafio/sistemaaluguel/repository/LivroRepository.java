package br.com.dunnas.desafio.sistemaaluguel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import br.com.dunnas.desafio.sistemaaluguel.model.Livro;

@Repository
public interface LivroRepository extends JpaRepository<Livro, Integer> {

}