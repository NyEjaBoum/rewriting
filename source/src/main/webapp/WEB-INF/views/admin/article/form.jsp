<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${formTitle != null ? formTitle : 'Article'}"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tiny.cloud/1/lvkaijv4dia4mvlq3yvfhmy2p7ng3xrugyqclql1apwcyqod/tinymce/6/tinymce.min.js"></script>
</head>
<body>
<div class="admin-wrapper">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />
    <main class="editor-main">
        <header class="editor-header">
            <h2><c:out value="${formTitle != null ? formTitle : 'Article'}"/></h2>
            <div class="header-actions">
                <button class="btn-secondary" type="button" onclick="showPreview()">Aperçu</button>
                <button class="btn-primary" type="submit" form="articleForm">Publier l'article</button>
            </div>
        </header>
        <section class="editor-form">
            <form id="articleForm" action="${actionUrl}" method="post" onsubmit="return beforeSubmit()">
                <c:if test="${not empty article.id}">
                    <input type="hidden" name="id" value="${article.id}">
                </c:if>
                <div class="form-section">
                    <div class="input-group">
                        <label for="titre">Titre de l'article (H1)</label>
                        <input type="text" id="titre" name="titre" placeholder="Entrez le titre ici..."
                               value="<c:out value='${article.titre}'/>" oninput="updateSlug()" required>
                    </div>
                    <div class="input-group">
                        <label for="slug">URL normalisée (Slug / Rewriting)</label>
                        <input type="text" id="slug" name="slug" placeholder="url-de-l-article"
                               value="<c:out value='${article.slug}'/>" readonly required>
                    </div>
                    <div class="input-group">
                        <label for="meta-desc">Méta Description (SEO)</label>
                        <textarea id="meta-desc" name="meta_description" rows="4" maxlength="160" placeholder="Résumé pour les moteurs de recherche..." style="min-height:70px; font-size:16px; padding:16px; border-radius:8px; border:1px solid #eee; background:#fff;">${article.metaDescription}</textarea>
                    </div>
                    <div class="input-group">
                        <label for="date_pub">Date de publication</label>
                        <input type="date" id="date_pub" name="date_pub" value="${article.datePub}">
                    </div>
                </div>
                <div style="margin-bottom: 20px;">
                    <label for="rich-editor" style="display:block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #555;">Contenu de l'article</label>
                    <textarea id="rich-editor" name="contenu_html">${article.contenuHtml}</textarea>
                </div>
            </form>
        </section>

        <!-- Aperçu -->
        <div id="preview-overlay" style="display:none;">
            <div id="preview-box">
                <button onclick="closePreview()" id="preview-close">✕ Fermer</button>
                <h1 id="preview-titre"></h1>
                <div id="preview-content"></div>
            </div>
        </div>
    </main>
</div>

<script>
    function updateSlug() {
        var titre = document.getElementById('titre').value;
        var slug = titre.toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '') // accents
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/(^-|-$)/g, '');
        document.getElementById('slug').value = slug;
    }

    function beforeSubmit() {
        var editor = tinymce.get('rich-editor');
        var contenuHtml = editor.getContent();
        var titre = document.getElementById('titre').value;

        if (!/^<h1>/i.test(contenuHtml)) {
            contenuHtml = '<h1>' + titre + '</h1>' + contenuHtml;
            editor.setContent(contenuHtml);
        }
        editor.save();
    }

    // Initialiser TinyMCE
    tinymce.init({
        selector: '#rich-editor',
        height: 400,
        menubar: false,
        toolbar: 'bold italic underline | h2 h3 | bullist numlist | link | undo redo',
        plugins: 'link lists',
        forced_root_blocks: 'p',
        valid_elements: 'h1,h2,h3,p,strong,em,u,ul,ol,li,br,a[href],span[style]',
        content_style: 'body { font-family: Inter, sans-serif; font-size: 16px; line-height: 1.7; }',
        branding: false,
        setup: function(editor) {
            editor.on('init', function() {
                var content = editor.getContent();
                var titre = document.getElementById('titre').value;
                if (!/^<h1>/i.test(content) && titre) {
                    editor.setContent('<h1>' + titre + '</h1>' + content);
                }
            });
        }
    });

    window.onload = function() {
        updateSlug();
    };
</script>
</body>
</html>