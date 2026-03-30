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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<fmt:setLocale value="fr_FR"/>

    <main class="article-container">
        <nav class="article-nav">
            <a href="${pageContext.request.contextPath}/" class="back-link">← Retour aux actualités</a>
        </nav>

        <article class="full-post">
            <header class="post-header">
                <span class="category-badge">Actualités</span>
                <h1>${article.titre}</h1>
                <div class="post-meta">
                    <img src="https://i.pravatar.cc/100?u=redaction" alt="" class="author-avatar">
                    <div class="meta-text">
                        <strong>Par la Rédaction</strong>
                        <span>Publié le <fmt:formatDate value="${article.datePub}" pattern="EEEE d MMMM yyyy"/></span>
                    </div>
                </div>
            </header>

            <c:if test="${not empty images}">
                <figure class="main-figure">
                    <c:set var="mainImgSrc" value="${images[0].urlPath}"/>
                    <img src="${fn:startsWith(mainImgSrc,'http') ? mainImgSrc : pageContext.request.contextPath.concat(mainImgSrc)}"
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
                <div class="article-gallery">
                    <c:forEach var="img" items="${images}" begin="1">
                        <c:set var="galImgSrc" value="${img.urlPath}"/>
                        <figure class="gallery-item">
                            <img src="${fn:startsWith(galImgSrc,'http') ? galImgSrc : pageContext.request.contextPath.concat(galImgSrc)}"
                                 alt="<c:out value='${img.altText}'/>">
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
                                                 alt="<c:out value='${related.images[0].altText}'/>">
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
