<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Rewriting - Accueil</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #fff;
            color: #1a1a1a;
        }

        /* Header Full Width */
        .site-header {
            width: 100%;
            border-bottom: 1px solid #eee;
            padding: 20px 50px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

        .logo {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .logo a {
            text-decoration: none;
            color: inherit;
        }

        .header-left {
            display: flex;
            gap: 30px;
        }

        .icon-svg {
            width: 22px;
            height: 22px;
            cursor: pointer;
            color: #333;
        }

        .user-icon {
            color: #4b2c7e;
        }

        /* Nav Bar Full Width */
        .nav-bar {
            width: 100%;
            border-bottom: 1px solid #eee;
            padding: 0 50px;
        }

        .categories {
            display: flex;
            justify-content: space-between;
            list-style: none;
            padding: 15px 0;
        }

        .categories li {
            font-size: 14px;
            font-weight: 500;
            color: #888;
            cursor: pointer;
        }

        .categories li a {
            text-decoration: none;
            color: inherit;
        }

        .categories li.active {
            color: #000;
            font-weight: 700;
            border-bottom: 2px solid #000;
            padding-bottom: 15px;
            margin-bottom: -16px;
        }

        /* Layout Grid */
        .main-wrapper {
            padding: 40px 50px;
            width: 100%;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 60px;
        }

        .hero-image img {
            width: 100%;
            height: 550px;
            object-fit: cover;
            border-radius: 30px;
        }

        .hero-image-placeholder {
            width: 100%;
            height: 550px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: 700;
        }

        /* Article details */
        .article-meta { display: flex; align-items: center; gap: 12px; margin: 25px 0; }
        .author-img { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; background: #e0e0e0; }
        .meta-info { font-size: 14px; color: #666; }

        .main-title { font-size: 42px; font-weight: 800; line-height: 1.1; margin-bottom: 20px; }
        .main-title a { text-decoration: none; color: inherit; }
        .main-title a:hover { color: #4b2c7e; }

        .summary { font-size: 16px; color: #444; line-height: 1.6; }
        .read-more { font-weight: 700; color: #000; text-decoration: none; }
        .read-more:hover { color: #4b2c7e; }

        /* Sidebar */
        .sidebar { }
        .side-item { display: flex; gap: 20px; margin-bottom: 30px; }
        .side-item img { width: 140px; height: 95px; border-radius: 15px; object-fit: cover; }
        .side-item-placeholder {
            width: 140px;
            height: 95px;
            border-radius: 15px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            flex-shrink: 0;
        }
        .side-text { flex: 1; }
        .side-item h3 { font-size: 16px; line-height: 1.3; margin-bottom: 8px; }
        .side-item h3 a { text-decoration: none; color: inherit; }
        .side-item h3 a:hover { color: #4b2c7e; }
        .side-item .meta { font-size: 12px; color: #999; }

        /* Trending authors */
        .trending { margin-top: 60px; border-top: 1px solid #eee; padding-top: 30px; }
        .trending h4 { font-size: 14px; font-weight: 700; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 1px; }
        .author-row { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .author-row .author-img { width: 45px; height: 45px; }
        .author-info { display: flex; flex-direction: column; }
        .author-info strong { font-size: 15px; }
        .author-info span { font-size: 12px; color: #888; }
        .arrow { margin-left: auto; color: #ddd; font-size: 18px; }

        /* No articles */
        .no-articles {
            text-align: center;
            padding: 100px 20px;
            background: #f9f9f9;
            border-radius: 30px;
        }
        .no-articles h2 {
            font-size: 28px;
            color: #888;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
            .site-header, .nav-bar, .main-wrapper {
                padding-left: 20px;
                padding-right: 20px;
            }
            .main-title {
                font-size: 32px;
            }
            .hero-image img, .hero-image-placeholder {
                height: 350px;
            }
        }

        @media (max-width: 768px) {
            .categories {
                gap: 15px;
                overflow-x: auto;
                justify-content: flex-start;
            }
            .header-left {
                gap: 15px;
            }
        }
    </style>
</head>
<body>

    <header class="site-header">
        <div class="header-content">
            <div class="header-left">
                <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
            </div>

            <h1 class="logo"><a href="${pageContext.request.contextPath}/">BLOG REWRITING</a></h1>

            <div class="header-right">
                <a href="${pageContext.request.contextPath}/login">
                    <svg class="icon-svg user-icon" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg>
                </a>
            </div>
        </div>
    </header>

    <nav class="nav-bar">
        <ul class="categories">
            <li class="active"><a href="${pageContext.request.contextPath}/">Accueil</a></li>
            <li><a href="#">Actualites</a></li>
            <li><a href="#">Top News</a></li>
            <li><a href="#">Politique</a></li>
            <li><a href="#">Sport</a></li>
            <li><a href="#">Economie</a></li>
            <li><a href="#">Culture</a></li>
            <li><a href="#">Technologie</a></li>
            <li><a href="#">Sciences</a></li>
            <li><a href="#">Sante</a></li>
        </ul>
    </nav>

    <main class="main-wrapper">
        <c:choose>
            <c:when test="${not empty articles}">
                <div class="content-grid">
                    <c:forEach var="mainArticle" items="${articles}" begin="0" end="0">
                        <section class="main-article">
                            <div class="hero-image">
                                <c:choose>
                                    <c:when test="${not empty mainArticle.images && mainArticle.images.size() > 0}">
                                        <img src="${mainArticle.images[0].urlPath}" alt="${mainArticle.images[0].altText}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="hero-image-placeholder">
                                            ${fn:substring(mainArticle.titre, 0, 1)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="article-meta">
                                <img src="https://i.pravatar.cc/100?u=redaction" class="author-img">
                                <span class="meta-info"><strong>Redaction</strong> | Actualites &bull; ${mainArticle.datePub}</span>
                            </div>
                            <h2 class="main-title">
                                <a href="${pageContext.request.contextPath}/article/${mainArticle.slug}">${mainArticle.titre}</a>
                            </h2>
                            <p class="summary">
                                ${mainArticle.metaDescription}
                                <a href="${pageContext.request.contextPath}/article/${mainArticle.slug}" class="read-more">lire la suite</a>
                            </p>
                        </section>
                    </c:forEach>

                    <aside class="sidebar">
                        <c:forEach var="article" items="${articles}" begin="1" end="3" varStatus="status">
                            <div class="side-item">
                                <c:choose>
                                    <c:when test="${not empty article.images && article.images.size() > 0}">
                                        <img src="${article.images[0].urlPath}" alt="${article.images[0].altText}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="side-item-placeholder"></div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="side-text">
                                    <h3><a href="${pageContext.request.contextPath}/article/${article.slug}">${article.titre}</a></h3>
                                    <div class="meta">Redaction | ${article.datePub}</div>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="trending">
                            <h4>Auteurs populaires</h4>
                            <div class="author-row">
                                <img src="https://i.pravatar.cc/100?u=adam" class="author-img">
                                <div class="author-info"><strong>Adam Strong</strong><span>14.3K followers</span></div>
                                <span class="arrow">&#8599;</span>
                            </div>
                            <div class="author-row">
                                <img src="https://i.pravatar.cc/100?u=sam" class="author-img">
                                <div class="author-info"><strong>Samantha Hayes</strong><span>18.7K followers</span></div>
                                <span class="arrow">&#8599;</span>
                            </div>
                        </div>
                    </aside>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-articles">
                    <h2>Aucun article publie pour le moment</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>
