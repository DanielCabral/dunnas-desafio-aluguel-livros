<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Meu Histórico de Aluguéis</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="layout/header.jsp" />
        <main class="content">
            <h1>Meu Histórico de Aluguéis</h1>
            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty meusAlugueis}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Título do Livro</th>
                                    <th>Locador</th>
                                    <th>Data do Aluguel</th>
                                    <th>Status</th>
                                    <th>Ação</th>
                                </tr>
                            </thead>
                            <tbody>
							    <c:forEach items="${meusAlugueis}" var="locacao">
							        <tr>
							            <td>
							                <%-- O título agora também é um link para o conteúdo, se o aluguel estiver ativo --%>
							                <c:if test="${locacao.status == 'ATIVA'}">
							                    <a href="/locacao/${locacao.id}/conteudo" class="table-link">
							                        <c:out value="${locacao.livro.titulo}" />
							                    </a>
							                </c:if>
							                <c:if test="${locacao.status != 'ATIVA'}">
							                    <c:out value="${locacao.livro.titulo}" />
							                </c:if>
							            </td>
							            <td><c:out value="${locacao.locador.nome}" /></td>
							            <td><fmt:formatDate value="${locacao.dataLocacao}" pattern="dd/MM/yyyy" /></td>
							            <td><c:out value="${locacao.status}" /></td>
							            <td>
							                <c:if test="${locacao.status == 'ATIVA'}">
							                    <form action="/devolver" method="post" style="margin: 0; display: inline-block;">
							                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							                        <input type="hidden" name="locacaoId" value="${locacao.id}" />
							                        <button type="submit" class="btn-devolver">Devolver</button>
							                    </form>
							                    
							                    <%-- Link adicional para o conteúdo restrito --%>
							                    <a href="/locacao/${locacao.id}/conteudo" class="btn-action" style="margin-left: 5px;">Ver Conteúdo</a>
							                </c:if>
							            </td>
							        </tr>
							    </c:forEach>
							</tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Você ainda não realizou nenhum aluguel.</p>
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