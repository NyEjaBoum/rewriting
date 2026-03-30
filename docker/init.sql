-- Tables
CREATE TABLE IF NOT EXISTS utilisateurs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    contenu_html TEXT,
    meta_description VARCHAR(160),
    date_pub DATE NOT NULL,
    statut VARCHAR(20) DEFAULT 'BROUILLON' CHECK (statut IN ('BROUILLON', 'PUBLIE'))
);

CREATE TABLE IF NOT EXISTS images (
    id SERIAL PRIMARY KEY,
    url_path VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255) NOT NULL,
    article_id INT,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- Données initiales
INSERT INTO utilisateurs (username, password)
VALUES ('admin', 'test')
ON CONFLICT (username) DO NOTHING;

INSERT INTO articles (id, titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (9555,
        'Guerre en Iran : Analyse des tensions geopolitiques',
        'guerre-iran-analyse-tensions',
        '<h1>Guerre en Iran : Analyse des tensions geopolitiques</h1><p><em>Hello</em>, <span style="text-decoration: underline;"><strong>World!</strong></span></p><p>La situation actuelle montre une escalade...</p><h2>Les zones de conflit</h2><p>Détails ici...</p>',
        'Suivez l''évolution de la guerre en Iran avec notre analyse détaillée des tensions géopolitiques actuelles.',
        '2026-03-31',
        'PUBLIE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO images (url_path, alt_text, article_id)
VALUES ('/img/carte-conflit.jpg', 'Carte des tensions de la guerre en Iran', 9555),
       ('/img/soldats.jpg', 'Positions militaires à la frontière iranienne', 9555);
