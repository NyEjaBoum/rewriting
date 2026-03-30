<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iran Pulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

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
            <li class="active">Accueil</li>
            <li>Actualités</li>
            <li>Top News</li>
            <li>Politique</li>
            <li>Sport</li>
            <li>Économie</li>
            <li>Culture</li>
            <li>Technologie</li>
            <li>Sciences</li>
            <li>Santé</li>
        </ul>
    </nav>

    <main class="main-wrapper">
        <c:choose>
            <c:when test="${not empty articles}">
                <div class="content-grid">

                    <%-- Article principal (le premier) --%>
                    <c:forEach var="mainArticle" items="${articles}" begin="0" end="0">
                        <section class="main-article">
                            <div class="hero-image">
                                <c:choose>
                                    <c:when test="${not empty mainArticle.images}">
                                        <img src="${pageContext.request.contextPath}${mainArticle.images[0].urlPath}"
                                             alt="<c:out value='${mainArticle.images[0].altText}'/>">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="hero-image-placeholder">
                                            ${fn:substring(mainArticle.titre, 0, 1)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="article-meta">
                                <img src="https://i.pravatar.cc/100?u=redaction" class="author-img" alt="Rédaction">
                                <span class="meta-info">
                                    <strong>Rédaction</strong> | Actualités &bull;
                                    <fmt:formatDate value="${mainArticle.datePub}" pattern="dd/MM/yyyy"/>
                                </span>
                            </div>

                            <h2 class="main-title">
                                <a href="${pageContext.request.contextPath}/article/${mainArticle.slug}">
                                    <c:out value="${mainArticle.titre}"/>
                                </a>
                            </h2>

                            <p class="summary">
                                <c:out value="${mainArticle.metaDescription}"/>
                                <a href="${pageContext.request.contextPath}/article/${mainArticle.slug}" class="read-more">lire la suite</a>
                            </p>
                        </section>
                    </c:forEach>

                    <%-- Sidebar : articles 2 à 4 --%>
                    <aside class="sidebar">
                        <c:forEach var="article" items="${articles}" begin="1" end="3">
                            <div class="side-item">
                                <c:choose>
                                    <c:when test="${not empty article.images}">
                                        <img src="${pageContext.request.contextPath}${article.images[0].urlPath}"
                                             alt="<c:out value='${article.images[0].altText}'/>">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="side-item-placeholder"></div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="side-text">
                                    <h3>
                                        <a href="${pageContext.request.contextPath}/article/${article.slug}">
                                            <c:out value="${article.titre}"/>
                                        </a>
                                    </h3>
                                    <div class="meta">
                                        Rédaction | <fmt:formatDate value="${article.datePub}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="trending">
                            <h4>Auteurs populaires</h4>
                            <div class="author-row">
                                <img src="https://i.pravatar.cc/100?u=adam" class="author-img" alt="Adam Strong">
                                <div class="author-info">
                                    <strong>Adam Strong</strong>
                                    <span>14.3K followers</span>
                                </div>
                                <span class="arrow">&#8599;</span>
                            </div>
                            <div class="author-row">
                                <img src="https://i.pravatar.cc/100?u=sam" class="author-img" alt="Samantha Hayes">
                                <div class="author-info">
                                    <strong>Samantha Hayes</strong>
                                    <span>18.7K followers</span>
                                </div>
                                <span class="arrow">&#8599;</span>
                            </div>
                        </div>
                    </aside>

                </div>
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
