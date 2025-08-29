<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Meus Aluguéis</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<div class="page-container">

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-wrapper">

        <jsp:include page="layout/header.jsp" />

        <main class="content">
            <h1>Meus Aluguéis Ativos</h1>

            <c:if test="${not empty mensagem}">
                <div class="message">${mensagem}</div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="error">${erro}</div>
            </c:if>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty minhasLocacoes}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Título do Livro</th>
                                    <th>Locador</th>
                                    <th>Data do Aluguel</th>
                                    <th>Ação</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${minhasLocacoes}" var="locacao">
                                    <tr>
                                        <td><c:out value="${locacao.livro.titulo}" /></td>
                                        <td><c:out value="${locacao.locador.nome}" /></td>
                                        <td><c:out value="${locacao.dataLocacao}" /></td>
                                        <td>
                                            <form action="/devolver" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <input type="hidden" name="locacaoId" value="${locacao.id}" />
                                                <button type="submit">Devolver</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Você não tem nenhum livro alugado no momento. Visite o <a href="/livros">catálogo</a> para alugar o seu primeiro livro!</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>