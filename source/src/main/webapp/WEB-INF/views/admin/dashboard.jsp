<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord | Iran Pulse</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <style>
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-top: 8px;
        }
        .dash-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }
        .dash-card h3 {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #999;
            margin-bottom: 16px;
        }
        .dash-card .value {
            font-size: 48px;
            font-weight: 800;
            color: #1a1a1a;
            line-height: 1;
            margin-bottom: 20px;
        }
        .dash-card .card-link {
            text-decoration: none;
            color: #1a1a1a;
            font-size: 13px;
            font-weight: 600;
            border-bottom: 2px solid #1a1a1a;
            padding-bottom: 2px;
            transition: opacity 0.2s;
        }
        .dash-card .card-link:hover { opacity: 0.5; }
        .dash-card.accent { background: #1a1a1a; }
        .dash-card.accent h3 { color: #666; }
        .dash-card.accent .value { color: #fff; }
        .dash-card.accent .card-link { color: #fff; border-color: #fff; }
        .user-greeting {
            font-size: 14px;
            color: #888;
            margin-top: 6px;
        }
        .user-greeting strong { color: #1a1a1a; }
    </style>
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />

    <main class="main-content">
        <header class="page-header">
            <div class="header-text">
                <h1>Tableau de bord</h1>
                <p class="user-greeting">Bienvenue, <strong><c:out value="${sessionScope.user.username}"/></strong></p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/articles/add" class="btn-primary">+ Nouvel article</a>
        </header>

        <div class="dashboard-cards">
            <div class="dash-card accent">
                <h3>Articles publiés</h3>
                <div class="value">${publishedCount}</div>
                <a href="${pageContext.request.contextPath}/admin/articles" class="card-link">Voir tous les articles →</a>
            </div>
            <div class="dash-card">
                <h3>Brouillons</h3>
                <div class="value">${draftCount}</div>
                <a href="${pageContext.request.contextPath}/admin/articles" class="card-link">Gérer les articles →</a>
            </div>
            <div class="dash-card">
                <h3>Total</h3>
                <div class="value">${totalCount}</div>
                <a href="${pageContext.request.contextPath}/admin/articles/add" class="card-link">Créer un article →</a>
            </div>
        </div>
    </main>
</div>
</body>
</html>
