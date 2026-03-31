<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${article.titre}"/> | Iran Pulse</title>
    <meta name="description" content="<c:out value='${not empty article.metaDescription ? article.metaDescription : metaFallback}'/>">
    <meta property="og:type" content="article">
    <meta property="og:title" content="<c:out value='${article.titre}'/>">
    <meta property="og:description" content="<c:out value='${not empty article.metaDescription ? article.metaDescription : metaFallback}'/>">
    <c:if test="${not empty images}">
        <c:set var="ogImg" value="${images[0].urlPath}"/>
        <meta property="og:image" content="${fn:startsWith(ogImg,'http') ? ogImg : pageContext.request.contextPath.concat(ogImg)}">
    </c:if>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
</head>
<body>
<fmt:setLocale value="fr_FR"/>

    <header class="site-header">
        <div class="header-content">
            <div class="header-left">
                <button class="icon-btn" aria-label="Rechercher">
                    <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </button>
                <button class="icon-btn" aria-label="Menu">
                    <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
                </button>
            </div>
            <h1 class="logo"><a href="${pageContext.request.contextPath}/">IRAN PULSE</a></h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/login" aria-label="Se connecter">
                    <svg class="icon-svg user-icon" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg>
                </a>
            </div>
        </div>
    </header>

    <nav class="nav-bar">
        <ul class="categories">
            <li><a href="${pageContext.request.contextPath}/">Accueil</a></li>
            <li>Actualités</li>
            <li>Conflit armé</li>
            <li>Géopolitique</li>
            <li>Diplomatie</li>
            <li>Économie</li>
            <li>Humanitaire</li>
            <li>Analyses</li>
        </ul>
    </nav>

    <main class="article-container">
        <nav class="article-nav">
            <a href="${pageContext.request.contextPath}/" class="back-link">← Retour aux actualités</a>
        </nav>

        <article class="full-post">
            <header class="post-header">
                <span class="category-badge">Actualités</span>
                <h1>${article.titre}</h1>
                <div class="post-meta">
                    <img src="https://i.pravatar.cc/100?u=${article.auteurNom}" alt="${article.auteurNom}" class="author-avatar">
                    <div class="meta-text">
                        <strong>Par <c:out value="${not empty article.auteurNom ? article.auteurNom : 'Rédaction'}"/></strong>
                        <span>Publié le <fmt:formatDate value="${article.datePub}" pattern="EEEE d MMMM yyyy"/></span>
                    </div>
                </div>
            </header>

            <c:if test="${not empty images}">
                <figure class="main-figure">
                    <c:set var="mainImgSrc" value="${images[0].urlPath}"/>
                    <img src="${fn:startsWith(mainImgSrc,'http') ? mainImgSrc : pageContext.request.contextPath.concat(mainImgSrc)}"
                         alt="<c:out value='${images[0].altText}'/>" fetchpriority="high">
                    <c:if test="${not empty images[0].altText}">
                        <figcaption><c:out value="${images[0].altText}"/></figcaption>
                    </c:if>
                </figure>
            </c:if>

            <div class="post-content">
                ${article.contenuHtml}
            </div>

            <c:if test="${fn:length(images) > 1}">
                <div class="article-gallery">
                    <c:forEach var="img" items="${images}" begin="1">
                        <c:set var="galImgSrc" value="${img.urlPath}"/>
                        <figure class="gallery-item">
                            <img src="${fn:startsWith(galImgSrc,'http') ? galImgSrc : pageContext.request.contextPath.concat(galImgSrc)}"
                                 alt="<c:out value='${img.altText}'/>" loading="lazy">
                            <c:if test="${not empty img.altText}">
                                <figcaption><c:out value="${img.altText}"/></figcaption>
                            </c:if>
                        </figure>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${not empty relatedArticles}">
                <section class="related-articles">
                    <h2 class="section-title">À lire aussi</h2>
                    <div class="related-grid">
                        <c:forEach var="related" items="${relatedArticles}">
                            <a href="${pageContext.request.contextPath}/article/${related.slug}" class="related-card">
                                <div class="card-image">
                                    <c:choose>
                                        <c:when test="${not empty related.images}">
                                            <c:set var="relImgSrc" value="${related.images[0].urlPath}"/>
                                            <img src="${fn:startsWith(relImgSrc,'http') ? relImgSrc : pageContext.request.contextPath.concat(relImgSrc)}"
                                                 alt="<c:out value='${related.images[0].altText}'/>" loading="lazy">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="card-image-placeholder"></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-content">
                                    <span class="card-category">Actualités</span>
                                    <p><c:out value="${related.titre}"/></p>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </section>
            </c:if>
        </article>
    </main>

</body>
</html>
