<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${article.titre} - Blog Rewriting</title>
    <meta name="description" content="${article.metaDescription}">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Georgia', serif;
            line-height: 1.8;
            color: #333;
            background-color: #f5f5f5;
        }
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            margin-bottom: 40px;
        }
        header .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }
        header h1 {
            font-size: 1.8em;
        }
        header h1 a {
            color: white;
            text-decoration: none;
        }
        header h1 a:hover {
            opacity: 0.8;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px 40px;
        }
        .back-link {
            margin-bottom: 20px;
        }
        .back-link a {
            color: #3498db;
            text-decoration: none;
            font-size: 0.95em;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        article {
            background: white;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .article-header {
            margin-bottom: 40px;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 20px;
        }
        .article-title {
            font-size: 2.5em;
            color: #2c3e50;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        .article-meta {
            color: #7f8c8d;
            font-size: 1em;
        }
        .article-content {
            font-size: 1.1em;
            line-height: 1.8;
        }
        .article-content h1 {
            font-size: 2em;
            color: #2c3e50;
            margin: 30px 0 20px;
        }
        .article-content h2 {
            font-size: 1.6em;
            color: #34495e;
            margin: 25px 0 15px;
        }
        .article-content h3 {
            font-size: 1.3em;
            color: #34495e;
            margin: 20px 0 10px;
        }
        .article-content p {
            margin-bottom: 20px;
        }
        .article-content ul, .article-content ol {
            margin-bottom: 20px;
            padding-left: 30px;
        }
        .article-content li {
            margin-bottom: 8px;
        }
        .article-content a {
            color: #3498db;
            text-decoration: none;
        }
        .article-content a:hover {
            text-decoration: underline;
        }
        .article-content blockquote {
            border-left: 4px solid #3498db;
            padding-left: 20px;
            margin: 20px 0;
            color: #555;
            font-style: italic;
        }
        .article-content code {
            background-color: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
        }
        .article-content pre {
            background-color: #f4f4f4;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            margin-bottom: 20px;
        }
        .article-images {
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #ecf0f1;
        }
        .article-images h3 {
            font-size: 1.4em;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .images-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .image-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .image-item img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .image-item p {
            color: #7f8c8d;
            font-size: 0.9em;
            font-style: italic;
        }
        @media (max-width: 768px) {
            article {
                padding: 30px 20px;
            }
            .article-title {
                font-size: 2em;
            }
            .article-content {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1><a href="${pageContext.request.contextPath}/">Blog Rewriting</a></h1>
        </div>
    </header>

    <div class="container">
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/">← Retour à l'accueil</a>
        </div>

        <article>
            <div class="article-header">
                <h1 class="article-title">${article.titre}</h1>
                <div class="article-meta">
                    Publié le ${article.datePub}
                </div>
            </div>

            <div class="article-content">
                ${article.contenuHtml}
            </div>

            <c:if test="${not empty article.images}">
                <div class="article-images">
                    <h3>Images</h3>
                    <div class="images-grid">
                        <c:forEach var="image" items="${article.images}">
                            <div class="image-item">
                                <img src="${pageContext.request.contextPath}${image.urlPath}"
                                     alt="${image.altText}">
                                <p>${image.altText}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </article>
    </div>
</body>
</html>
