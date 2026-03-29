package com.rewriting.rewriting.controller;

import com.rewriting.rewriting.model.Article;
import com.rewriting.rewriting.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
@Controller
@RequestMapping("/admin/articles")
public class AdminController {

    @Autowired
    private ArticleService articleService;

    // Liste des articles
    @GetMapping
    public String listArticles(Model model) {
        List<Article> articles = articleService.findAll();
        model.addAttribute("articles", articles);
        return "admin/article/list";
    }

    // Formulaire d'ajout
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("formTitle", "Créer un nouvel article");
        model.addAttribute("actionUrl", "/admin/articles/add");
        return "admin/article/form";
    }

    // Création d'un article
    @PostMapping("/add")
    public String addArticle(@RequestParam String titre,
                             @RequestParam String slug,
                             @RequestParam String meta_description,
                             @RequestParam String contenu_html,
                             @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date date_pub,
                             RedirectAttributes redirectAttributes) {
        if (articleService.existsBySlug(slug)) {
            redirectAttributes.addFlashAttribute("error", "Ce slug existe déjà.");
            return "redirect:/admin/articles/add";
        }
        Article article = new Article();
        article.setTitre(titre);
        article.setSlug(slug);
        article.setMetaDescription(meta_description);
        article.setContenuHtml(contenu_html);
        if (date_pub != null) {
            article.setDatePub(date_pub);
        } else {
            article.setDatePub(new Date());
        }
        articleService.save(article);
        redirectAttributes.addFlashAttribute("success", "Article créé avec succès !");
        return "redirect:/admin/articles";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Article article = articleService.findById(id);
        if (article == null) return "redirect:/admin/articles";
        model.addAttribute("formTitle", "Éditer l'article");
        model.addAttribute("actionUrl", "/admin/articles/edit/" + id);
        model.addAttribute("article", article);
        return "admin/article/form";
    }

    // Mise à jour de l'article
    @PostMapping("/edit/{id}")
    public String editArticle(@PathVariable Long id,
                              @RequestParam String titre,
                              @RequestParam String slug,
                              @RequestParam String meta_description,
                              @RequestParam String contenu_html,
                              RedirectAttributes redirectAttributes) {
        Article article = articleService.findById(id);
        if (article == null) return "redirect:/admin/articles";
        article.setTitre(titre);
        article.setSlug(slug);
        article.setMetaDescription(meta_description);
        article.setContenuHtml(contenu_html);
        articleService.save(article);
        redirectAttributes.addFlashAttribute("success", "Article modifié !");
        return "redirect:/admin/articles";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        articleService.deleteById(id);
        redirectAttributes.addFlashAttribute("success", "Article supprimé !");
        return "redirect:/admin/articles";
    }
}