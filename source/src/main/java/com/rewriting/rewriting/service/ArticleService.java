package com.rewriting.rewriting.service;

import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleService {
    @Autowired
    private ArticleRepository articleRepository;

    public List<Article> findAll() {
        return articleRepository.findAll();
    }

    public boolean existsBySlug(String slug) {
        return articleRepository.existsBySlug(slug);
    }

    public Article findById(Long id) {
        return articleRepository.findById(id).orElse(null);
    }

    public Article save(Article article) {
        return articleRepository.save(article);
    }

    public void deleteById(Long id) {
        articleRepository.deleteById(id);
    }
}
