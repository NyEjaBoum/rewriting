package com.rewriting.rewriting.servlet;

import com.rewriting.rewriting.dao.UtilisateurDAO;
import com.rewriting.rewriting.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet({"/login", "/logout"})
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getRequestURI();

        if (action.endsWith("/logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            String error = request.getParameter("error");
            if (error != null) {
                request.setAttribute("error", "Identifiant ou mot de passe incorrect.");
            }
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Utilisateur utilisateur = utilisateurDAO.findByUsername(username);
            if (utilisateur != null && utilisateur.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", utilisateur);
                response.sendRedirect(request.getContextPath() + "/admin/articles");
            } else {
                request.setAttribute("error", "Identifiants invalides");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur base de données");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
