<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${formTitle != null ? formTitle : 'Article'}"/></title>
    <link rel="stylesheet" href="/css/editor-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="admin-wrapper">
    <aside class="admin-sidebar">
        <div class="logo">VERTONEWS</div>
        <nav>
            <a href="#">Tableau de bord</a>
            <a href="#" class="active">Nouvel Article</a>
            <a href="#">Articles publiés</a>
            <a href="#">Paramètres</a>
        </nav>
    </aside>
    <main class="editor-main">
        <header class="editor-header">
            <h2><c:out value="${formTitle != null ? formTitle : 'Article'}"/></h2>
            <div class="header-actions">
                <button class="btn-secondary" type="button">Enregistrer brouillon</button>
                <button class="btn-primary" type="submit" form="articleForm">Publier l'article</button>
            </div>
        </header>
        <section class="editor-form">
            <form id="articleForm" action="${actionUrl}" method="post" onsubmit="beforeSubmit()">
                <c:if test="${not empty article.id}">
                    <input type="hidden" name="id" value="${article.id}">
                </c:if>
                <div class="form-section">
                    <div class="input-group">
                        <label for="titre">Titre de l'article (H1)</label>
                        <input type="text" id="titre" name="titre" placeholder="Entrez le titre ici..." value="${article.titre}" oninput="updateSlug()" required>
                    </div>
                    <div class="input-group">
                        <label for="slug">URL normalisée (Slug / Rewriting)</label>
                        <input type="text" id="slug" name="slug" placeholder="url-de-l-article" value="${article.slug}" readonly required>
                    </div>
                    <div class="input-group">
                        <label for="meta-desc">Méta Description (SEO)</label>
                        <textarea id="meta-desc" name="meta_description" rows="2" maxlength="160" placeholder="Résumé pour les moteurs de recherche...">${article.meta_description}</textarea>
                    </div>
                </div>
                <div class="toolbar">
                    <button type="button" onclick="execCmd('bold')"><strong>B</strong></button>
                    <button type="button" onclick="execCmd('italic')"><em>I</em></button>
                    <div class="divider"></div>
                    <button type="button" onclick="execCmd('formatBlock', 'h2')">H2</button>
                    <button type="button" onclick="execCmd('formatBlock', 'h3')">H3</button>
                    <div class="divider"></div>
                    <button type="button" onclick="execCmd('insertUnorderedList')">• Liste</button>
                </div>
                <div id="editor" contenteditable="true" placeholder="Commencez à écrire votre analyse sur le conflit...">${article.contenu_html}</div>
                <input type="hidden" name="contenu_html" id="contenu_html">
            </form>
        </section>
    </main>
</div>
<script>
    function execCmd(command, value = null) {
        document.execCommand(command, false, value);
    }
    function updateSlug() {
        var titre = document.getElementById('titre').value;
        var slug = titre.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
        document.getElementById('slug').value = slug;
    }
    function beforeSubmit() {
        document.getElementById('contenu_html').value = document.getElementById('editor').innerHTML;
    }
    window.onload = function() { updateSlug(); }
</script>
</body>
</html>
