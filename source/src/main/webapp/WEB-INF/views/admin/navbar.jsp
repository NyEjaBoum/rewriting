<%-- navbar.jsp - Barre de navigation réutilisable --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="admin-sidebar">
    <div class="logo">VERTONEWS</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin">Tableau de bord</a>
        <a href="${pageContext.request.contextPath}/admin/articles" class="<%= request.getRequestURI().contains("/articles") ? "active" : "" %>">Articles</a>
        <a href="${pageContext.request.contextPath}/admin/articles/add" class="<%= request.getRequestURI().contains("/add") ? "active" : "" %>">Nouvel Article</a>
        <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
    </nav>
</aside>
