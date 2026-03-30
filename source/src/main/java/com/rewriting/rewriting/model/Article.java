package com.rewriting.rewriting.model;

import java.util.Date;

public class Article {
    private Long id;
    private String titre;
    private String slug;
    private String contenuHtml;
    private String metaDescription;
    private Date datePub;

    // Relation avec les images
    private java.util.List<com.rewriting.rewriting.model.Image> images;

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getContenuHtml() { return contenuHtml; }
    public void setContenuHtml(String contenuHtml) { this.contenuHtml = contenuHtml; }

    public String getMetaDescription() { return metaDescription; }
    public void setMetaDescription(String metaDescription) { this.metaDescription = metaDescription; }

    public Date getDatePub() { return datePub; }
    public void setDatePub(Date datePub) { this.datePub = datePub; }

    public java.util.List<com.rewriting.rewriting.model.Image> getImages() { return images; }
    public void setImages(java.util.List<com.rewriting.rewriting.model.Image> images) { this.images = images; }
}
