package com.rewriting.rewriting.model;

public class Image {

    private Long id;
    private String urlPath;
    private String altText;
    private Article article;

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUrlPath() { return urlPath; }
    public void setUrlPath(String urlPath) { this.urlPath = urlPath; }

    public String getAltText() { return altText; }
    public void setAltText(String altText) { this.altText = altText; }

    public Article getArticle() { return article; }
    public void setArticle(Article article) { this.article = article; }
}
