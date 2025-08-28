<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Catálogo de Livros</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<div class="page-container">

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-wrapper">

        <jsp:include page="layout/header.jsp" />

        <main class="content">
            <h1>Livros Disponíveis no Catálogo</h1>
            <p>Esta é a lista completa de todas as obras disponíveis no sistema. Como cliente, você pode alugar qualquer um destes livros de um locador que o tenha em estoque.</p>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Valor da Obra</th>
                            <th>Ação</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${livros}" var="livro">
                            <tr>
                                <td><c:out value="${livro.titulo}" /></td>
                                <td><c:out value="${livro.autor}" /></td>
                                <td>R$ <c:out value="${livro.valorObra}" /></td>
                                <td>
                                    <%-- Formulário para alugar o livro --%>
                                    <form action="/alugar" method="post">
                                        <input type="hidden" name="livroId" value="${livro.id}" />
                                        <button type="submit">Alugar</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </main>

        <jsp:include page="layout/footer.jsp" />
    </div>
</div>

<script src="/js/main.js"></script>

</body>
</html>