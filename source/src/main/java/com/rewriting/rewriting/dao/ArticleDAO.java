package com.rewriting.rewriting.dao;

import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.db.DatabaseConnection;
import java.sql.*;
import java.util.*;

public class ArticleDAO {

    public List<Article> findAll() throws SQLException {
        List<Article> articles = new ArrayList<>();
        String query = "SELECT * FROM articles ORDER BY date_pub DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Article article = new Article();
                article.setId(rs.getLong("id"));
                article.setTitre(rs.getString("titre"));
                article.setSlug(rs.getString("slug"));
                article.setContenuHtml(rs.getString("contenu_html"));
                article.setMetaDescription(rs.getString("meta_description"));
                article.setDatePub(rs.getDate("date_pub"));
                article.setStatut(rs.getString("statut"));
                articles.add(article);
            }
        }
        return articles;
    }

    public List<Article> findAllPublished() throws SQLException {
        List<Article> articles = new ArrayList<>();
        String query = "SELECT * FROM articles WHERE statut = 'PUBLIE' ORDER BY date_pub DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Article article = new Article();
                article.setId(rs.getLong("id"));
                article.setTitre(rs.getString("titre"));
                article.setSlug(rs.getString("slug"));
                article.setContenuHtml(rs.getString("contenu_html"));
                article.setMetaDescription(rs.getString("meta_description"));
                article.setDatePub(rs.getDate("date_pub"));
                article.setStatut(rs.getString("statut"));
                articles.add(article);
            }
        }
        return articles;
    }

    public Article findById(Long id) throws SQLException {
        String query = "SELECT * FROM articles WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Article article = new Article();
                    article.setId(rs.getLong("id"));
                    article.setTitre(rs.getString("titre"));
                    article.setSlug(rs.getString("slug"));
                    article.setContenuHtml(rs.getString("contenu_html"));
                    article.setMetaDescription(rs.getString("meta_description"));
                    article.setDatePub(rs.getDate("date_pub"));
                    article.setStatut(rs.getString("statut"));

                    // Charger les images associées
                    ImageDAO imageDAO = new ImageDAO();
                    java.util.List<com.rewriting.rewriting.model.Image> images = imageDAO.findByArticleId(article.getId());
                    article.setImages(images);

                    return article;
                }
            }
        }
        return null;
    }

    public Article findBySlug(String slug) throws SQLException {
        String query = "SELECT * FROM articles WHERE slug = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, slug);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Article article = new Article();
                    article.setId(rs.getLong("id"));
                    article.setTitre(rs.getString("titre"));
                    article.setSlug(rs.getString("slug"));
                    article.setContenuHtml(rs.getString("contenu_html"));
                    article.setMetaDescription(rs.getString("meta_description"));
                    article.setDatePub(rs.getDate("date_pub"));
                    article.setStatut(rs.getString("statut"));

                    // Charger les images associées
                    ImageDAO imageDAO = new ImageDAO();
                    java.util.List<com.rewriting.rewriting.model.Image> images = imageDAO.findByArticleId(article.getId());
                    article.setImages(images);

                    return article;
                }
            }
        }
        return null;
    }

    public boolean existsBySlug(String slug) throws SQLException {
        return findBySlug(slug) != null;
    }

    public Article save(Article article) throws SQLException {
        if (article.getId() == null) {
            return insert(article);
        } else {
            return update(article);
        }
    }

    private Article insert(Article article) throws SQLException {
        String query = "INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, article.getTitre());
            pstmt.setString(2, article.getSlug());
            pstmt.setString(3, article.getContenuHtml());
            pstmt.setString(4, article.getMetaDescription());
            pstmt.setDate(5, new java.sql.Date(article.getDatePub().getTime()));
            pstmt.setString(6, article.getStatut() != null ? article.getStatut() : "BROUILLON");

            pstmt.executeUpdate();

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    article.setId(generatedKeys.getLong(1));
                }
            }
        }
        return article;
    }

    private Article update(Article article) throws SQLException {
        String query = "UPDATE articles SET titre = ?, slug = ?, contenu_html = ?, meta_description = ?, statut = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, article.getTitre());
            pstmt.setString(2, article.getSlug());
            pstmt.setString(3, article.getContenuHtml());
            pstmt.setString(4, article.getMetaDescription());
            pstmt.setString(5, article.getStatut() != null ? article.getStatut() : "BROUILLON");
            pstmt.setLong(6, article.getId());

            pstmt.executeUpdate();
        }
        return article;
    }

    public void deleteById(Long id) throws SQLException {
        String query = "DELETE FROM articles WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        }
    }
}
