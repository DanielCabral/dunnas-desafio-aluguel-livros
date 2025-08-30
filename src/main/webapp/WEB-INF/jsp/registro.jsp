<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Criar Conta</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body class="login-body">

    <div class="login-container">
        <h1>Criar Nova Conta</h1>

        <c:if test="${not empty erro}">
            <div class="error">${erro}</div>
        </c:if>

        <form method="post" action="/registro">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div>
                <label for="nome">Nome Completo:</label>
                <input type="text" id="nome" name="nome" required />
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required />
            </div>
            <div>
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" required />
            </div>
            <div>
                <label for="tipo">Eu sou um:</label>
                <select name="tipo" id="tipo" required style="width: 100%; padding: 15px; font-size: 16px; border-radius: 8px; border: 1px solid #ccc;">
                    <option value="CLIENTE">Cliente (Quero alugar livros)</option>
                    <option value="LOCADOR">Locador (Quero disponibilizar livros)</option>
                </select>
            </div>
            <button type="submit">Criar Conta</button>
        </form>

        <a href="/login" class="create-account-link">Já tem uma conta? Faça o login.</a>
    </div>

</body>
</html>