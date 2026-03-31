<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des articles | Iran Pulse</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />

    <main class="main-content">
        <header class="page-header">
            <div class="header-text">
                <h1>Gestion des articles</h1>
                <p>Liste complète des contenus du site d'information sur l'Iran.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/articles/add" class="btn-primary">+ Ajouter un article</a>
        </header>

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
                <div class="table-card">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Titre &amp; Slug</th>
                                <th>Date de publication</th>
                                <th>Statut</th>
                                <th class="actions-head" style="text-align:right;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="article" items="${articles}">
                                <tr>
                                    <td class="id-cell">#${article.id}</td>
                                    <td>
                                        <div class="title-stack">
                                            <strong><c:out value="${article.titre}"/></strong>
                                            <span class="slug"><c:out value="${article.slug}"/></span>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${article.datePub}" pattern="dd MMM yyyy" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${article.statut == 'PUBLIE'}">
                                                <span class="status-pill published">Publié</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-pill draft">Brouillon</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="actions-cell">
                                        <a href="${pageContext.request.contextPath}/admin/articles/edit/${article.id}"
                                           class="btn-icon" title="Modifier">✎</a>
                                        <a href="${pageContext.request.contextPath}/admin/articles/delete/${article.id}"
                                           class="btn-icon btn-danger" title="Supprimer"
                                           onclick="return confirm('Supprimer cet article définitivement ?')">🗑</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>
</body>
</html>
