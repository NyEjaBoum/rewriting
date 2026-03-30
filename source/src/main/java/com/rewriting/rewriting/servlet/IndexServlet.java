package com.rewriting.rewriting.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.model.Article;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/")
public class IndexServlet extends HttpServlet {
    private final ArticleDAO articleDAO = new ArticleDAO();

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
            throw new ServletException("Erreur lors de la récupération des articles", e);
        }
    }
}

