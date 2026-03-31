package com.rewriting.rewriting.dao;

import com.rewriting.rewriting.model.Utilisateur;
import com.rewriting.rewriting.db.DatabaseConnection;
import java.sql.*;
import java.util.*;

public class UtilisateurDAO {

    public List<Utilisateur> findAll() throws SQLException {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String query = "SELECT * FROM utilisateurs";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setId(rs.getLong("id"));
                utilisateur.setUsername(rs.getString("username"));
                utilisateur.setPassword(rs.getString("password"));
                utilisateur.setNomComplet(rs.getString("nom_complet"));
                utilisateurs.add(utilisateur);
            }
        }
        return utilisateurs;
    }

    public Utilisateur findById(Long id) throws SQLException {
        String query = "SELECT * FROM utilisateurs WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setId(rs.getLong("id"));
                    utilisateur.setUsername(rs.getString("username"));
                    utilisateur.setPassword(rs.getString("password"));
                    utilisateur.setNomComplet(rs.getString("nom_complet"));
                    return utilisateur;
                }
            }
        }
        return null;
    }

    public Utilisateur findByUsername(String username) throws SQLException {
        String query = "SELECT * FROM utilisateurs WHERE username = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setId(rs.getLong("id"));
                    utilisateur.setUsername(rs.getString("username"));
                    utilisateur.setPassword(rs.getString("password"));
                    utilisateur.setNomComplet(rs.getString("nom_complet"));
                    return utilisateur;
                }
            }
        }
        return null;
    }

    public Utilisateur save(Utilisateur utilisateur) throws SQLException {
        if (utilisateur.getId() == null) {
            return insert(utilisateur);
        } else {
            return update(utilisateur);
        }
    }

    private Utilisateur insert(Utilisateur utilisateur) throws SQLException {
        String query = "INSERT INTO utilisateurs (username, password) VALUES (?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, utilisateur.getUsername());
            pstmt.setString(2, utilisateur.getPassword());

            pstmt.executeUpdate();

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    utilisateur.setId(generatedKeys.getLong(1));
                }
            }
        }
        return utilisateur;
    }

    private Utilisateur update(Utilisateur utilisateur) throws SQLException {
        String query = "UPDATE utilisateurs SET username = ?, password = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, utilisateur.getUsername());
            pstmt.setString(2, utilisateur.getPassword());
            pstmt.setLong(3, utilisateur.getId());

            pstmt.executeUpdate();
        }
        return utilisateur;
    }

    public void deleteById(Long id) throws SQLException {
        String query = "DELETE FROM utilisateurs WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        }
    }
}
