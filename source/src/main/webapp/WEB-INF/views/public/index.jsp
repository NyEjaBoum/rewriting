<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iran Pulse | Actualités</title>
    <meta name="description" content="Iran Pulse — Suivez en temps réel le conflit en Iran : analyses géopolitiques, diplomatie, économie de guerre et situation humanitaire.">
    <meta property="og:type" content="website">
    <meta property="og:title" content="Iran Pulse | Actualités">
    <meta property="og:description" content="Iran Pulse — Suivez en temps réel le conflit en Iran : analyses géopolitiques, diplomatie, économie de guerre et situation humanitaire.">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></noscript>
</head>
<body>

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
            <li class="active">Accueil</li>
            <li>Actualités</li>
            <li>Conflit armé</li>
            <li>Géopolitique</li>
            <li>Diplomatie</li>
            <li>Économie</li>
            <li>Humanitaire</li>
            <li>Analyses</li>
        </ul>
    </nav>

    <main class="main-wrapper">
        <c:choose>
            <c:when test="${not empty articles}">
                <%-- Grille d'articles --%>
                <div class="articles-grid">
                    <c:forEach var="article" items="${articles}" varStatus="loop">
                        <article class="article-card">
                            <%-- Image principale ou placeholder --%>
                            <c:choose>
                                <c:when test="${not empty article.images}">
                                    <c:set var="imgSrc" value="${article.images[0].urlPath}"/>
                                    <c:choose>
                                        <c:when test="${loop.first}">
                                            <img src="${fn:startsWith(imgSrc,'http') ? imgSrc : pageContext.request.contextPath.concat(imgSrc)}"
                                                 alt="<c:out value='${article.images[0].altText}'/>"
                                                 class="article-card-image" fetchpriority="high">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${fn:startsWith(imgSrc,'http') ? imgSrc : pageContext.request.contextPath.concat(imgSrc)}"
                                                 alt="<c:out value='${article.images[0].altText}'/>"
                                                 class="article-card-image" loading="lazy">
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <div class="article-card-placeholder">
                                        ${fn:substring(article.titre, 0, 1)}
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <%-- Contenu de la carte --%>
                            <div class="article-card-content">
                                <span class="category-badge">Actualités</span>

                                <h2 class="article-card-title">
                                    <a href="${pageContext.request.contextPath}/${article.slug}-${article.id}-${article.datePub}.html">
                                        <c:out value="${article.titre}"/>
                                    </a>
                                </h2>

                                <p class="article-card-excerpt">
                                    <c:out value="${excerpts[article.id]}"/>
                                </p>

                                <div class="article-meta">
                                    <img src="https://i.pravatar.cc/100?u=redaction" class="author-img" alt="Rédaction">
                                    <span class="meta-info">
                                        <strong>Rédaction</strong> &bull;
                                        <fmt:formatDate value="${article.datePub}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <%-- Pagination --%>
                <c:if test="${totalPages > 1}">
                    <nav class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}" class="page-btn">← Précédent</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <a href="?page=${p}"
                               class="page-num ${p == currentPage ? 'active' : ''}">
                                ${p}
                            </a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}" class="page-btn">Suivant →</a>
                        </c:if>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="no-articles">
                    <h2>Aucun article publié pour le moment</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>
