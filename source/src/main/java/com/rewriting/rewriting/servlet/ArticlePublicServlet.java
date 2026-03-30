package com.rewriting.rewriting.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.dao.ImageDAO;
import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.model.Image;

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
        String pathInfo = request.getPathInfo(); // Ex: /mon-article

        if (pathInfo == null || pathInfo.equals("/")) {
            request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
            return;
        }

        // Extraire le slug (sans le premier "/")
        String slug = pathInfo.substring(1);
        if (slug.endsWith("/")) {
            slug = slug.substring(0, slug.length() - 1);
        }

        if (slug.isBlank() || slug.contains("/")) {
            request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
            return;
        }

        try {
            Article article = articleDAO.findBySlug(slug);

            // Vérifier que l'article existe et est publié
            if (article == null || !"PUBLIE".equals(article.getStatut())) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }

            List<Image> images = imageDAO.findByArticleId(article.getId());

            // Passer l'article et les images associées à la JSP
            request.setAttribute("article", article);
            request.setAttribute("images", images);
            request.getRequestDispatcher("/WEB-INF/views/front/article.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération de l'article", e);
        }
    }
}
