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

                <%-- Layout principal : hero à gauche, sidebar à droite --%>
                <div class="content-grid">

                    <%-- Article héro (le plus récent) --%>
                    <c:set var="hero" value="${articles[0]}"/>
                    <section class="main-article">
                        <a href="${pageContext.request.contextPath}/${hero.slug}-${hero.id}-${hero.datePub}.html">
                            <c:choose>
                                <c:when test="${not empty hero.images}">
                                    <c:set var="heroSrc" value="${hero.images[0].urlPath}"/>
                                    <div class="hero-image">
                                        <img src="${fn:startsWith(heroSrc,'http') ? heroSrc : pageContext.request.contextPath.concat(heroSrc)}"
                                             alt="<c:out value='${hero.images[0].altText}'/>"
                                             fetchpriority="high">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="hero-image-placeholder">
                                        ${fn:substring(hero.titre, 0, 1)}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <div class="article-meta">
                            <img src="${pageContext.request.contextPath}/assets/images/avatar.jpg" class="author-img"
                                 alt="<c:out value='${hero.auteurNom}'/>">
                            <span class="meta-info">
                                <strong><c:out value="${not empty hero.auteurNom ? hero.auteurNom : 'Rédaction'}"/></strong>
                                &bull; <fmt:formatDate value="${hero.datePub}" pattern="dd MMM yyyy"/>
                            </span>
                        </div>
                        <h2 class="main-title">
                            <a href="${pageContext.request.contextPath}/${hero.slug}-${hero.id}-${hero.datePub}.html">
                                <c:out value="${hero.titre}"/>
                            </a>
                        </h2>
                        <p class="summary">
                            <c:out value="${excerpts[hero.id]}"/>
                            <a href="${pageContext.request.contextPath}/${hero.slug}-${hero.id}-${hero.datePub}.html"
                               class="read-more"> lire la suite</a>
                        </p>
                    </section>

                    <%-- Sidebar : articles 2 à 4 + auteurs --%>
                    <aside class="sidebar">
                        <c:forEach var="article" items="${articles}" varStatus="loop"
                                   begin="1" end="4">
                            <c:set var="aSrc" value="${not empty article.images ? article.images[0].urlPath : ''}"/>
                            <div class="side-item">
                                <c:choose>
                                    <c:when test="${not empty aSrc}">
                                        <a href="${pageContext.request.contextPath}/${article.slug}-${article.id}-${article.datePub}.html">
                                            <img src="${fn:startsWith(aSrc,'http') ? aSrc : pageContext.request.contextPath.concat(aSrc)}"
                                                 alt="<c:out value='${article.images[0].altText}'/>" loading="lazy">
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="side-item-placeholder"></div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="side-text">
                                    <h3>
                                        <a href="${pageContext.request.contextPath}/${article.slug}-${article.id}-${article.datePub}.html">
                                            <c:out value="${article.titre}"/>
                                        </a>
                                    </h3>
                                    <div class="meta">
                                        <c:out value="${not empty article.auteurNom ? article.auteurNom : 'Rédaction'}"/>
                                        &bull; <fmt:formatDate value="${article.datePub}" pattern="dd MMM yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <%-- Auteurs tendance --%>
                        <c:if test="${fn:length(articles) >= 2}">
                            <div class="trending">
                                <h4>Nos journalistes</h4>
                                <c:set var="a1" value="${articles[0]}"/>
                                <div class="author-row">
                                    <img src="${pageContext.request.contextPath}/assets/images/avatar.jpg" class="author-img"
                                         alt="<c:out value='${a1.auteurNom}'/>">
                                    <div class="author-info">
                                        <strong><c:out value="${not empty a1.auteurNom ? a1.auteurNom : 'Rédaction'}"/></strong>
                                        <span>Journaliste</span>
                                    </div>
                                    <span class="arrow">↗</span>
                                </div>
                                <c:set var="a2" value="${articles[1]}"/>
                                <c:if test="${a2.auteurNom != a1.auteurNom}">
                                    <div class="author-row">
                                        <img src="${pageContext.request.contextPath}/assets/images/avatar.jpg" class="author-img"
                                             alt="<c:out value='${a2.auteurNom}'/>">
                                        <div class="author-info">
                                            <strong><c:out value="${not empty a2.auteurNom ? a2.auteurNom : 'Rédaction'}"/></strong>
                                            <span>Journaliste</span>
                                        </div>
                                        <span class="arrow">↗</span>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                    </aside>
                </div>

                <%-- Articles suivants en grille (5+) --%>
                <c:if test="${fn:length(articles) > 4}">
                    <div class="articles-grid" style="margin-top: 60px;">
                        <c:forEach var="article" items="${articles}" varStatus="loop" begin="4">
                            <c:set var="imgSrc" value="${not empty article.images ? article.images[0].urlPath : ''}"/>
                            <article class="article-card">
                                <c:choose>
                                    <c:when test="${not empty imgSrc}">
                                        <img src="${fn:startsWith(imgSrc,'http') ? imgSrc : pageContext.request.contextPath.concat(imgSrc)}"
                                             alt="<c:out value='${article.images[0].altText}'/>"
                                             class="article-card-image" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="article-card-placeholder">${fn:substring(article.titre, 0, 1)}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="article-card-content">
                                    <span class="category-badge">Actualités</span>
                                    <h2 class="article-card-title">
                                        <a href="${pageContext.request.contextPath}/${article.slug}-${article.id}-${article.datePub}.html">
                                            <c:out value="${article.titre}"/>
                                        </a>
                                    </h2>
                                    <p class="article-card-excerpt"><c:out value="${excerpts[article.id]}"/></p>
                                    <div class="article-meta">
                                        <img src="${pageContext.request.contextPath}/assets/images/avatar.jpg"
                                             class="author-img" alt="<c:out value='${article.auteurNom}'/>">
                                        <span class="meta-info">
                                            <strong><c:out value="${not empty article.auteurNom ? article.auteurNom : 'Rédaction'}"/></strong>
                                            &bull; <fmt:formatDate value="${article.datePub}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:if>

                <%-- Pagination --%>
                <c:if test="${totalPages > 1}">
                    <nav class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}" class="page-btn">← Précédent</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <a href="?page=${p}" class="page-num ${p == currentPage ? 'active' : ''}">${p}</a>
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
