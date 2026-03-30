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
import java.util.List;

@WebServlet(urlPatterns = {"/index", ""})
public class IndexServlet extends HttpServlet {
    private ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Charger tous les articles publiés
            List<Article> articles = articleDAO.findAllPublished();

            // Passer la liste à la JSP
            request.setAttribute("articles", articles);
            request.getRequestDispatcher("/WEB-INF/views/public/index.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Erreur lors de la récupération des articles", e);
        }
    }
}

