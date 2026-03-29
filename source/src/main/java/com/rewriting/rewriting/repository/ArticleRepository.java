package com.rewriting.rewriting.repository;

import com.rewriting.rewriting.model.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    boolean existsBySlug(String slug);
    Article findBySlug(String slug);
}