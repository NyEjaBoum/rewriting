<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des articles</title>
    <link rel="stylesheet" href="/css/editor-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        .articles-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .articles-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .articles-table thead {
            background: #f5f5f5;
            font-weight: 700;
            border-bottom: 2px solid #eee;
        }
        .articles-table th {
            padding: 16px;
            text-align: left;
            font-size: 13px;
            text-transform: uppercase;
            color: #555;
        }
        .articles-table td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }
        .articles-table td:last-child {
            text-align: right;
        }
        .articles-table tbody tr:hover {
            background: #f9f9f9;
        }
        .btn-edit, .btn-delete {
            padding: 8px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 12px;
            cursor: pointer;
            border: none;
            margin-left: 8px;
        }
        .btn-edit {
            background: #000;
            color: #fff;
        }
        .btn-edit:hover {
            background: #333;
        }
        .btn-delete {
            background: #ff4444;
            color: #fff;
        }
        .btn-delete:hover {
            background: #cc0000;
        }
        .no-articles {
            text-align: center;
            padding: 40px;
            color: #888;
            font-size: 16px;
        }
        .message {
            padding: 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 600;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />
    
    <main class="editor-main">
        <header class="editor-header">
            <h2>Articles publiés</h2>
            <div class="header-actions">
                <a href="/admin/articles/add" class="btn-primary">+ Nouvel Article</a>
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
                        <a href="/admin/articles/add" class="btn-primary">Créer le premier article</a>
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
                                        <a href="/admin/articles/edit/${article.id}" class="btn-edit">Éditer</a>
                                        <a href="/admin/articles/delete/${article.id}" class="btn-delete" onclick="return confirm('Êtes-vous sûr ?')">Supprimer</a>
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
