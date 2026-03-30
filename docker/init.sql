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

-- Article 1
INSERT INTO articles (id, titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (1,
        'Guerre en Iran : Analyse des tensions géopolitiques',
        'guerre-iran-analyse-tensions',
        '<h1>Guerre en Iran : Analyse des tensions géopolitiques</h1><p>La situation actuelle en Iran montre une escalade des tensions sans précédent depuis plusieurs décennies. Les puissances régionales et mondiales observent avec inquiétude l''évolution du conflit.</p><h2>Les zones de conflit</h2><p>Les affrontements se concentrent principalement aux frontières nord et est du pays, où des groupes armés opposés aux forces gouvernementales ont intensifié leurs opérations depuis le début du mois.</p><h2>Réactions internationales</h2><p>La communauté internationale appelle au dialogue et à la désescalade. Plusieurs ambassades ont réduit leur personnel diplomatique en signe de précaution.</p>',
        'Suivez l''évolution de la guerre en Iran avec notre analyse détaillée des tensions géopolitiques actuelles.',
        '2026-03-31',
        'PUBLIE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO images (url_path, alt_text, article_id)
VALUES ('https://images.unsplash.com/photo-1579004465540-f4f1a4d22e37?w=1400&auto=format&fit=crop', 'Carte des tensions géopolitiques en Iran', 1),
       ('https://images.unsplash.com/photo-1569682840522-90c04b4cb199?w=800&auto=format&fit=crop', 'Positions militaires à la frontière iranienne', 1)
ON CONFLICT DO NOTHING;

-- Article 2
INSERT INTO articles (id, titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (2,
        'Économie iranienne : l''impact des sanctions internationales',
        'economie-iranienne-impact-sanctions',
        '<h1>Économie iranienne : l''impact des sanctions internationales</h1><p>Les sanctions économiques imposées à l''Iran continuent de peser lourdement sur l''économie nationale. Le rial iranien a perdu plus de 40% de sa valeur au cours des six derniers mois.</p><h2>Secteurs les plus touchés</h2><p>Le secteur pétrolier, pilier de l''économie iranienne, est le plus affecté. Les exportations ont chuté de 60% depuis le renforcement des sanctions en début d''année.</p><h2>Réponse du gouvernement</h2><p>Téhéran mise sur une politique d''économie de résistance pour faire face aux pressions extérieures, encourageant la production nationale et les échanges avec des pays partenaires.</p>',
        'Analyse de l''impact des sanctions internationales sur l''économie iranienne et les perspectives pour 2026.',
        '2026-03-29',
        'PUBLIE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO images (url_path, alt_text, article_id)
VALUES ('https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=1400&auto=format&fit=crop', 'Marché financier et économie iranienne', 2)
ON CONFLICT DO NOTHING;

-- Article 3
INSERT INTO articles (id, titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (3,
        'Diplomatie : les négociations sur le nucléaire iranien reprennent',
        'diplomatie-negociations-nucleaire-iranien',
        '<h1>Diplomatie : les négociations sur le nucléaire iranien reprennent</h1><p>Après plusieurs mois d''interruption, les pourparlers entre l''Iran et les grandes puissances ont repris à Vienne sous l''égide de l''Union Européenne.</p><h2>Les points de blocage</h2><p>Les principales divergences portent sur le niveau d''enrichissement de l''uranium autorisé et sur la levée progressive des sanctions économiques. L''Iran exige des garanties solides avant tout accord.</p><h2>Espoirs et incertitudes</h2><p>Les diplomates se montrent prudemment optimistes quant à la possibilité d''un accord d''ici la fin du trimestre, bien que de nombreux obstacles restent à surmonter.</p>',
        'Reprise des négociations sur le nucléaire iranien à Vienne : enjeux, blocages et perspectives d''accord.',
        '2026-03-28',
        'PUBLIE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO images (url_path, alt_text, article_id)
VALUES ('https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=1400&auto=format&fit=crop', 'Table de négociations diplomatiques', 3)
ON CONFLICT DO NOTHING;
