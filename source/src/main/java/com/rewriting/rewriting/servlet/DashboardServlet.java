package com.rewriting.rewriting.servlet;

import com.rewriting.rewriting.dao.ArticleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet({"/admin", "/admin/"})
public class DashboardServlet extends HttpServlet {
    private final ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int publishedCount = articleDAO.countPublished();
            int totalCount     = articleDAO.countAll();
            int draftCount     = totalCount - publishedCount;

            request.setAttribute("publishedCount", publishedCount);
            request.setAttribute("draftCount",     draftCount);
            request.setAttribute("totalCount",     totalCount);

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erreur lors du chargement du tableau de bord", e);
        }
    }
}
