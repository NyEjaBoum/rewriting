package com.rewriting.rewriting.servlet;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/article/*")
public class ArticlePublicServlet extends HttpServlet {
    private ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Ex: /mon-article

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Extraire le slug (sans le premier "/")
        String slug = pathInfo.substring(1);

        try {
            Article article = articleDAO.findBySlug(slug);

            // Vérifier que l'article existe et est publié
            if (article == null || !"PUBLIE".equals(article.getStatut())) {
                request.getRequestDispatcher("/WEB-INF/views/404.jsp").forward(request, response);
                return;
            }

            // Passer l'article à la JSP
            request.setAttribute("article", article);
            request.getRequestDispatcher("/WEB-INF/views/article.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Erreur lors de la récupération de l'article", e);
        }
    }
}
