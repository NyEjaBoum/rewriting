<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page non trouvée - Blog Rewriting</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Georgia', serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 20px;
            text-align: center;
        }
        .error-box {
            background: white;
            padding: 60px 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .error-code {
            font-size: 8em;
            font-weight: bold;
            color: #e74c3c;
            line-height: 1;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 2em;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.1em;
            color: #7f8c8d;
            margin-bottom: 30px;
        }
        .home-link {
            display: inline-block;
            padding: 15px 30px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
        }
        .home-link:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-box">
            <div class="error-code">404</div>
            <h1>Page non trouvée</h1>
            <p>Désolé, l'article que vous recherchez n'existe pas ou n'est pas disponible.</p>
            <a href="${pageContext.request.contextPath}/" class="home-link">Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
