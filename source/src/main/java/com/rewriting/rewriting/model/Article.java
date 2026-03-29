package com.rewriting.rewriting.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "articles")
public class Article {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titre;

    @Column(nullable = false, unique = true)
    private String slug;

    @Column(name = "contenu_html", columnDefinition = "TEXT")
    private String contenuHtml;

    @Column(name = "meta_description", length = 160)
    private String metaDescription;

    @Column(name = "date_pub")
    @Temporal(TemporalType.DATE)
    private Date datePub;

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
}
