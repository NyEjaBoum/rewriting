<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Back-Office | Projet Iran 2026</title>
    <meta name="description" content="Interface d'administration pour la gestion des contenus du site.">
    <link rel="stylesheet" style="text/css" href="${pageContext.request.contextPath}/css/login-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
</head>
<body>

    <div class="login-container">
        <header class="login-header">
            <h1 class="logo">IRAN PULSE</h1>
            <p>Administration Panel</p>
        </header>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST" class="login-form">
            <div class="input-group">
                <label for="username">Identifiant</label>
                <input type="text" id="username" name="username" placeholder="admin" value="admin" required>
            </div>

            <div class="input-group">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" name="password" placeholder="Admin2026!" value="Admin2026!" required>
            </div>

            <button type="submit" class="login-button">Se connecter</button>
        </form>
    </div>

</body>
</html>
