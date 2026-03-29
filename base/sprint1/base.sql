CREATE DATABASE rewriting; -- À exécuter séparément si besoin
\c rewriting;

-- Table pour le Login (Scénario 1)
CREATE TABLE IF NOT EXISTS utilisateurs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Table Articles : Coeur du SEO (Scénario 2)
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,        -- Deviendra le <h1> et le <title>
    slug VARCHAR(255) NOT NULL,         -- Deviendra l'URL (ex: guerre-iran)
    contenu_html TEXT,                  -- Stocke le HTML brut (ex: <h1>...</h1>)
    meta_description VARCHAR(160),      -- Pour Google
    date_pub DATE NOT NULL              -- Pour l'URL et le tri
);

-- Table Images : Galerie avec ALT (Scénario 1 & 2)
CREATE TABLE IF NOT EXISTS images (
    id SERIAL PRIMARY KEY,
    url_path VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255) NOT NULL,     -- Mots-clés secondaires (Point 5 du barème)
    article_id INT,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);