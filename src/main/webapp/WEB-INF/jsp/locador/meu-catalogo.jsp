<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Meu Catálogo</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="../layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="../layout/header.jsp" />
        <main class="content">
            <h1>Meu Catálogo de Livros</h1>

            <c:if test="${not empty mensagem}"><div class="message">${mensagem}</div></c:if>
            <c:if test="${not empty erro}"><div class="error">${erro}</div></c:if>

            <div class="container">
                <div class="table-container">
                    <h2>Meu Estoque Atual</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Estoque Atual</th>
                                <th>Adicionar Mais</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${meuCatalogo}" var="item">
                                <tr>
                                    <td><c:out value="${item.livro.titulo}" /></td>
                                    <td><strong><c:out value="${item.estoque}" /></strong></td>
                                    <td>
                                        <form action="/locador/catalogo/adicionar" method="post" style="display:flex; gap: 5px;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="isbn" value="${item.livro.isbn}" />
                                            <input type="hidden" name="titulo" value="${item.livro.titulo}" />
                                            <input type="hidden" name="autor" value="${item.livro.autor}" />
                                            <input type="hidden" name="valorObra" value="${item.livro.valorObra}" />
                                            <input type="number" name="quantidade" value="1" min="1" style="width: 60px;">
                                            <button type="submit">+</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="table-container">
                    <h2>Adicionar Livro do Catálogo Global</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Adicionar ao meu catálogo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${livrosGlobais}" var="livro">
                                <tr>
                                    <td><c:out value="${livro.titulo}" /></td>
                                    <td>
                                        <form action="/locador/catalogo/adicionar" method="post" style="display:flex; gap: 5px;">
                                             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="isbn" value="${livro.isbn}" />
                                            <input type="hidden" name="titulo" value="${livro.titulo}" />
                                            <input type="hidden" name="autor" value="${livro.autor}" />
                                            <input type="hidden" name="valorObra" value="${livro.valorObra}" />
                                            <input type="number" name="quantidade" placeholder="Qtd." required min="1" style="width: 60px;">
                                            <button type="submit">Adicionar</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>