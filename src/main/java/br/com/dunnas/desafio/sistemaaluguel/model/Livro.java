package br.com.dunnas.desafio.sistemaaluguel.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "livros")
public class Livro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true, nullable = false)
    private String isbn;

    @Column(nullable = false)
    private String titulo;

    private String autor;

    @Column(name = "valor_obra", nullable = false)
    private BigDecimal valorObra;

    @Column(name = "sinopse") // Nome atualizado
    private String sinopse;
    
    @Column(name = "conteudo_restrito") // Nome atualizado
    private String conteudo_restrito;

    // GETTERS E SETTERS ATUALIZADOS
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public BigDecimal getValorObra() {
        return valorObra;
    }

    public void setValorObra(BigDecimal valorObra) {
        this.valorObra = valorObra;
    }

    public String getSinopse() {
        return sinopse;
    }

    public void setSinopse(String sinopse) {
        this.sinopse = sinopse;
    }

    public String getConteudo_restrito() {
        return conteudo_restrito;
    }

    public void setConteudo_restrito(String conteudo_restrito) {
        this.conteudo_restrito = conteudo_restrito;
    }
}