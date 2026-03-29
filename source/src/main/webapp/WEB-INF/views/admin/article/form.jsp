<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${formTitle != null ? formTitle : 'Article'}"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor-style.css">
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
                        <textarea id="meta-desc" name="meta_description" rows="4" maxlength="160"
                                  placeholder="Résumé pour les moteurs de recherche..."
                                  style="min-height:70px; font-size:16px; padding:16px; border-radius:8px; border:1px solid #eee; background:#fff;"><c:out value='${article.meta_description}'/></textarea>
                    </div>
                </div>
                <div class="toolbar">
                    <button type="button" id="btn-bold"   onclick="execCmd('bold')"><strong>B</strong></button>
                    <button type="button" id="btn-italic" onclick="execCmd('italic')"><em>I</em></button>
                    <div class="divider"></div>
                    <button type="button" id="btn-h2"     onclick="execCmd('formatBlock', 'h2')">H2</button>
                    <button type="button" id="btn-h3"     onclick="execCmd('formatBlock', 'h3')">H3</button>
                    <div class="divider"></div>
                    <button type="button" id="btn-ul"     onclick="execCmd('insertUnorderedList')">• Liste</button>
                </div>
                <div id="rich-editor" contenteditable="true"
                     placeholder="Commencez à écrire votre analyse..."></div>
                <input type="hidden" name="contenu_html" id="contenu_html">
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

<style>
    .toolbar button.active { background:#000; color:#fff; font-weight:700; }
    #preview-overlay {
        position:fixed; inset:0; background:rgba(0,0,0,.5);
        display:flex; align-items:center; justify-content:center; z-index:1000;
    }
    #preview-box {
        background:#fff; border-radius:16px; padding:40px;
        max-width:720px; width:90%; max-height:80vh; overflow-y:auto;
    }
    #preview-close {
        float:right; border:none; background:#eee; border-radius:8px;
        padding:6px 14px; cursor:pointer; font-size:13px; margin-bottom:16px;
    }
</style>

<script>
    // ── Données de pré-remplissage injectées côté serveur ──────────────────
    var contenuExistant = "<c:out value='${article.contenu_html}' escapeXml='false'/>";

    // ── Initialisation ─────────────────────────────────────────────────────
    window.onload = function () {
        // Pré-remplir l'éditeur en mode édition
        if (contenuExistant.trim() !== '') {
            document.getElementById('rich-editor').innerHTML = contenuExistant;
        }
        // Générer le slug uniquement si aucun slug n'existe encore
        if (document.getElementById('slug').value === '') {
            updateSlug();
        }
        updateToolbarState();
    };

    // ── Commandes de formatage ─────────────────────────────────────────────
    function execCmd(command, value) {
        document.execCommand(command, false, value || null);
        setTimeout(updateToolbarState, 0);
    }

    // ── Slug ───────────────────────────────────────────────────────────────
    function updateSlug() {
        var titre = document.getElementById('titre').value;
        var slug = titre.toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '') // accents
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/(^-|-$)/g, '');
        document.getElementById('slug').value = slug;
    }

    // ── Avant soumission ───────────────────────────────────────────────────
    function beforeSubmit() {
        var titre   = document.getElementById('titre').value.trim();
        var contenu = document.getElementById('rich-editor').innerHTML.trim();

        if (titre === '') {
            alert('Le titre est obligatoire.');
            return false;
        }
        if (contenu === '' || contenu === '<br>') {
            alert('Le contenu est obligatoire.');
            return false;
        }

        document.getElementById('contenu_html').value = contenu;
        return true;
    }

    // ── Aperçu ─────────────────────────────────────────────────────────────
    function showPreview() {
        document.getElementById('preview-titre').textContent =
            document.getElementById('titre').value || '(sans titre)';
        document.getElementById('preview-content').innerHTML =
            document.getElementById('rich-editor').innerHTML;
        document.getElementById('preview-overlay').style.display = 'flex';
    }

    function closePreview() {
        document.getElementById('preview-overlay').style.display = 'none';
    }

    // ── État visuel de la toolbar ──────────────────────────────────────────
    function updateToolbarState() {
        document.getElementById('btn-bold').classList.toggle('active',   document.queryCommandState('bold'));
        document.getElementById('btn-italic').classList.toggle('active', document.queryCommandState('italic'));
        var sel  = window.getSelection();
        var node = sel.anchorNode;
        while (node && node.nodeType !== 1) node = node.parentNode;
        var tag  = node ? node.tagName : '';
        document.getElementById('btn-h2').classList.toggle('active', tag === 'H2');
        document.getElementById('btn-h3').classList.toggle('active', tag === 'H3');
        document.getElementById('btn-ul').classList.toggle('active', document.queryCommandState('insertUnorderedList'));
    }

    document.addEventListener('selectionchange', function () {
        if (document.activeElement === document.getElementById('rich-editor')) {
            updateToolbarState();
        }
    });
</script>
</body>
</html>
