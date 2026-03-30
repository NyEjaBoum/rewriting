-- ============================================
-- DONNÉES SUPPLÉMENTAIRES POUR TESTS
-- Articles avec différents statuts, dates et formats
-- Version UTF-8 compatible
-- ============================================

-- Article 2 : Publie, ancien, avec un format different
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'L''economie iranienne face aux sanctions internationales',
    'economie-iranienne-sanctions-internationales',
    '<h1>L''economie iranienne face aux sanctions internationales</h1>
     <p>Publie le <time datetime="2026-01-15">15 janvier 2026</time> par la redaction.</p>
     <p>Les sanctions economiques imposees a l''Iran ont un impact considerable sur sa monnaie et son commerce exterieur. Le rial a perdu <strong>plus de 60% de sa valeur</strong> en deux ans.</p>
     <h2>Les secteurs les plus touches</h2>
     <ul>
         <li>Industrie petroliere : baisse de 40% des exportations</li>
         <li>Automobile : chute de 80% de la production</li>
         <li>Pharmaceutique : penuries chroniques</li>
     </ul>
     <h2>Les strategies de contournement</h2>
     <p>Teheran a developpe des mecanismes d''echange alternatifs avec la Chine et la Russie, contournant partiellement le systeme SWIFT.</p>
     <h3>Le role de la Chine</h3>
     <p>Pekin est devenu le premier partenaire commercial de l''Iran, important pres de <strong>90% du petrole iranien</strong> non sanctionne officiellement.</p>',
    'Analyse detaillee des consequences economiques des sanctions sur l''Iran : secteurs touches, strategies de contournement et perspectives 2026.',
    '2026-01-15',
    'PUBLIE'
);

-- Article 3 : Publie, avec beaucoup de contenu pour tester le scroll/affichage
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'Iran-Israel : la guerre de l''ombre dans le cyberespace',
    'iran-israel-cyberguerre-ombre',
    '<h1>Iran-Israel : la guerre de l''ombre dans le cyberespace</h1>
     <p>Depuis une decennie, les deux nations s''affrontent par ordinateurs interposes. Une <strong>cyberguerre silencieuse</strong> mais devastatrice.</p>
     <h2>Les attaques majeures recentes</h2>
     <ul>
         <li><strong>2025 :</strong> Piratage des systemes de controle des eaux israeliens (tentative)</li>
         <li><strong>2024 :</strong> Destruction de centrifugeuses iraniennes par le ver Stuxnet 2.0</li>
         <li><strong>2023 :</strong> Fuite de donnees sensibles de la marine iranienne</li>
     </ul>
     <h2>Les groupes impliques</h2>
     <p>Cote iranien, l''<em>Armee cybernetique de Dieu</em> et <em>APT34 (OilRig)</em> sont les plus actifs. Israel mobilise l''unite 8200 et des societes privees.</p>
     <h2>Consequences geopolitiques</h2>
     <p>Ces attaques redifinissent les regles d''engagement : <strong>pas de declaration de guerre officielle</strong>, mais des dommages reels sur les infrastructures critiques.</p>
     <h3>La position americaine</h3>
     <p>Washington soutient discretement les capacites cybernetiques de son allie israelien tout en maintenant un canal diplomatique avec Teheran.</p>',
    'Decouvrez comment Iran et Israel s''affrontent silencieusement dans une cyberguerre aux consequences strategiques majeures.',
    '2026-02-28',
    'PUBLIE'
);

