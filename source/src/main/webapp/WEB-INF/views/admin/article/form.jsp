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
                        <textarea id="meta-desc" name="meta_description" rows="4" maxlength="160" placeholder="Résumé pour les moteurs de recherche..." style="min-height:70px; font-size:16px; padding:16px; border-radius:8px; border:1px solid #eee; background:#fff;">${article.meta_description}</textarea>
                    </div>
                </div>
                <div class="toolbar">
                    <button type="button" id="btn-bold" onclick="execCmd('bold')"><strong>B</strong></button>
                    <button type="button" id="btn-italic" onclick="execCmd('italic')"><em>I</em></button>
                    <div class="divider"></div>
                    <button type="button" id="btn-h2" onclick="execCmd('formatBlock', 'h2')">H2</button>
                    <button type="button" id="btn-h3" onclick="execCmd('formatBlock', 'h3')">H3</button>
                    <div class="divider"></div>
                    <button type="button" id="btn-ul" onclick="execCmd('insertUnorderedList')">• Liste</button>
                </div>
                <div id="rich-editor" contenteditable="true" placeholder="Commencez à écrire votre analyse sur le conflit...">${article.contenu_html}</div>
                <div id="rich-editor" contenteditable="true" placeholder="Commencez à écrire votre analyse sur le conflit..."></div>
                <input type="hidden" name="contenu_html" id="contenu_html">
            </form>
        </section>
    </main>
</div>
<style>
    .toolbar button.active {
        background: #000;
        color: #fff;
        font-weight: 700;
    }
</style>
<script>
    function execCmd(command, value = null) {
        document.execCommand(command, false, value);
        setTimeout(updateToolbarState, 0);
    }
    function updateSlug() {
        var titre = document.getElementById('titre').value;
        var slug = titre.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
        document.getElementById('slug').value = slug;
    }
    function beforeSubmit() {
        document.getElementById('contenu_html').value = document.getElementById('editor').innerHTML;
    }
    // Met à jour l'état visuel des boutons selon la sélection
    function updateToolbarState() {
        document.getElementById('btn-bold').classList.toggle('active', document.queryCommandState('bold'));
        document.getElementById('btn-italic').classList.toggle('active', document.queryCommandState('italic'));
        // Pour H2/H3, on regarde le formatBlock
        let sel = window.getSelection();
        let node = sel.anchorNode;
        while (node && node.nodeType !== 1) node = node.parentNode;
        let tag = node ? node.tagName : '';
        document.getElementById('btn-h2').classList.toggle('active', tag === 'H2');
        document.getElementById('btn-h3').classList.toggle('active', tag === 'H3');
        document.getElementById('btn-ul').classList.toggle('active', document.queryCommandState('insertUnorderedList'));
    }
    document.addEventListener('selectionchange', function() {
        if (document.activeElement === document.getElementById('editor')) {
            updateToolbarState();
        }
    });
    window.onload = function() { updateSlug(); updateToolbarState(); };
</script>
</body>
</html>
