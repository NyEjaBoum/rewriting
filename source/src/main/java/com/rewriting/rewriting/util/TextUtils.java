package com.rewriting.rewriting.util;

public class TextUtils {

    /**
     * Supprime toutes les balises HTML d'une chaîne de caractères
     * @param html Le contenu HTML à nettoyer
     * @return Le texte brut sans balises HTML
     */
    public static String stripHtmlTags(String html) {
        if (html == null || html.isEmpty()) {
            return "";
        }

        // Supprimer les balises HTML
        String text = html.replaceAll("<[^>]*>", "");

        // Décoder les entités HTML courantes
        text = text.replace("&nbsp;", " ")
                   .replace("&amp;", "&")
                   .replace("&lt;", "<")
                   .replace("&gt;", ">")
                   .replace("&quot;", "\"")
                   .replace("&#39;", "'")
                   .replace("&apos;", "'");

        // Remplacer les espaces multiples par un seul espace
        text = text.replaceAll("\\s+", " ");

        // Supprimer les espaces en début et fin
        return text.trim();
    }

    /**
     * Extrait un extrait de texte d'un contenu HTML
     * @param html Le contenu HTML
     * @param maxLength La longueur maximale de l'extrait
     * @return L'extrait de texte avec "..." à la fin si tronqué
     */
    public static String getExcerpt(String html, int maxLength) {
        if (html == null || html.isEmpty()) {
            return "";
        }

        String plainText = stripHtmlTags(html);

        if (plainText.length() <= maxLength) {
            return plainText;
        }

        // Tronquer à maxLength et ajouter "..."
        String excerpt = plainText.substring(0, maxLength);

        // Essayer de couper au dernier espace pour éviter de couper un mot
        int lastSpace = excerpt.lastIndexOf(' ');
        if (lastSpace > maxLength - 20) { // Si l'espace n'est pas trop loin
            excerpt = excerpt.substring(0, lastSpace);
        }

        return excerpt + "...";
    }
}
