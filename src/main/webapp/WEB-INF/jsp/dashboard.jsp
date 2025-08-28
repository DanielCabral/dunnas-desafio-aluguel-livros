<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<div class="page-container">

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-wrapper">

        <jsp:include page="layout/header.jsp" />

        <main class="content">
            <h1>Bem-vindo(a), <c:out value="${usuario.nome}" />!</h1>

            <%-- ======================================================= --%>
            <%-- =========== CONTEÚDO EXCLUSIVO PARA CLIENTES ========== --%>
            <%-- ======================================================= --%>
            <c:if test="${usuario.tipo == 'CLIENTE'}">
                <h2>Sua Dashboard de Cliente</h2>
                <p>Seu saldo atual: <strong>R$ ${usuario.saldo}</strong></p>

                <h3>Meus Livros Alugados</h3>
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
                                        <td><button>Devolver</button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Você não tem nenhum livro alugado no momento.</p>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <%-- ======================================================= --%>
            <%-- =========== CONTEÚDO EXCLUSIVO PARA LOCADORES ========= --%>
            <%-- ======================================================= --%>
            <c:if test="${usuario.tipo == 'LOCADOR'}">
                <h2>Sua Dashboard de Locador</h2>
                <p>Seu saldo atual: <strong>R$ ${usuario.saldo}</strong></p>

                <h3>Meus Livros Atualmente Alugados</h3>
                <c:choose>
                    <c:when test="${not empty livrosAlugadosDele}">
                         <table>
                            <thead>
                                <tr>
                                    <th>Título do Livro</th>
                                    <th>Alugado por (Cliente)</th>
                                    <th>Data do Aluguel</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${livrosAlugadosDele}" var="locacao">
                                    <tr>
                                        <td><c:out value="${locacao.livro.titulo}" /></td>
                                        <td><c:out value="${locacao.cliente.nome}" /></td>
                                        <td><c:out value="${locacao.dataLocacao}" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Nenhum dos seus livros está alugado no momento.</p>
                    </c:otherwise>
                </c:choose>
            </c:if>

        </main>

        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>