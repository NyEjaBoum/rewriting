package com.rewriting.rewriting.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ArticleUrlRewriteFilter implements Filter {
    // Exemple d'URL : /mon-slug-123-20260330.html
        private static final Pattern URL_PATTERN = Pattern.compile("/([a-z0-9\\-]+)-([0-9]+)-([0-9]{8}|[0-9]{4}-[0-9]{2}-[0-9]{2})\\.html$");

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Rien à initialiser
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpReq = (HttpServletRequest) request;
            String uri = httpReq.getRequestURI();
            Matcher matcher = URL_PATTERN.matcher(uri);
            if (matcher.find()) {
                String slug = matcher.group(1);
                String id = matcher.group(2);
                String date = matcher.group(3);
                // Ajoute les paramètres à la requête
                request.setAttribute("slug", slug);
                request.setAttribute("id", id);
                request.setAttribute("date", date);
                // Forward vers le servlet ou JSP cible (ex: /article)
                request.getRequestDispatcher("/article").forward(request, response);
                return;
            }
        }
        // Sinon, continue normalement
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Rien à détruire
    }
}
