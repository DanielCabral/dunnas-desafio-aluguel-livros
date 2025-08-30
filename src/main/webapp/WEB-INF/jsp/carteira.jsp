<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Minha Carteira</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<div class="page-container">
    
    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-wrapper">
        
        <jsp:include page="layout/header.jsp" />

        <main class="content">
            <h1>Minha Carteira</h1>

            <c:if test="${not empty mensagem}"><div class="message">${mensagem}</div></c:if>
            <c:if test="${not empty erro}"><div class="error">${erro}</div></c:if>

            <div class="container">
                <div class="form-container">
                    <h2>Saldo Atual: 
                        <strong>
                            <fmt:formatNumber value="${sessionScope.usuarioLogado.saldo}" type="currency" currencySymbol="R$ " />
                        </strong>
                    </h2>
                    <hr style="margin: 20px 0;">
                    
                    <h3>Adicionar Saldo</h3>
                    <p>Simule a adição de fundos à sua conta.</p>
                    
                    <form action="/carteira/adicionar" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div>
                            <label for="valor">Valor a adicionar (ex: 50.00):</label>
                            <input type="number" step="0.01" min="0.01" id="valor" name="valor" required>
                        </div>
                        <button type="submit">Adicionar Fundos</button>
                    </form>
                </div>

                <div class="table-container">
                    <h2>Histórico de Transações</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Descrição</th>
                                <th>Valor</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${historicoTransacoes}" var="tx">
                                <tr>
                                        <td>
										    <c:out value="${tx.dataTransacao}" />
										</td>
                                    <td><c:out value="${tx.tipoTransacao}" /></td>
                                    
                                    <%-- Aplica a classe CSS com base no valor ser positivo ou negativo --%>
                                    <td class="${tx.valor > 0 ? 'valor-positivo' : 'valor-negativo'}">
                                        <fmt:formatNumber value="${tx.valor}" type="currency" currencySymbol="R$ " />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        
        <jsp:include page="layout/footer.jsp" />
    </div>
</div>
<script src="/js/main.js"></script>
</body>
</html>