<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Conteúdo de <c:out value="${locacao.livro.titulo}" /></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="layout/header.jsp" />
        <main class="content">
            <a href="/meus-alugueis" class="btn-action" style="margin-bottom: 20px;">&larr; Voltar para Meus Aluguéis</a>

            <div class="container">
                <div class="form-container" style="flex: 1;">
                    <h1><c:out value="${locacao.livro.titulo}" /></h1>
                    <h3>Por <c:out value="${locacao.livro.autor}" /></h3>
                    <hr style="margin: 20px 0;">

                    <h2>Conteúdo Completo</h2>
                    <%-- Usamos <pre> para preservar quebras de linha e espaçamento --%>
                    <pre style="white-space: pre-wrap; font-family: inherit; font-size: 1em;"><c:out value="${locacao.livro.conteudo_restrito}" /></pre>
                </div>
            </div>
        </main>
        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>