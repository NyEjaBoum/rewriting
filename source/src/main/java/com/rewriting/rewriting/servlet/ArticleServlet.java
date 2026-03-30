package com.rewriting.rewriting.servlet;

import com.rewriting.rewriting.dao.ArticleDAO;
import com.rewriting.rewriting.dao.ImageDAO;
import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.model.Image;
import com.rewriting.rewriting.util.FileUploadValidator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/articles/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB en mémoire
    maxFileSize = 1024 * 1024 * 5,        // 5MB max
    maxRequestSize = 1024 * 1024 * 10     // 10MB requête totale
)
public class ArticleServlet extends HttpServlet {
    private ArticleDAO articleDAO = new ArticleDAO();
    private ImageDAO imageDAO = new ImageDAO();

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
            } else if (pathInfo.matches("/\\d+/uploadImage") || pathInfo.equals("/new/uploadImage")) {
                uploadImage(request, response);
            } else if (pathInfo.matches("/\\d+/deleteImage/\\d+")) {
                deleteImage(request, response);
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

    private void uploadImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        Path savedFilePath = null;

        try {
            // Extraire l'ID de l'article du path
            Long articleId = null;
            if (pathInfo.matches("/\\d+/uploadImage")) {
                String[] parts = pathInfo.split("/");
                articleId = Long.parseLong(parts[1]);
            }

            // Vérifier que l'article existe
            Article article = null;
            if (articleId != null) {
                article = articleDAO.findById(articleId);
                if (article == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Article introuvable");
                    return;
                }
            } else {
                // Cas /new/uploadImage non supporté pour l'instant
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Upload d'image uniquement pour articles existants");
                return;
            }

            // Récupérer le fichier et le texte alternatif
            Part filePart = request.getPart("imageFile");
            String altText = request.getParameter("altText");

            // Valider le texte alternatif
            if (altText == null || altText.trim().isEmpty()) {
                request.setAttribute("error", "Le texte alternatif est obligatoire");
                request.setAttribute("article", article);
                request.setAttribute("formTitle", "Éditer l'article");
                request.setAttribute("actionUrl", request.getContextPath() + "/admin/articles/edit/" + articleId);
                request.getRequestDispatcher("/WEB-INF/views/admin/article/form.jsp").forward(request, response);
                return;
            }

            // Récupérer le nom du fichier
            String originalFilename = filePart.getSubmittedFileName();

            // Valider le fichier
            try {
                FileUploadValidator.validateFile(filePart, originalFilename);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", e.getMessage());
                request.setAttribute("article", article);
                request.setAttribute("formTitle", "Éditer l'article");
                request.setAttribute("actionUrl", request.getContextPath() + "/admin/articles/edit/" + articleId);
                request.getRequestDispatcher("/WEB-INF/views/admin/article/form.jsp").forward(request, response);
                return;
            }

            // Générer un nom de fichier unique
            String timestamp = String.valueOf(System.currentTimeMillis());
            String uuid = UUID.randomUUID().toString().substring(0, 8);
            String sanitizedFilename = FileUploadValidator.sanitizeFilename(originalFilename);
            String uniqueFilename = timestamp + "_" + uuid + "_" + sanitizedFilename;

            // Créer le répertoire uploads s'il n'existe pas
            String uploadDirPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Sauvegarder le fichier sur le disque
            savedFilePath = Paths.get(uploadDirPath, uniqueFilename);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, savedFilePath, StandardCopyOption.REPLACE_EXISTING);
            }

            // Créer l'enregistrement Image
            Image image = new Image();
            image.setUrlPath("/uploads/" + uniqueFilename);
            image.setAltText(altText.trim());
            image.setArticle(article);

            // Sauvegarder en base de données
            imageDAO.save(image);

            // Rediriger vers le formulaire d'édition avec message de succès
            response.sendRedirect(request.getContextPath() + "/admin/articles/edit/" + articleId + "?success=Image ajoutée avec succès");

        } catch (SQLException e) {
            // Si erreur base de données, supprimer le fichier sauvegardé
            if (savedFilePath != null && Files.exists(savedFilePath)) {
                try {
                    Files.delete(savedFilePath);
                } catch (IOException ioEx) {
                    ioEx.printStackTrace();
                }
            }
            e.printStackTrace();
            throw new ServletException("Erreur lors de l'enregistrement de l'image: " + e.getMessage(), e);
        } catch (Exception e) {
            // Pour toute autre erreur, supprimer le fichier sauvegardé
            if (savedFilePath != null && Files.exists(savedFilePath)) {
                try {
                    Files.delete(savedFilePath);
                } catch (IOException ioEx) {
                    ioEx.printStackTrace();
                }
            }
            e.printStackTrace();
            throw new ServletException("Erreur lors de l'upload: " + e.getMessage(), e);
        }
    }

    private void deleteImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        try {
            // Extraire articleId et imageId du pathInfo: /{articleId}/deleteImage/{imageId}
            String[] parts = pathInfo.split("/");
            if (parts.length < 4) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL invalide");
                return;
            }

            Long articleId = Long.parseLong(parts[1]);
            Long imageId = Long.parseLong(parts[3]);

            // Charger l'image
            Image image = imageDAO.findById(imageId);
            if (image == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image introuvable");
                return;
            }

            // Vérifier que l'image appartient bien à l'article (sécurité)
            if (image.getArticle() == null || !image.getArticle().getId().equals(articleId)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            // Supprimer l'enregistrement de la base de données
            imageDAO.deleteById(imageId);

            // Supprimer le fichier du disque
            String urlPath = image.getUrlPath();  // "/uploads/filename.jpg"
            if (urlPath.startsWith("/uploads/")) {
                String filename = urlPath.substring("/uploads/".length());
                String uploadDirPath = getServletContext().getRealPath("/uploads");
                Path filePath = Paths.get(uploadDirPath, filename);

                try {
                    Files.deleteIfExists(filePath);
                } catch (IOException e) {
                    // Logger l'erreur mais ne pas échouer car la base est déjà nettoyée
                    e.printStackTrace();
                }
            }

            // Rediriger vers le formulaire d'édition avec message de succès
            response.sendRedirect(request.getContextPath() + "/admin/articles/edit/" + articleId + "?success=Image supprimée avec succès");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Erreur lors de la suppression de l'image: " + e.getMessage(), e);
        }
    }
}
