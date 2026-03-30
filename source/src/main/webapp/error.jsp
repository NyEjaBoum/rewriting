<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur</title>
    <style>
        body {
            font-family: Inter, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }
        .error-code {
            font-size: 64px;
            font-weight: 800;
            color: #667eea;
            margin: 0;
        }
        .error-message {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin: 16px 0;
        }
        .error-description {
            font-size: 14px;
            color: #666;
            margin: 16px 0;
            line-height: 1.6;
        }
        .back-link {
            display: inline-block;
            margin-top: 24px;
            padding: 12px 24px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s;
        }
        .back-link:hover {
            background: #764ba2;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-code"><%= exception != null ? exception.getClass().getSimpleName() : "Erreur" %></h1>
        <p class="error-message">Une erreur s'est produite</p>
        <p class="error-description">
            <%= exception != null ? exception.getMessage() : "Nous avons rencontré un problème. Veuillez réessayer." %>
        </p>
        <a href="<%= request.getContextPath() %>/login" class="back-link">Retour à la connexion</a>
    </div>
</body>
</html>
