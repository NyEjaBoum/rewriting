<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${article.titre}</title>
    <meta name="description" content="${article.metaDescription}">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .article-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .back-link {
            text-decoration: none;
            color: #666;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 20px;
            display: inline-block;
        }
        .back-link:hover { color: #000; }
        .article-header {
            margin-bottom: 40px;
        }
        .article-header h1 {
            font-size: 48px;
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 20px;
        }
        .article-meta {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            font-size: 13px;
            color: #888;
        }
        .article-content {
            font-size: 18px;
            line-height: 1.7;
            color: #333;
        }
        .article-content h2 {
            margin: 40px 0 20px 0;
            font-size: 28px;
            font-weight: 800;
        }
        .article-content h3 {
            margin: 30px 0 15px 0;
            font-size: 22px;
            font-weight: 700;
        }
        .article-content p {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="article-container">
    <a href="/admin/articles" class="back-link">← Retour à la liste</a>

    <article class="article-header">
        <h1>${article.titre}</h1>
        <div class="article-meta">
            <span>Publié le <strong><c:out value="${article.datePub}" /></strong></span>
        </div>
    </article>

    <div class="article-content">
        ${article.contenuHtml}
    </div>
</div>
</body>
</html>
