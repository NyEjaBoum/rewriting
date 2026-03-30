<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
                        <c:choose>
                            <c:when test="${not empty article.datePub}">
                                <input type="date" id="date_pub" name="date_pub"
                                       value="<fmt:formatDate value="${article.datePub}" pattern="yyyy-MM-dd"/>">
                            </c:when>
                            <c:otherwise>
                                <jsp:useBean id="now" class="java.util.Date"/>
                                <input type="date" id="date_pub" name="date_pub"
                                       value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="input-group">
                        <label for="statut">Statut de l'article</label>
                        <select id="statut" name="statut" style="min-height:45px; font-size:16px; padding:10px 16px; border-radius:8px; border:1px solid #eee; background:#fff;">
                            <option value="BROUILLON" <c:if test="${article.statut == 'BROUILLON' || empty article.statut}">selected</c:if>>Brouillon</option>
                            <option value="PUBLIE" <c:if test="${article.statut == 'PUBLIE'}">selected</c:if>>Publié</option>
                        </select>
                    </div>
                </div>
                <div style="margin-bottom: 20px;">
                    <label for="rich-editor" style="display:block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #555;">Contenu de l'article</label>
                    <textarea id="rich-editor" name="contenu_html">${article.contenuHtml}</textarea>
                </div>
            </form>

            <%-- Section images : formulaire séparé (les forms imbriqués sont interdits en HTML) --%>
            <section class="form-section" style="margin-bottom: 30px;">
                <h3>Images</h3>
                <form action="${not empty article.id ? pageContext.request.contextPath.concat('/admin/articles/').concat(article.id).concat('/uploadImage') : ''}"
                      method="post" enctype="multipart/form-data" onsubmit="return validateImageForm()">
                    <div class="input-group">
                        <label for="imageFile">Fichier image</label>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*" required <c:if test="${empty article.id}">disabled</c:if>>
                    </div>
                    <div class="input-group">
                        <label for="altText">Texte alternatif (obligatoire)</label>
                        <input type="text" id="altText" name="altText" required <c:if test="${empty article.id}">disabled</c:if>>
                    </div>
                    <button type="submit" class="btn-primary" style="margin-top: 8px;" <c:if test="${empty article.id}">disabled</c:if>>Ajouter une image</button>
                    <c:if test="${empty article.id}">
                        <div style="color:#888; font-size:13px; margin-top:8px;">Vous pourrez ajouter des images après avoir créé l'article.</div>
                    </c:if>
                </form>

                <c:if test="${not empty images}">
                    <div style="margin-top:20px;">
                            <h4>Images associées :</h4>
                            <ul style="list-style:none; padding:0;">
                                <c:forEach var="img" items="${images}">
                                    <li style="margin-bottom:10px; display:flex; align-items:center; gap:10px;">
                                        <img src="${pageContext.request.contextPath}${img.urlPath}" alt="${img.altText}" style="max-height:60px; border:1px solid #ccc;">
                                        <span>${img.altText}</span>
                                        <form action="${pageContext.request.contextPath}/admin/articles/${article.id}/deleteImage/${img.id}"
                                              method="post" style="display:inline;">
                                            <button type="submit" class="btn-secondary"
                                                    onclick="return confirm('Supprimer cette image ?')">Supprimer</button>
                                        </form>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </section>
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
    function showPreview() {
        var titre = document.getElementById('titre').value;
        var editor = tinymce.get('rich-editor');
        var content = editor ? editor.getContent() : document.getElementById('rich-editor').value;
        document.getElementById('preview-titre').textContent = titre;
        document.getElementById('preview-content').innerHTML = content;
        document.getElementById('preview-overlay').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closePreview() {
        document.getElementById('preview-overlay').style.display = 'none';
        document.body.style.overflow = '';
    }

    function validateImageForm() {
        var file = document.getElementById('imageFile');
        var alt  = document.getElementById('altText');
        if (!file || !file.value) { alert('Veuillez choisir un fichier image.'); return false; }
        if (!alt  || !alt.value.trim()) { alert('Le texte alternatif est obligatoire.'); return false; }
        return true;
    }

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