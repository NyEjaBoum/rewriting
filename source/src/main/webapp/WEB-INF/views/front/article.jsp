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
    <meta name="description" content="<c:out value='${article.metaDescription}'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/article-public.css">
</head>
<body>
<fmt:setLocale value="fr_FR"/>

    <header class="site-header">
        <div class="header-content">
            <div class="header-left">
                <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
            </div>
            <h1 class="logo"><a href="${pageContext.request.contextPath}/">IRAN PULSE</a></h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/login">
                    <svg class="icon-svg user-icon" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg>
                </a>
            </div>
        </div>
    </header>

    <nav class="nav-bar">
        <ul class="categories">
            <li><a href="${pageContext.request.contextPath}/">Accueil</a></li>
            <li class="active">Actualités</li>
            <li>Politique</li>
            <li>Sport</li>
            <li>Économie</li>
            <li>Culture</li>
            <li>Technologie</li>
            <li>Sciences</li>
            <li>Santé</li>
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
                    <div class="author-img"></div>
                    <div class="meta-text">
                        <strong>Rédaction</strong>
                        <span>Publié le <fmt:formatDate value="${article.datePub}" pattern="d MMMM yyyy"/></span>
                    </div>
                </div>
            </header>

            <c:if test="${not empty images}">
                <figure class="main-figure">
                    <img src="${pageContext.request.contextPath}${images[0].urlPath}"
                         alt="<c:out value='${images[0].altText}'/>">
                    <c:if test="${not empty images[0].altText}">
                        <figcaption><c:out value="${images[0].altText}"/></figcaption>
                    </c:if>
                </figure>
            </c:if>

            <div class="post-content">
                ${article.contenuHtml}
            </div>

            <c:if test="${fn:length(images) > 1}">
                <section class="related-articles">
                    <h2 class="section-title">Images</h2>
                    <div class="related-grid">
                        <c:forEach var="image" items="${images}" begin="1">
                            <div class="related-card">
                                <div class="card-image">
                                    <img src="${pageContext.request.contextPath}${image.urlPath}"
                                         alt="<c:out value='${image.altText}'/>">
                                </div>
                                <div class="card-content">
                                    <p><c:out value="${image.altText}"/></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:if>
        </article>
    </main>

</body>
</html>
