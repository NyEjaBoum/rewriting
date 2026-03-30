package com.rewriting.rewriting.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String contextPath = httpRequest.getContextPath();
        String path = httpRequest.getRequestURI().substring(contextPath.length());


        // Exclure les fichiers statiques
        if (path.startsWith("/css/") || path.endsWith(".css") || path.startsWith("/js/") || path.endsWith(".js") ||
            path.startsWith("/images/") || path.startsWith("/uploads/") || path.endsWith(".png") || path.endsWith(".jpg") ||
            path.endsWith(".gif") || path.endsWith(".webp") || path.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        // Exclure les pages de login
        if (path.endsWith("/login") || path.endsWith("/login.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Protéger uniquement les pages admin
        if (path.contains("/admin/")) {
            HttpSession session = httpRequest.getSession(false);
            boolean isLoggedIn = session != null && session.getAttribute("user") != null;

            if (!isLoggedIn) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}