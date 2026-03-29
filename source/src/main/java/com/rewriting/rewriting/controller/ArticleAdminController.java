package com.rewriting.rewriting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/articles")
public class ArticleAdminController {

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("formTitle", "Créer un nouvel article");
        model.addAttribute("actionUrl", "/admin/articles/add");
        // Pas d'article à pré-remplir
        return "/admin/article/form";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam(required = false) Long id, Model model) {
        // À adapter pour charger l'article si besoin
        model.addAttribute("formTitle", "Éditer l'article");
        model.addAttribute("actionUrl", "/admin/articles/edit");
        // model.addAttribute("article", articleService.getById(id));
        return "/admin/article/form";
    }
}
