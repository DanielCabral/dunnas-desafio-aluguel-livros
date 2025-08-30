<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Catálogo Global de Obras</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="../layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="../layout/header.jsp" />
        <main class="content">
            <h1>Catálogo Global de Obras</h1>
            <p>Abaixo estão todas as obras registadas no sistema. Se desejar registar uma obra completamente nova (que não está na lista), utilize o formulário.</p>

            <div class="container">
                <div class="form-container">
                    <h2>Registar Nova Obra no Sistema</h2>
                    <form action="/locador/catalogo/adicionar" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div>
                            <label for="isbn">ISBN:</label>
                            <input type="text" id="isbn" name="isbn" required>
                        </div>
                        <div>
                            <label for="titulo">Título:</label>
                            <input type="text" id="titulo" name="titulo" required>
                        </div>
                        <div>
                            <label for="autor">Autor:</label>
                            <input type="text" id="autor" name="autor">
                        </div>
                        <div>
                            <label for="valorObra">Valor da Obra (ex: 49.90):</label>
                            <input type="number" step="0.01" id="valorObra" name="valorObra" required>
                        </div>
                        <div>
                            <label for="quantidade">Quantidade inicial no seu estoque:</label>
                            <input type="number" id="quantidade" name="quantidade" required min="1">
                        </div>
                        <button type="submit">Registar Obra e Adicionar ao meu Estoque</button>
                    </form>
                </div>

                <div class="table-container">
                    <h2>Obras Existentes</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ISBN</th>
                                <th>Título</th>
                                <th>Autor</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${livros}" var="livro">
                                <tr>
                                    <td><c:out value="${livro.isbn}" /></td>
                                    <td><c:out value="${livro.titulo}" /></td>
                                    <td><c:out value="${livro.autor}" /></td>
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