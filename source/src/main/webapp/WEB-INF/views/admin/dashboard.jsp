<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord</title>
    <link rel="stylesheet" href="/css/editor-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 40px;
        }
        .card {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #eee;
        }
        .card h3 {
            font-size: 14px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 10px;
            font-weight: 700;
        }
        .card-value {
            font-size: 36px;
            font-weight: 800;
            color: #000;
            margin-bottom: 15px;
        }
        .card-link {
            text-decoration: none;
            color: #000;
            font-weight: 600;
            font-size: 13px;
            border-bottom: 2px solid #000;
            padding-bottom: 2px;
        }
        .card-link:hover {
            opacity: 0.7;
        }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />
    
    <main class="editor-main">
        <header class="editor-header">
            <h2>Tableau de bord</h2>
        </header>

        <section class="dashboard-container">
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Articles publiés</h3>
                    <div class="card-value">${articlesCount}</div>
                    <a href="/admin/articles" class="card-link">Voir tous les articles →</a>
                </div>
                <div class="card">
                    <h3>Nouvel Article</h3>
                    <div class="card-value">+</div>
                    <a href="/admin/articles/add" class="card-link">Créer un article →</a>
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
