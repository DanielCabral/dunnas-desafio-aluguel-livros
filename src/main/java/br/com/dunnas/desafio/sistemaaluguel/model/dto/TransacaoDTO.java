package br.com.dunnas.desafio.sistemaaluguel.model.dto; // ou dto

import java.math.BigDecimal;

// Esta classe não é uma entidade, é apenas para transferir dados para a view.
public class TransacaoDTO {
    private String dataTransacao; // A data já formatada
    private String tipoTransacao;
    private BigDecimal valor;

    // Gerar Getters e Setters para todos os campos
    public String getDataTransacao() { return dataTransacao; }
    public void setDataTransacao(String dataTransacao) { this.dataTransacao = dataTransacao; }
    public String getTipoTransacao() { return tipoTransacao; }
    public void setTipoTransacao(String tipoTransacao) { this.tipoTransacao = tipoTransacao; }
    public BigDecimal getValor() { return valor; }
    public void setValor(BigDecimal valor) { this.valor = valor; }
}