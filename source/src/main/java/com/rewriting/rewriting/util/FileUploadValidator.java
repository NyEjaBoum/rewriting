package com.rewriting.rewriting.util;

import jakarta.servlet.http.Part;
import java.util.Set;

public class FileUploadValidator {
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final Set<String> ALLOWED_MIME_TYPES = Set.of(
        "image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"
    );
    private static final Set<String> ALLOWED_EXTENSIONS = Set.of(
        ".jpg", ".jpeg", ".png", ".gif", ".webp"
    );

    /**
     * Valide un fichier uploadé
     * @param filePart Part du fichier depuis la requête multipart
     * @param filename Nom du fichier
     * @throws IllegalArgumentException Si le fichier ne passe pas la validation
     */
    public static void validateFile(Part filePart, String filename) throws IllegalArgumentException {
        // Vérifier que le fichier existe et n'est pas vide
        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("Aucun fichier sélectionné");
        }

        // Vérifier la taille du fichier
        if (filePart.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("Fichier trop volumineux (max 5MB)");
        }

        // Vérifier le type MIME
        String contentType = filePart.getContentType();
        if (contentType == null || !ALLOWED_MIME_TYPES.contains(contentType.toLowerCase())) {
            throw new IllegalArgumentException("Type de fichier non supporté : " + contentType);
        }

        // Vérifier l'extension du fichier
        String extension = getFileExtension(filename).toLowerCase();
        if (extension.isEmpty() || !ALLOWED_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Extension de fichier non supportée : " + extension);
        }
    }

    /**
     * Sanitize le nom de fichier pour éviter les attaques
     * @param filename Nom de fichier original
     * @return Nom de fichier nettoyé et sécurisé
     */
    public static String sanitizeFilename(String filename) {
        if (filename == null || filename.isEmpty()) {
            return "file";
        }

        // Supprimer les tentatives de path traversal
        filename = filename.replaceAll("\\.\\.", "");
        filename = filename.replaceAll("[/\\\\]", "");

        // Supprimer les caractères spéciaux sauf points, tirets et underscores
        filename = filename.replaceAll("[^a-zA-Z0-9.\\-_]", "_");

        // Limiter la longueur à 100 caractères
        if (filename.length() > 100) {
            String ext = getFileExtension(filename);
            String name = filename.substring(0, 100 - ext.length());
            filename = name + ext;
        }

        return filename;
    }

    /**
     * Extrait l'extension d'un nom de fichier
     * @param filename Nom du fichier
     * @return Extension avec le point (ex: ".jpg") ou chaîne vide
     */
    public static String getFileExtension(String filename) {
        if (filename == null || filename.isEmpty()) {
            return "";
        }
        int lastDot = filename.lastIndexOf('.');
        return lastDot > 0 ? filename.substring(lastDot) : "";
    }
}
