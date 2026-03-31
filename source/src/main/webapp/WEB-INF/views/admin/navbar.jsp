<%-- navbar.jsp - Sidebar réutilisable --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="sidebar">
    <div class="sidebar-top">
        <div class="logo">IRAN PULSE</div>
        <nav class="nav-menu">
            <a href="${pageContext.request.contextPath}/admin"
               class="nav-link <%= request.getRequestURI().replaceAll(".*/admin/?$", "MATCH").equals("MATCH") ? "active" : "" %>">Tableau de bord</a>
            <a href="${pageContext.request.contextPath}/admin/articles"
               class="nav-link <%= request.getRequestURI().contains("/articles") && !request.getRequestURI().contains("/add") && !request.getRequestURI().contains("/edit") ? "active" : "" %>">Articles</a>
            <a href="${pageContext.request.contextPath}/admin/articles/add"
               class="nav-link <%= request.getRequestURI().contains("/add") || request.getRequestURI().contains("/edit") ? "active" : "" %>">Nouvel Article</a>
        </nav>
    </div>
    <div class="sidebar-bottom">
        <div class="user-profile">
            <div class="avatar">A</div>
            <div class="user-details">
                <span class="name">Admin</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Déconnexion</a>
            </div>
        </div>
    </div>
</aside>
