<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des articles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="admin-wrapper">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />
    
    <main class="editor-main">
        <header class="editor-header">
            <h2>Tous les articles</h2>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/admin/articles/add" class="btn-primary">+ Nouvel Article</a>
            </div>
        </header>

        <section class="articles-container">
            <c:if test="${not empty success}">
                <div class="message success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty articles}">
                    <div class="no-articles">
                        <p>Aucun article trouvé.</p>
                        <a href="${pageContext.request.contextPath}/admin/articles/add" class="btn-primary">Créer le premier article</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="articles-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Titre</th>
                                <th>Slug</th>
                                <th>Date de pub</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="article" items="${articles}">
                                <tr>
                                    <td>${article.id}</td>
                                    <td>${article.titre}</td>
                                    <td><code>${article.slug}</code></td>
                                    <td>
                                        <fmt:formatDate value="${article.datePub}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>
                                        <span class="statut-badge statut-${article.statut}">${article.statut}</span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/articles/edit/${article.id}" class="btn-edit">Éditer</a>
                                        <a href="${pageContext.request.contextPath}/admin/articles/delete/${article.id}" class="btn-delete" onclick="return confirm('Êtes-vous sûr ?')">Supprimer</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </section>
    </main>
</div>
</body>
</html>
