<%-- navbar.jsp - Barre de navigation réutilisable --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="admin-sidebar">
    <div class="logo">VERTONEWS</div>
    <nav>
        <a href="/admin">Tableau de bord</a>
        <a href="/admin/articles" class="<%= request.getRequestURI().contains("/articles") ? "active" : "" %>">Articles</a>
        <a href="/admin/articles/add" class="<%= request.getRequestURI().contains("/add") ? "active" : "" %>">Nouvel Article</a>
        <a href="/logout">Déconnexion</a>
    </nav>
</aside>
