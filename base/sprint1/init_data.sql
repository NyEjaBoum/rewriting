-- Utilisateur par défaut
INSERT INTO utilisateurs (username, password) VALUES ('admin', 'test');

-- Article 1 : Exemple avec h1, titre et slug alignés
INSERT INTO articles (id, titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (9555,
        'Guerre en Iran : Analyse des tensions geopolitiques',
        'guerre-iran-analyse-tensions',
        '<h1>Guerre en Iran : Analyse des tensions geopolitiques</h1><p><em>Hello</em>, <span style="text-decoration: underline;"><strong>World!</strong></span></p><p>La situation actuelle montre une escalade...</p><h2>Les zones de conflit</h2><p>Détails ici...</p>',
        'Suivez l''évolution de la guerre en Iran avec notre analyse détaillée des tensions géopolitiques actuelles.',
        '2026-03-31',
        'PUBLIE');

-- Images liées à l'article 9555
INSERT INTO images (url_path, alt_text, article_id) 
VALUES ('/img/carte-conflit.jpg', 'Carte des tensions de la guerre en Iran', 9555),
       ('/img/soldats.jpg', 'Positions militaires à la frontière iranienne', 9555);

       