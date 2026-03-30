-- Migration : Ajouter la colonne statut + uniqueness au slug
-- À exécuter sur une base existante

-- Ajouter la contrainte UNIQUE sur slug si elle n'existe pas
ALTER TABLE articles ADD CONSTRAINT articles_slug_unique UNIQUE (slug);

-- Ajouter la colonne statut avec une valeur par défaut
ALTER TABLE articles ADD COLUMN IF NOT EXISTS statut VARCHAR(20) DEFAULT 'BROUILLON';

-- Ajouter la contrainte CHECK
ALTER TABLE articles ADD CONSTRAINT articles_statut_check CHECK (statut IN ('BROUILLON', 'PUBLIE'));

-- Mettre à jour l'article existant en PUBLIE
UPDATE articles SET statut = 'PUBLIE' WHERE id = 9555;
