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
		    <p>Esta é a lista completa de todas as obras disponíveis no sistema.</p>
		    
		    <div class="form-container" style="margin-bottom: 20px;">
		        <input type="text" id="search-input" placeholder="Pesquisar por título..." 
		               style="width:100%; padding:10px; font-size:16px; border-radius:4px; border: 1px solid #ccc;">
		    </div>
		    
		    <div class="table-container">
		        <table id="books-table"> <%-- Adicionado um ID à tabela --%>
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
							    <td>
							        <%-- Aplica a classe específica para links de texto --%>
							        <a href="/livro/${livro.id}" class="table-link"><c:out value="${livro.titulo}" /></a>
							    </td>
							    <td><c:out value="${livro.autor}" /></td>
							    <td>R$ <c:out value="${livro.valorObra}" /></td>
							    <td>
							        <%-- A classe .btn-action já está a ser usada aqui --%>
							        <a href="/livro/${livro.id}" class="btn-action">Ver Detalhes</a>
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