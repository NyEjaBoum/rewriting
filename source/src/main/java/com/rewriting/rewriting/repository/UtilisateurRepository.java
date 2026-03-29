package com.rewriting.rewriting.repository;

import com.rewriting.rewriting.model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    Utilisateur findByUsername(String username);
    // Ajoutez des méthodes personnalisées ici si besoin
}
