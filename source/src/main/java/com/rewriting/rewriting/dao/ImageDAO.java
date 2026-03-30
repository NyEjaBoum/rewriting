package com.rewriting.rewriting.dao;

import com.rewriting.rewriting.model.Image;
import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.db.DatabaseConnection;
import java.sql.*;
import java.util.*;

public class ImageDAO {

    /**
     * Sauvegarde une nouvelle image en base de données
     * @param image Image à sauvegarder
     * @return Image avec ID généré
     * @throws SQLException En cas d'erreur base de données
     */
    public Image save(Image image) throws SQLException {
        String query = "INSERT INTO images (url_path, alt_text, article_id) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, image.getUrlPath());
            pstmt.setString(2, image.getAltText());
            pstmt.setLong(3, image.getArticle().getId());

            pstmt.executeUpdate();

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    image.setId(generatedKeys.getLong(1));
                }
            }
        }
        return image;
    }

    /**
     * Récupère toutes les images associées à un article
     * @param articleId ID de l'article
     * @return Liste des images de l'article
     * @throws SQLException En cas d'erreur base de données
     */
    public List<Image> findByArticleId(Long articleId) throws SQLException {
        List<Image> images = new ArrayList<>();
        String query = "SELECT * FROM images WHERE article_id = ? ORDER BY id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, articleId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Image image = new Image();
                    image.setId(rs.getLong("id"));
                    image.setUrlPath(rs.getString("url_path"));
                    image.setAltText(rs.getString("alt_text"));
                    // Note: On ne charge pas l'article pour éviter les références circulaires
                    images.add(image);
                }
            }
        }
        return images;
    }

    /**
     * Trouve une image par son ID
     * @param id ID de l'image
     * @return Image trouvée ou null
     * @throws SQLException En cas d'erreur base de données
     */
    public Image findById(Long id) throws SQLException {
        String query = "SELECT * FROM images WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Image image = new Image();
                    image.setId(rs.getLong("id"));
                    image.setUrlPath(rs.getString("url_path"));
                    image.setAltText(rs.getString("alt_text"));

                    // Charger l'article associé
                    Long articleId = rs.getLong("article_id");
                    if (!rs.wasNull()) {
                        Article article = new Article();
                        article.setId(articleId);
                        image.setArticle(article);
                    }

                    return image;
                }
            }
        }
        return null;
    }

    /**
     * Supprime une image par son ID
     * @param id ID de l'image à supprimer
     * @throws SQLException En cas d'erreur base de données
     */
    public void deleteById(Long id) throws SQLException {
        String query = "DELETE FROM images WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        }
    }
}
