package com.rewriting.rewriting.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

import java.io.*;
import java.util.zip.GZIPOutputStream;

/**
 * Filtre qui :
 * - compresse les réponses en gzip si le client l'accepte
 * - ajoute des en-têtes de cache long pour les assets statiques (css, js, images)
 */
@WebFilter("/*")
public class GzipCacheFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        // Cache longue durée pour les assets statiques (1 an)
        String uri = httpReq.getRequestURI();
        if (uri.matches(".+\\.(css|js|woff2?|ttf|eot|svg|png|jpg|jpeg|gif|ico|webp)$")) {
            httpResp.setHeader("Cache-Control", "public, max-age=31536000, immutable");
        }

        // Gzip si le navigateur l'accepte
        String acceptEncoding = httpReq.getHeader("Accept-Encoding");
        if (acceptEncoding != null && acceptEncoding.contains("gzip")) {
            GzipResponseWrapper gzipWrapper = new GzipResponseWrapper(httpResp);
            try {
                chain.doFilter(request, gzipWrapper);
            } finally {
                gzipWrapper.finish();
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    // ── Wrapper gzip ──────────────────────────────────────────────────────────

    private static class GzipResponseWrapper extends HttpServletResponseWrapper {
        private GzipOutputStream gzipOutputStream;
        private PrintWriter      printWriter;

        GzipResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public ServletOutputStream getOutputStream() throws IOException {
            if (printWriter != null) {
                throw new IllegalStateException("getWriter() already called");
            }
            if (gzipOutputStream == null) {
                gzipOutputStream = new GzipOutputStream((HttpServletResponse) getResponse());
            }
            return gzipOutputStream;
        }

        @Override
        public PrintWriter getWriter() throws IOException {
            if (gzipOutputStream != null) {
                throw new IllegalStateException("getOutputStream() already called");
            }
            if (printWriter == null) {
                gzipOutputStream = new GzipOutputStream((HttpServletResponse) getResponse());
                printWriter = new PrintWriter(new OutputStreamWriter(gzipOutputStream, getCharacterEncoding()));
            }
            return printWriter;
        }

        @Override
        public void setContentLength(int len) { /* ignore — la taille changera avec gzip */ }

        @Override
        public void setContentLengthLong(long len) { /* ignore */ }

        void finish() throws IOException {
            if (printWriter != null) {
                printWriter.flush();
            }
            if (gzipOutputStream != null) {
                gzipOutputStream.finish();
            }
        }
    }

    // ── ServletOutputStream gzip ─────────────────────────────────────────────

    private static class GzipOutputStream extends ServletOutputStream {
        private final GZIPOutputStream gzip;
        private final HttpServletResponse response;

        GzipOutputStream(HttpServletResponse response) throws IOException {
            this.response = response;
            response.setHeader("Content-Encoding", "gzip");
            response.setHeader("Vary", "Accept-Encoding");
            this.gzip = new GZIPOutputStream(response.getOutputStream(), true);
        }

        @Override public void write(int b) throws IOException { gzip.write(b); }
        @Override public void write(byte[] b, int off, int len) throws IOException { gzip.write(b, off, len); }
        @Override public void flush() throws IOException { gzip.flush(); }
        @Override public boolean isReady() { return true; }
        @Override public void setWriteListener(WriteListener l) {}

        void finish() throws IOException { gzip.finish(); }
    }
}
