package com.rewriting.rewriting.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/robots.txt")
public class RobotsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=UTF-8");

        String scheme = request.getScheme();
        String host = request.getServerName();
        int port = request.getServerPort();
        String contextPath = request.getContextPath();

        String baseUrl = scheme + "://" + host;
        if (!((scheme.equals("http") && port == 80) || (scheme.equals("https") && port == 443))) {
            baseUrl += ":" + port;
        }
        baseUrl += contextPath;

        response.getWriter().print(
            "User-agent: *\n" +
            "Allow: /\n" +
            "Disallow: /admin/\n" +
            "Disallow: /WEB-INF/\n" +
            "\n" +
            "Sitemap: " + baseUrl + "/sitemap.xml\n"
        );
    }
}
