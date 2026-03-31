<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${formTitle != null ? formTitle : 'Article'}"/> | Iran Pulse</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor-style.css">
    <script src="https://cdn.tiny.cloud/1/lvkaijv4dia4mvlq3yvfhmy2p7ng3xrugyqclql1apwcyqod/tinymce/6/tinymce.min.js"></script>
    <style>
        /* Surcharges pour le layout éditeur dans admin-layout */
        .main-content { max-width: 1100px; }
        .editor-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .editor-header h2 { font-size: 26px; font-weight: 800; }
        .header-actions { display: flex; gap: 12px; }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-grid.triple { grid-template-columns: 1fr 1fr 1fr; }

        .input-group { margin-bottom: 0; }
        .input-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #555; }
        .input-group input, .input-group textarea, .input-group select {
            width: 100%; padding: 12px; border: 1px solid #eee; border-radius: 10px;
            font-family: inherit; font-size: 15px; background: #fff; color: #1a1a1a;
        }
        .input-group input[readonly] { background: #f9f9f9; color: #888; border-style: dashed; }
        .input-group textarea { resize: vertical; }

        .editor-section { margin-bottom: 32px; }
        .editor-section-title { font-size: 13px; font-weight: 600; color: #555; margin-bottom: 12px; }

        /* Images section */
        .images-section { background: #fff; border: 1px solid #eee; border-radius: 16px; padding: 28px; margin-top: 32px; }
        .images-section h3 { font-size: 16px; font-weight: 700; margin-bottom: 20px; }
        .images-grid { display: flex; flex-wrap: wrap; gap: 16px; margin-top: 16px; }
        .image-item {
            display: flex; align-items: center; gap: 12px;
            background: #fafafa; border: 1px solid #eee; border-radius: 12px; padding: 12px 16px;
        }
        .image-item img { height: 60px; width: 80px; object-fit: cover; border-radius: 8px; }
        .image-item span { font-size: 13px; color: #666; flex: 1; }

        .upload-row { display: grid; grid-template-columns: 1fr 1fr auto; gap: 16px; align-items: end; }
        .upload-row .input-group { margin-bottom: 0; }

        .disabled-notice { color: #aaa; font-size: 13px; margin-top: 8px; }

        /* Messages */
        .message { padding: 14px 20px; border-radius: 12px; font-weight: 600; margin-bottom: 24px; }
    </style>
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/navbar.jsp" />

    <main class="main-content">
        <header class="editor-header">
            <h2><c:out value="${formTitle != null ? formTitle : 'Article'}"/></h2>
            <div class="header-actions">
                <button class="btn-secondary" type="button" onclick="showPreview()">Aperçu</button>
                <button class="btn-primary" type="submit" form="articleForm">
                    <c:choose>
                        <c:when test="${not empty article.id}">Enregistrer les modifications</c:when>
                        <c:otherwise>Publier l'article</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </header>

        <c:if test="${not empty success}">
            <div class="message success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>

        <%-- Formulaire principal article --%>
        <form id="articleForm" action="${actionUrl}" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">
            <c:if test="${not empty article.id}">
                <input type="hidden" name="id" value="${article.id}">
            </c:if>

            <%-- Ligne 1 : Titre + Slug --%>
            <div class="form-grid" style="margin-bottom: 20px;">
                <div class="input-group">
                    <label for="titre">Titre de l'article (H1)</label>
                    <input type="text" id="titre" name="titre"
                           placeholder="Titre accrocheur..."
                           value="<c:out value='${article.titre}'/>"
                           oninput="updateSlug()" required>
                </div>
                <div class="input-group">
                    <label for="slug">Slug (URL Rewriting)</label>
                    <input type="text" id="slug" name="slug"
                           placeholder="url-de-l-article"
                           value="<c:out value='${article.slug}'/>"
                           readonly required>
                </div>
            </div>

            <%-- Ligne 2 : Date + Statut --%>
            <div class="form-grid" style="margin-bottom: 20px;">
                <div class="input-group">
                    <label for="date_pub">Date de publication</label>
                    <c:choose>
                        <c:when test="${not empty article.datePub}">
                            <input type="date" id="date_pub" name="date_pub"
                                   value="<fmt:formatDate value='${article.datePub}' pattern='yyyy-MM-dd'/>">
                        </c:when>
                        <c:otherwise>
                            <jsp:useBean id="now" class="java.util.Date"/>
                            <input type="date" id="date_pub" name="date_pub"
                                   value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="input-group">
                    <label for="statut">Statut</label>
                    <select id="statut" name="statut">
                        <option value="BROUILLON" <c:if test="${article.statut == 'BROUILLON' || empty article.statut}">selected</c:if>>Brouillon</option>
                        <option value="PUBLIE"    <c:if test="${article.statut == 'PUBLIE'}">selected</c:if>>Publié</option>
                    </select>
                </div>
            </div>

            <%-- Méta description --%>
            <div class="input-group" style="margin-bottom: 24px;">
                <label for="meta-desc">Méta Description (SEO)</label>
                <textarea id="meta-desc" name="meta_description" rows="2"
                          maxlength="160"
                          placeholder="Résumé pour les moteurs de recherche (max 160 caractères)...">${article.metaDescription}</textarea>
            </div>

            <%-- Éditeur de contenu --%>
            <div class="editor-section">
                <div class="editor-section-title">Contenu de l'article</div>
                <textarea id="rich-editor" name="contenu_html">${article.contenuHtml}</textarea>
            </div>
        </form>

        <%-- Section images --%>
        <div class="images-section">
            <h3>Image de couverture</h3>

            <c:choose>
                <c:when test="${empty article.id}">
                    <%-- Création : champs image directement dans le formulaire principal --%>
                    <div class="upload-row" id="upload-row-create">
                        <div class="input-group">
                            <label>Fichier image <span style="color:#aaa;font-weight:400;">(optionnel)</span></label>
                            <div class="file-upload-wrapper">
                                <label for="imageFile" class="custom-file-upload">Choisir une image</label>
                                <input type="file" id="imageFile" name="imageFile" accept="image/*"
                                       form="articleForm"
                                       onchange="previewImage(this); syncAltPlaceholder(this); updateFileName(this, 'file-name-create')">
                                <span id="file-name-create" class="file-name">Aucun fichier choisi</span>
                            </div>
                        </div>
                        <div class="input-group">
                            <label for="altText">Texte alternatif (SEO)</label>
                            <input type="text" id="altText" name="altText"
                                   placeholder="Description de l'image..."
                                   form="articleForm">
                        </div>
                    </div>
                    <div id="image-preview-wrap" style="display:none; margin-top:16px;">
                        <img id="image-preview" src="" alt="Aperçu"
                             style="max-height:180px; border-radius:12px; border:1px solid #eee; object-fit:cover;">
                        <button type="button" onclick="clearImagePreview()"
                                style="display:block; margin-top:8px; background:none; border:none; color:#ef4444; cursor:pointer; font-size:13px; font-weight:600;">✕ Supprimer l'image</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- Édition : champs associés au formulaire principal via form="articleForm" --%>
                    <div class="upload-row">
                        <div class="input-group">
                            <label>Fichier image <span style="color:#aaa;font-weight:400;">(optionnel)</span></label>
                            <div class="file-upload-wrapper">
                                <label for="imageFile" class="custom-file-upload">Choisir une image</label>
                                <input type="file" id="imageFile" name="imageFile" accept="image/*"
                                       form="articleForm"
                                       onchange="previewImage(this); syncAltPlaceholder(this); updateFileName(this, 'file-name-edit')">
                                <span id="file-name-edit" class="file-name">Aucun fichier choisi</span>
                            </div>
                        </div>
                        <div class="input-group">
                            <label for="altText">Texte alternatif (SEO)</label>
                            <input type="text" id="altText" name="altText"
                                   placeholder="Description de l'image..."
                                   form="articleForm">
                        </div>
                    </div>
                    <div id="image-preview-wrap" style="display:none; margin-top:16px;">
                        <img id="image-preview" src="" alt="Aperçu"
                             style="max-height:180px; border-radius:12px; border:1px solid #eee; object-fit:cover;">
                        <button type="button" onclick="clearImagePreview()"
                                style="display:block; margin-top:8px; background:none; border:none; color:#ef4444; cursor:pointer; font-size:13px; font-weight:600;">✕ Annuler</button>
                    </div>

                    <c:if test="${not empty images}">
                        <div class="images-grid">
                            <c:forEach var="img" items="${images}">
                                <div class="image-item">
                                    <img src="${pageContext.request.contextPath}${img.urlPath}"
                                         alt="<c:out value='${img.altText}'/>">
                                    <span><c:out value="${img.altText}"/></span>
                                    <form action="${pageContext.request.contextPath}/admin/articles/${article.id}/deleteImage/${img.id}"
                                          method="post" style="display:inline;">
                                        <button type="submit" class="btn-icon btn-danger"
                                                onclick="return confirm('Supprimer cette image ?')"
                                                title="Supprimer">🗑</button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Aperçu --%>
        <div id="preview-overlay" style="display:none;">
            <div id="preview-box">
                <button onclick="closePreview()" id="preview-close">✕ Fermer</button>
                <h1 id="preview-titre"></h1>
                <c:choose>
                    <c:when test="${not empty images}">
                        <img id="preview-cover-img"
                             data-src="${pageContext.request.contextPath}${images[0].urlPath}"
                             src="" alt=""
                             style="display:none; width:100%; max-height:340px; object-fit:cover; border-radius:12px; margin: 20px 0 28px;">
                    </c:when>
                    <c:otherwise>
                        <img id="preview-cover-img" src="" alt=""
                             style="display:none; width:100%; max-height:340px; object-fit:cover; border-radius:12px; margin: 20px 0 28px;">
                    </c:otherwise>
                </c:choose>
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

        // Image : aperçu local (création) ou image déjà enregistrée (édition)
        var previewImg = document.getElementById('preview-cover-img');
        var localPreview = document.getElementById('image-preview');
        if (localPreview && localPreview.src && localPreview.src !== window.location.href) {
            previewImg.src = localPreview.src;
            previewImg.style.display = 'block';
        } else if (previewImg.dataset.src) {
            previewImg.src = previewImg.dataset.src;
            previewImg.style.display = 'block';
        } else {
            previewImg.style.display = 'none';
        }

        document.getElementById('preview-overlay').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closePreview() {
        document.getElementById('preview-overlay').style.display = 'none';
        document.body.style.overflow = '';
    }

    function previewImage(input) {
        var wrap = document.getElementById('image-preview-wrap');
        var preview = document.getElementById('image-preview');
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                wrap.style.display = 'block';
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function clearImagePreview() {
        document.getElementById('imageFile').value = '';
        document.getElementById('image-preview-wrap').style.display = 'none';
        document.getElementById('image-preview').src = '';
    }

    function updateFileName(input, spanId) {
        var span = document.getElementById(spanId);
        if (span) span.textContent = input.files[0] ? input.files[0].name : 'Aucun fichier choisi';
    }

    function syncAltPlaceholder(input) {
        // Pré-remplir l'alt text avec le nom du fichier si vide
        var altInput = document.getElementById('altText');
        if (altInput && !altInput.value && input.files && input.files[0]) {
            var name = input.files[0].name.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' ');
            altInput.placeholder = name;
        }
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
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/(^-|-$)/g, '');
        document.getElementById('slug').value = slug;
    }

    function beforeSubmit() {
        var editor = tinymce.get('rich-editor');
        if (!editor) return true;
        var contenuHtml = editor.getContent();
        var titre = document.getElementById('titre').value;
        if (!/^<h1>/i.test(contenuHtml)) {
            contenuHtml = '<h1>' + titre + '</h1>' + contenuHtml;
            editor.setContent(contenuHtml);
        }
        editor.save();
        return true;
    }

    tinymce.init({
        selector: '#rich-editor',
        height: 420,
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

    window.onload = function() { updateSlug(); };
</script>
</body>
</html>
