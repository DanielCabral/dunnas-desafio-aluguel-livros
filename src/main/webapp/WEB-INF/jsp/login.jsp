<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body class="login-body">

    <div class="login-container">
        <h1>Login do Sistema</h1>
        
        <c:if test="${not empty erro}">
            <div class="error">${erro}</div>
        </c:if>
        <c:if test="${not empty mensagem}">
            <div class="message">${mensagem}</div>
        </c:if>

        <form method="post" action="/login">
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required autofocus />
            </div>
            <div>
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" required />
            </div>
            <button type="submit">Entrar</button>
        </form>

        <a href="/registro" class="create-account-link">Ainda não tem uma conta? Crie uma aqui.</a>
    </div>

</body>
</html>