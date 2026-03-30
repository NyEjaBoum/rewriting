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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/articles/*")
public class ArticleServlet extends HttpServlet {
    private ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                listArticles(request, response);
            } else if (pathInfo.equals("/add")) {
                showAddForm(request, response);
            } else if (pathInfo.matches("/edit/\\d+")) {
                Long id = extractId(pathInfo);
                showEditForm(id, request, response);
            } else if (pathInfo.matches("/delete/\\d+")) {
                Long id = extractId(pathInfo);
                deleteArticle(id, request, response);
            } else {
                listArticles(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur base de données: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/article/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo.equals("/add")) {
                addArticle(request, response);
            } else if (pathInfo.matches("/edit/\\d+")) {
                Long id = extractId(pathInfo);
                editArticle(id, request, response);
            } else {
                listArticles(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur base de données: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/article/list.jsp").forward(request, response);
        }
    }

    private void listArticles(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Article> articles = articleDAO.findAll();
        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/WEB-INF/views/admin/article/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("formTitle", "Créer un nouvel article");
        request.setAttribute("actionUrl", request.getContextPath() + "/admin/articles/add");
        request.getRequestDispatcher("/WEB-INF/views/admin/article/form.jsp").forward(request, response);
    }

    private void addArticle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String titre = request.getParameter("titre");
        String slug = request.getParameter("slug");
        String metaDescription = request.getParameter("meta_description");
        String contenuHtml = request.getParameter("contenu_html");
        String datePubStr = request.getParameter("date_pub");

        if (articleDAO.existsBySlug(slug)) {
            request.setAttribute("error", "Ce slug existe déjà.");
            request.setAttribute("formTitle", "Créer un nouvel article");
            request.setAttribute("actionUrl", request.getContextPath() + "/admin/articles/add");
            try {
                request.getRequestDispatcher("/WEB-INF/views/admin/article/form.jsp").forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
            }
            return;
        }

        Article article = new Article();
        article.setTitre(titre);
        article.setSlug(slug);
        article.setMetaDescription(metaDescription);
        article.setContenuHtml(contenuHtml);

        if (datePubStr != null && !datePubStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                article.setDatePub(sdf.parse(datePubStr));
            } catch (Exception e) {
                article.setDatePub(new Date());
            }
        } else {
            article.setDatePub(new Date());
        }

        articleDAO.save(article);
        response.sendRedirect(request.getContextPath() + "/admin/articles?success=Article créé avec succès !");
    }

    private void showEditForm(Long id, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Article article = articleDAO.findById(id);
        if (article == null) {
            response.sendRedirect(request.getContextPath() + "/admin/articles");
            return;
        }
        request.setAttribute("article", article);
        request.setAttribute("formTitle", "Éditer l'article");
        request.setAttribute("actionUrl", request.getContextPath() + "/admin/articles/edit/" + id);
        request.getRequestDispatcher("/WEB-INF/views/admin/article/form.jsp").forward(request, response);
    }

    private void editArticle(Long id, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Article article = articleDAO.findById(id);
        if (article == null) {
            response.sendRedirect(request.getContextPath() + "/admin/articles");
            return;
        }

        article.setTitre(request.getParameter("titre"));
        article.setSlug(request.getParameter("slug"));
        article.setMetaDescription(request.getParameter("meta_description"));
        article.setContenuHtml(request.getParameter("contenu_html"));

        articleDAO.save(article);
        response.sendRedirect(request.getContextPath() + "/admin/articles?success=Article modifié !");
    }

    private void deleteArticle(Long id, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        articleDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/articles?success=Article supprimé !");
    }

    private Long extractId(String pathInfo) {
        String[] parts = pathInfo.split("/");
        return Long.parseLong(parts[parts.length - 1]);
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        return request.getSession().getAttribute("user") != null;
    }
}
