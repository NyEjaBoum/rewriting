package com.rewriting.rewriting.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.dao.ImageDAO;
import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.model.Image;
import com.rewriting.rewriting.util.TextUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/article/*")
public class ArticlePublicServlet extends HttpServlet {
    private final ArticleDAO articleDAO = new ArticleDAO();
    private final ImageDAO imageDAO = new ImageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Vérifie si on a les attributs du filtre (rewriting)
        String slug = (String) request.getAttribute("slug");
        String id = (String) request.getAttribute("id");
        String date = (String) request.getAttribute("date");

        Article article = null;
        if (slug != null && id != null && date != null) {
            // On a les infos du rewriting, on peut utiliser l'id pour charger l'article
            try {
                article = articleDAO.findById(Long.parseLong(id));
            } catch (NumberFormatException | SQLException e) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }
        } else {
            // Fallback : comportement actuel (slug dans l'URL)
            String pathInfo = request.getPathInfo(); // Ex: /mon-article
            if (pathInfo == null || pathInfo.equals("/")) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }
            slug = pathInfo.substring(1);
            if (slug.endsWith("/")) {
                slug = slug.substring(0, slug.length() - 1);
            }
            if (slug.isBlank() || slug.contains("/")) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }
            try {
                article = articleDAO.findBySlug(slug);
            } catch (SQLException e) {
                throw new ServletException("Erreur lors de la récupération de l'article", e);
            }
        }

        try {
            // Vérifier que l'article existe et est publié
            if (article == null || !"PUBLIE".equals(article.getStatut())) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }

            List<Image> images = imageDAO.findByArticleId(article.getId());

            // Fallback meta description si vide
            if (article.getMetaDescription() == null || article.getMetaDescription().isBlank()) {
                request.setAttribute("metaFallback", TextUtils.getExcerpt(article.getContenuHtml(), 150));
            }

            // Charger les autres articles publiés (pour "À lire aussi")
            List<Article> allPublished = articleDAO.findAllPublished();
            final Long currentArticleId = article.getId();
            allPublished.removeIf(a -> a.getId().equals(currentArticleId));
            List<Article> relatedArticles = allPublished.size() > 3 ? allPublished.subList(0, 3) : allPublished;

            // Passer l'article et les images associées à la JSP
            request.setAttribute("article", article);
            request.setAttribute("images", images);
            request.setAttribute("relatedArticles", relatedArticles);
            // On peut aussi passer slug, id, date à la JSP si besoin
            request.setAttribute("slug", slug);
            request.setAttribute("id", id);
            request.setAttribute("date", date);
            request.getRequestDispatcher("/WEB-INF/views/front/article.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération de l'article", e);
        }
    }
}
