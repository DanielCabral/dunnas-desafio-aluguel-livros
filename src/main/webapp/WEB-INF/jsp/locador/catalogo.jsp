<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Gerir Catálogo</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

    <h1>Gestão de Catálogo do Locador</h1>

    <c:if test="${not empty mensagem}">
        <div class="message">${mensagem}</div>
    </c:if>
    <c:if test="${not empty erro}">
        <div class="error">${erro}</div>
    </c:if>

    <div class="container">
        <div class="form-container">
            <h2>Adicionar Livro ao Catálogo</h2>
            <form action="/locador/catalogo/adicionar" method="post">
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
                    <label for="quantidade">Quantidade a Adicionar:</label>
                    <input type="number" id="quantidade" name="quantidade" required min="1">
                </div>
                <button type="submit">Adicionar ao Meu Catálogo</button>
            </form>
        </div>

        <div class="table-container">
            <h2>Livros Globais no Sistema</h2>
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

</body>
</html>