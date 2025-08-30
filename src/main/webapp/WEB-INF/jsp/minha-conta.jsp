<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Minha Conta</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="page-container">
    <jsp:include page="layout/sidebar.jsp" />
    <div class="main-wrapper">
        <jsp:include page="layout/header.jsp" />
        <main class="content">
            <h1>Minha Conta</h1>

            <c:if test="${not empty mensagem}"><div class="message">${mensagem}</div></c:if>
            <c:if test="${not empty erro}"><div class="error">${erro}</div></c:if>

            <div class="container">
                <div class="form-container">
                    <h2>Editar Perfil</h2>
                    <form action="/minha-conta/atualizar" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div>
                            <label for="email">Email (não pode ser alterado):</label>
                            <input type="email" id="email" name="email" value="${sessionScope.usuarioLogado.email}" readonly style="background-color: #e9ecef;">
                        </div>
                        <div>
                            <label for="nome">Nome:</label>
                            <input type="text" id="nome" name="nome" value="${sessionScope.usuarioLogado.nome}" required>
                        </div>
                        <div>
                            <label for="senha">Nova Senha:</label>
                            <input type="password" id="senha" name="senha" placeholder="Deixe em branco para não alterar">
                        </div>
                        <button type="submit">Salvar Alterações</button>
                    </form>
                </div>
            </div>
        </main>
        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>