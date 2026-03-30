package com.rewriting.rewriting.util;

import java.text.Normalizer;

public class SlugUtils {

    public static String generate(String titre) {
        if (titre == null || titre.isBlank()) return "";

        String slug = titre.toLowerCase().trim();

        // Supprimer les accents
        slug = Normalizer.normalize(slug, Normalizer.Form.NFD)
                .replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

        // Remplacer tout ce qui n'est pas alphanumérique par des tirets
        slug = slug.replaceAll("[^a-z0-9]+", "-");

        // Nettoyer les tirets en début/fin
        slug = slug.replaceAll("(^-|-$)", "");

        // Limiter à 100 caractères sans couper en milieu de mot
        if (slug.length() > 100) {
            slug = slug.substring(0, 100).replaceAll("-$", "");
        }

        return slug;
    }
}
