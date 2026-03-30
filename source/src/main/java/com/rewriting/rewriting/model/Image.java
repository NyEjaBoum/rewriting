package com.rewriting.rewriting.model;

import jakarta.persistence.*;

@Entity
@Table(name = "images")
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "url_path", nullable = false)
    private String urlPath;

    @Column(name = "alt_text", nullable = false)
    private String altText;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_id")
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
