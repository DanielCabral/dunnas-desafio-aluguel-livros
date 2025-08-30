<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Detalhes de <c:out value="${livro.titulo}" /></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="layout/header.jsp" />
        <main class="content">
            <div class="container">
                <div class="form-container">
                    <h1><c:out value="${livro.titulo}" /></h1>
                    <h3>Por <c:out value="${livro.autor}" /></h3>
                    <p><strong>ISBN:</strong> <c:out value="${livro.isbn}" /></p>
                    <p><strong>Valor da Obra:</strong> R$ <c:out value="${livro.valorObra}" /></p>
                    <hr style="margin: 20px 0;">
                    <h2>Sinopse</h2>
                    <p><c:out value="${livro.sinopse}" /></p>
                </div>

                <div class="table-container">
                    <h2>Disponível com os seguintes locadores:</h2>
                    <c:choose>
                        <c:when test="${not empty locadoresDisponiveis}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Nome do Locador</th>
                                        <th>Estoque</th>
                                        <th>Ação</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${locadoresDisponiveis}" var="catalogo">
                                        <tr>
                                            <td><c:out value="${catalogo.locador.nome}" /></td>
                                            <td><c:out value="${catalogo.estoque}" /></td>
                                            <td>
                                               <form action="/alugar" method="post">
												    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												    <input type="hidden" name="livroId" value="${livro.id}" />
												    <input type="hidden" name="locadorId" value="${catalogo.locador.id}" />
												    <button type="submit" class="btn-alugar">Alugar deste Locador</button>
												</form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>Nenhum locador tem este livro em estoque no momento.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>