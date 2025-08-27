<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Catálogo de Livros</title>
    <style>
        /* Estilos simples para a tabela */
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h1>Livros Disponíveis para Aluguel</h1>

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
		    <c:if test="${not empty mensagem}">
		        <p style="color: green;">${mensagem}</p>
		    </c:if>
		    <c:if test="${not empty erro}">
		        <p style="color: red;">${erro}</p>
		    </c:if>
		
		    <c:forEach items="${livros}" var="livro">
		        <tr>
		            <td><c:out value="${livro.titulo}" /></td>
		            <td><c:out value="${livro.autor}" /></td>
		            <td>R$ <c:out value="${livro.valorObra}" /></td>
		            <td>
		                <form action="/alugar" method="post">
		                    <input type="hidden" name="livroId" value="${livro.id}" />
		                    <button type="submit">Alugar</button>
		                </form>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>
    </table>

</body>
</html>