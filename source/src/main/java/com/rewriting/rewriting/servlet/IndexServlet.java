package com.rewriting.rewriting.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.util.TextUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("")
public class IndexServlet extends HttpServlet {
    private final ArticleDAO articleDAO = new ArticleDAO();
    private static final int ARTICLES_PER_PAGE = 12;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extraire le numéro de page (défaut: 1)
            int currentPage = parsePageParam(request.getParameter("page"));

            // Calculer offset
            int offset = (currentPage - 1) * ARTICLES_PER_PAGE;

            // Charger les articles paginés et le total
            List<Article> articles = articleDAO.findAllPublished(offset, ARTICLES_PER_PAGE);
            int totalArticles = articleDAO.countPublished();
            int totalPages = (int) Math.ceil((double) totalArticles / ARTICLES_PER_PAGE);

            // Créer les extraits de 150 caractères pour chaque article
            Map<Long, String> excerpts = new HashMap<>();
            for (Article article : articles) {
                String excerpt = TextUtils.getExcerpt(article.getContenuHtml(), 150);
                excerpts.put(article.getId(), excerpt);
            }

            // Passer les attributs à la JSP
            request.setAttribute("articles", articles);
            request.setAttribute("excerpts", excerpts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("articlesPerPage", ARTICLES_PER_PAGE);
            request.setAttribute("totalArticles", totalArticles);

            request.getRequestDispatcher("/WEB-INF/views/public/index.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des articles", e);
        }
    }

    private int parsePageParam(String pageParam) {
        if (pageParam == null || pageParam.isEmpty()) {
            return 1;
        }
        try {
            int page = Integer.parseInt(pageParam);
            return Math.max(1, page); // Assurer que la page est >= 1
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}

