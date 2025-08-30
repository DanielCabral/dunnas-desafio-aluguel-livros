<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<aside class="sidebar" id="sidebar">
    <nav>
        <ul>
            <%-- ======================================================= --%>
            <%-- =========== ITENS VISÍVEIS PARA TODOS LOGADOS ========= --%>
            <%-- ======================================================= --%>
            <li><a href="/dashboard"><span>&#127968;</span> Dashboard</a></li>
            <li><a href="/livros"><span>&#128218;</span> Catálogo Global</a></li>


            <%-- ======================================================= --%>
            <%-- =========== ITENS EXCLUSIVOS PARA CLIENTES ============ --%>
            <%-- ======================================================= --%>
            <c:if test="${sessionScope.usuarioLogado.tipo == 'CLIENTE'}">
                <li><a href="/meus-alugueis"><span>&#128176;</span> Meus Aluguéis</a></li>
                <li><a href="/carteira"><span>&#128100;</span> Carteira</a></li>
            </c:if>


            <%-- ======================================================= --%>
            <%-- =========== ITENS EXCLUSIVOS PARA LOCADORES =========== --%>
            <%-- ======================================================= --%>
            <c:if test="${sessionScope.usuarioLogado.tipo == 'LOCADOR'}">
                <li><a href="/locador/catalogo"><span>&#128210;</span> Gerir Meu Catálogo</a></li>
                <li><a href="/locador/meu-catalogo"><span>&#128210;</span> Meu Catálogo</a></li>
            </c:if>


            <%-- ======================================================= --%>
            <%-- =========== ITENS FINAIS PARA TODOS LOGADOS =========== --%>
            <%-- ======================================================= --%>
            <li><a href="#"><span>&#128100;</span> Minha Conta</a></li>
            <li><a href="/logout"><span>&#128682;</span> Sair</a></li>
        </ul>
    </nav>
</aside>