-- Article 4 : Brouillon (non publie, pour tester le filtrage)
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'Interview exclusive : un diplomate iranien parle des negociations nucleaires',
    'interview-diplomate-iranien-nucleaire',
    '<h1>Interview exclusive : un diplomate iranien parle des negociations nucleaires</h1>
     <p><em>Propos recueillis a Geneve</em> - Notre journaliste a rencontre un haut fonctionnaire du ministere iranien des Affaires etrangeres sous couvert d''anonymat.</p>
     <h2>Sur l''etat des negociations</h2>
     <p>« Les Occidentaux doivent comprendre que la levee des sanctions est une condition sine qua non. Nous ne reculerons pas sur nos droits nucleaires. »</p>
     <h2>Les points de blocage</h2>
     <ul>
         <li>Les inspections de l''AIEA sur les sites militaires</li>
         <li>Le niveau d''enrichissement de l''uranium</li>
         <li>La duree de l''accord</li>
     </ul>
     <p>Cet article sera publie des validation de la source.</p>',
    'Interview exclusive d''un diplomate iranien sur les negociations nucleaires : points de blocage, attentes et perspectives.',
    '2026-04-15',
    'BROUILLON'
);

-- Article 5 : Publie, avec une date plus ancienne (2025)
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'Histoire des relations Iran-Etats-Unis : de l''alliance a la rupture',
    'histoire-relations-iran-usa-1953-2025',
    '<h1>Histoire des relations Iran-Etats-Unis : de l''alliance a la rupture</h1>
     <p>Un voyage dans le temps pour comprendre les racines de la mefiance actuelle entre Teheran et Washington.</p>
     <h2>1953 : le coup d''Etat de la CIA</h2>
     <p>Le renversement du Premier ministre Mossadegh, nationaliste petrolier, marque le debut du ressentiment iranien envers les Etats-Unis.</p>
     <h2>1979 : la revolution islamique et la prise d''otages</h2>
     <p>L''ambassade americaine prise d''assaut, 52 otages detenus pendant 444 jours. La rupture diplomatique est consommee.</p>
     <h2>2015 : l''espoir du JCPOA (accord nucleaire)</h2>
     <p>Une courte embellie apres 36 ans de tensions. L''accord sera dechire en 2018 par Donald Trump.</p>
     <h3>2020 : l''assassinat de Qassem Soleimani</h3>
     <p>Le general iranien tue par drone americain a Bagdad fait craindre une guerre ouverte, evitee de justesse.</p>
     <h2>Aujourd''hui : un dialogue impossible ?</h2>
     <p>Les canaux indirects persistent (Oman, Qatar) mais la confiance reste au point mort.</p>',
    'Retour sur 70 ans d''histoire tumultueuse entre l''Iran et les Etats-Unis, du coup d''Etat de 1953 a l''assassinat de Soleimani.',
    '2025-12-20',
    'PUBLIE'
);

-- Article 6 : Brouillon, pour tester le dashboard "Nouvel Article"
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'La question kurde en Iran : oubliee des medias ?',
    'kurdes-iran-droits-minorites',
    '<h1>La question kurde en Iran : oubliee des medias ?</h1>
     <p>Les Kurdes iraniens, pres de 10% de la population, font face a des discriminations systematiques.</p>
     <h2>Les revendications</h2>
     <ul>
         <li>Reconnaissance de la langue kurde dans l''administration</li>
         <li>Developpement economique des provinces de l''ouest</li>
         <li>Fin des executions de prisonniers kurdes</li>
     </ul>
     <h2>Repressions et soulevements</h2>
     <p>Depuis les manifestations de 2022, la region a connu une militarisation accrue.</p>
     <p><strong>Article en cours de verification</strong> - Sources a confirmer.</p>',
    'Analyse de la situation des Kurdes en Iran : revendications, repression et invisibilite mediatique.',
    '2026-04-20',
    'BROUILLON'
);

