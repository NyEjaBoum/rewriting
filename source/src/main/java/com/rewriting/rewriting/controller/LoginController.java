package com.rewriting.rewriting.controller;

import com.rewriting.rewriting.model.Utilisateur;
import com.rewriting.rewriting.service.UtilisateurService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private UtilisateurService utilisateurService;

    @GetMapping("/login")
    public String loginForm(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Identifiant ou mot de passe incorrect.");
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpServletRequest request, Model model) {
        Utilisateur utilisateur = utilisateurService.verifierIdentifiants(username, password);
        if (utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", utilisateur);
            return "redirect:/admin/articles/add";
        } else {
            model.addAttribute("error", "Identifiants invalides");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
