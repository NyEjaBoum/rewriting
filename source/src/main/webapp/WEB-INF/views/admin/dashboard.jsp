<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor-style.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />

    <main class="main-content">
        <header class="editor-header">
            <h2>Tableau de bord</h2>
        </header>

        <section class="dashboard-container">
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Articles publiés</h3>
                    <div class="card-value">${articlesCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/articles" class="card-link">Voir tous les articles →</a>
                </div>
                <div class="card">
                    <h3>Nouvel Article</h3>
                    <div class="card-value">+</div>
                    <a href="${pageContext.request.contextPath}/admin/articles/add" class="card-link">Créer un article →</a>
                </div>
                <div class="card">
                    <h3>Utilisateur connecté</h3>
                    <div class="card-value" style="font-size: 24px;">${sessionScope.user.username}</div>
                    <a href="/logout" class="card-link">Déconnexion →</a>
                </div>
            </div>
        </section>
    </main>
</div>
</body>
</html>
