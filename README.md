# Sistema de Gerenciamento de Aluguel de Livros

Este projeto é um sistema web para gerenciamento de aluguel de livros, desenvolvido como parte de um desafio técnico. O sistema contempla dois tipos de usuários: Clientes e Locadores, com funcionalidades de catálogo, locação, devolução e controle de saldos.

---

## Tecnologias Utilizadas

* **Backend:** Java 17, Spring Boot 3
* **Frontend:** Java Server Pages (JSP) com JSTL
* **Banco de Dados:** PostgreSQL
* **Versionamento de Banco:** Flyway
* **Autenticação:** Spring Security
* **Build:** Maven

---

## Funcionalidades Principais

- [ ] Cadastro de utilizadores (Clientes e Locadores)
- [ ] Autenticação e controlo de acesso
- [ ] Catálogo de livros global com gestão de estoque individual por locador
- [ ] Fluxo de locação com pagamento de sinal de 50%
- [ ] Fluxo de devolução com pagamento do valor restante e restituição de estoque
- [ ] Movimentação de saldos e histórico de transações

---

## Arquitetura e Lógica de Negócio

Um requisito chave deste projeto é que **pelo menos 50% da lógica de negócio crítica** (validações, transações, cálculos) está implementada diretamente no banco de dados PostgreSQL utilizando `Functions` e `Procedures` em PL/pgSQL. A aplicação Java (backend) atua como uma orquestradora, chamando essa lógica de negócio encapsulada no banco, garantindo a atomicidade e a integridade das operações.

---

## Como Executar o Projeto

Siga os passos abaixo para configurar e executar o ambiente de desenvolvimento.

### Pré-requisitos

- JDK 17 ou superior
- Apache Maven 3.8+
- PostgreSQL 14+
- Uma IDE de sua preferência (Eclipse, IntelliJ, VS Code)

### 1. Configuração do Banco de Dados