-- Article 7 : Publie, avec un format riche pour tester les liens internes
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut)
VALUES (
    'Guide : Comprendre la structure politique de l''Iran',
    'guide-structure-politique-iran',
    '<h1>Guide : Comprendre la structure politique de l''Iran</h1>
     <p>La Republique islamique d''Iran possede une <strong>structure unique au monde</strong> melant theocratie et democratie limitee. Voici les cles pour s''y retrouver.</p>
     <h2>Le Guide supreme (Rahbar)</h2>
     <p>Ali Khamenei, successeur de Khomeini, est le chef de l''Etat a vie. Il controle l''armee, les medias et nomme la moitie du Conseil des gardiens.</p>
     <h2>Le president</h2>
     <p>Elu au suffrage universel, il gere l''executif mais reste subordonne au Guide. Voir notre article sur <a href="/economie-iranienne-sanctions-internationales">l''impact economique des sanctions</a> pour comprendre ses contraintes.</p>
     <h2>Le Conseil des gardiens</h2>
     <p>12 theologiens et juristes qui valident (ou invalident) tous les candidats aux elections. Ils disposent d''un droit de veto sur les lois.</p>
     <h2>L''Assemblee des experts</h2>
     <p>Elue tous les 8 ans, elle designe et peut en theorie destituer le Guide supreme. Derniere election en 2024.</p>
     <h3>A lire aussi :</h3>
     <ul>
         <li><a href="/histoire-relations-iran-usa-1953-2025">Histoire Iran-USA : comprendre la rupture</a></li>
         <li><a href="/iran-israel-cyberguerre-ombre">La cyberguerre Iran-Israel</a></li>
         <li><a href="/guerre-iran-analyse-tensions">Analyse des tensions geopolitiques actuelles</a></li>
     </ul>',
    'Decouvrez la structure politique unique de l''Iran : Guide supreme, president, Conseil des gardiens... Les institutions expliquees simplement.',
    '2026-03-10',
    'PUBLIE'
);

-- ============================================
-- IMAGES SUPPLEMENTAIRES
-- Pour tester les galeries et les attributs ALT
-- ============================================

-- Images pour l'article 2 (economie)
INSERT INTO images (url_path, alt_text, article_id) 
VALUES 
    ('/img/graphique-rial.jpg', 'Graphique de la chute du rial iranien face au dollar entre 2020 et 2026', (SELECT id FROM articles WHERE slug = 'economie-iranienne-sanctions-internationales')),
    ('/img/petrole-iran.jpg', 'Terminal petrolier iranien sur l''ile de Kharg', (SELECT id FROM articles WHERE slug = 'economie-iranienne-sanctions-internationales'));

-- Images pour l'article 3 (cyberguerre)
INSERT INTO images (url_path, alt_text, article_id) 
VALUES 
    ('/img/cyber-defense-iran.jpg', 'Centre de cyberdefense iranien a Teheran', (SELECT id FROM articles WHERE slug = 'iran-israel-cyberguerre-ombre')),
    ('/img/stuxnet-attaque.jpg', 'Schema de l''attaque Stuxnet contre les centrifugeuses iraniennes', (SELECT id FROM articles WHERE slug = 'iran-israel-cyberguerre-ombre'));

-- Images pour l'article 5 (histoire)
INSERT INTO images (url_path, alt_text, article_id) 
VALUES 
    ('/img/mossadegh-1953.jpg', 'Mossadegh lors de son arrestation par la CIA en 1953', (SELECT id FROM articles WHERE slug = 'histoire-relations-iran-usa-1953-2025')),
    ('/img/prise-otages-1979.jpg', 'Etudiants iraniens devant l''ambassade americaine a Teheran en 1979', (SELECT id FROM articles WHERE slug = 'histoire-relations-iran-usa-1953-2025')),
    ('/img/soleimani-funerailles.jpg', 'Foule aux funerailles du general Qassem Soleimani en 2020', (SELECT id FROM articles WHERE slug = 'histoire-relations-iran-usa-1953-2025'));

-- Image pour l'article 7 (guide politique)
INSERT INTO images (url_path, alt_text, article_id) 
VALUES 
    ('/img/khamenei-khomeini.jpg', 'Le Guide supreme Ali Khamenei et l''imam Khomeini lors de la revolution de 1979', (SELECT id FROM articles WHERE slug = 'guide-structure-politique-iran'));
