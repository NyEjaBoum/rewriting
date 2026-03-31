-- Tables
CREATE TABLE IF NOT EXISTS utilisateurs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nom_complet VARCHAR(100) NOT NULL DEFAULT 'Rédaction'
);

CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    contenu_html TEXT,
    meta_description VARCHAR(160),
    date_pub DATE NOT NULL,
    statut VARCHAR(20) DEFAULT 'BROUILLON' CHECK (statut IN ('BROUILLON', 'PUBLIE')),
    auteur_nom VARCHAR(100) NOT NULL DEFAULT 'Rédaction'
);

CREATE TABLE IF NOT EXISTS images (
    id SERIAL PRIMARY KEY,
    url_path VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255) NOT NULL,
    article_id INT,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- Utilisateurs
INSERT INTO utilisateurs (id, username, password, nom_complet) VALUES
(1, 'smartin',  'Sophie2026!',  'Sophie Martin'),
(2, 'tleroy',   'Thomas2026!',  'Thomas Leroy'),
(3, 'admin',    'Admin2026!',   'Admin Système')
ON CONFLICT (username) DO NOTHING;

-- Articles
INSERT INTO articles (titre, slug, contenu_html, meta_description, date_pub, statut, auteur_nom) VALUES
('Bilan des 48 dernières heures : point complet sur le conflit',
 'bilan-48h-point-complet-conflit',
 '<h1>Bilan des 48 dernières heures : point complet sur le conflit</h1><p>Les dernières 48 heures ont été marquées par une intensification des combats dans plusieurs zones stratégiques du pays. Les forces en présence ont multiplié les offensives et contre-offensives, redessinant partiellement les lignes de front.</p><h2>Évolution des lignes de front</h2><p>Selon les sources militaires indépendantes, les positions ont évolué significativement dans le nord-ouest du pays, où des villages ont changé de mains à plusieurs reprises. La ville de Tabriz reste sous tension avec des mouvements de troupes importants signalés en périphérie.</p><h2>Bilan humain provisoire</h2><p>Les organisations humanitaires font état d''au moins 340 victimes civiles au cours de cette période, un chiffre susceptible d''être revu à la hausse à mesure que l''accès aux zones de conflit est rétabli. Des milliers de personnes ont fui vers les centres urbains voisins.</p><h2>Réactions des belligérants</h2><p>Les deux parties revendiquent des avancées territoriales et nient les pertes rapportées par l''adversaire. La situation reste extrêmement volatile et difficile à vérifier de manière indépendante.</p>',
 'Bilan complet des 48 dernières heures de conflit en Iran : évolution des fronts, victimes et réactions.',
 '2026-03-31', 'PUBLIE', 'Sophie Martin'),

('Économie iranienne : l''impact des sanctions internationales',
 'economie-iranienne-impact-sanctions',
 '<h1>Économie iranienne : l''impact des sanctions internationales</h1><p>Les sanctions économiques imposées à l''Iran continuent de peser lourdement sur l''économie nationale. Le rial iranien a perdu plus de 40% de sa valeur au cours des six derniers mois, plongeant des millions de foyers dans une précarité accrue.</p><h2>Secteurs les plus touchés</h2><p>Le secteur pétrolier, pilier de l''économie iranienne, est le plus affecté. Les exportations ont chuté de 60% depuis le renforcement des sanctions en début d''année. Le secteur bancaire, coupé du système SWIFT, peine à financer les importations de biens essentiels.</p><h2>Réponse du gouvernement</h2><p>Téhéran mise sur une politique d''économie de résistance pour faire face aux pressions extérieures, encourageant la production nationale et les échanges bilatéraux avec des pays partenaires comme la Chine et la Russie. Des marchés parallèles ont émergé pour contourner les restrictions.</p><h2>Impact sur la population</h2><p>L''inflation dépasse les 45% annuels, rendant l''accès aux denrées alimentaires et aux médicaments particulièrement difficile pour les classes moyennes et populaires. La grogne sociale monte dans les grandes villes.</p>',
 'Analyse de l''impact des sanctions internationales sur l''économie iranienne et les perspectives pour 2026.',
 '2026-03-29', 'PUBLIE', 'Thomas Leroy'),

('Diplomatie : les négociations sur le nucléaire iranien reprennent',
 'diplomatie-negociations-nucleaire-iranien',
 '<h1>Diplomatie : les négociations sur le nucléaire iranien reprennent</h1><p>Après plusieurs mois d''interruption, les pourparlers entre l''Iran et les grandes puissances ont repris à Vienne sous l''égide de l''Union Européenne. Les délégations sont arrivées avec des positions durcies, mais une volonté affichée d''aboutir.</p><h2>Les points de blocage</h2><p>Les principales divergences portent sur le niveau d''enrichissement de l''uranium autorisé et sur la levée progressive des sanctions économiques. L''Iran exige des garanties solides et juridiquement contraignantes avant tout accord, une demande que Washington considère excessive.</p><h2>Espoirs et incertitudes</h2><p>Les diplomates se montrent prudemment optimistes quant à la possibilité d''un accord d''ici la fin du trimestre, bien que de nombreux obstacles restent à surmonter. L''élection présidentielle américaine à venir complique davantage le calendrier des négociations.</p><h2>Réactions régionales</h2><p>Israël et l''Arabie Saoudite surveillent de près ces négociations, craignant qu''un accord trop favorable à Téhéran ne renforce sa capacité à déstabiliser la région. Les deux pays ont multiplié les contacts diplomatiques pour faire valoir leurs préoccupations.</p>',
 'Reprise des négociations sur le nucléaire iranien à Vienne : enjeux, blocages et perspectives d''accord.',
 '2026-03-28', 'PUBLIE', 'Sophie Martin'),

('Géopolitique : les alliances régionales face au conflit iranien',
 'geopolitique-alliances-regionales-conflit-iranien',
 '<h1>Géopolitique : les alliances régionales face au conflit iranien</h1><p>Le conflit en Iran redessine les équilibres géopolitiques du Moyen-Orient à une vitesse inédite. Les puissances régionales revoient leurs alliances stratégiques, oscillant entre pragmatisme économique et rivalités idéologiques historiques.</p><h2>Le bloc pro-iranien fragilisé</h2><p>Le Hezbollah libanais et les milices irakiennes alliées de Téhéran font face à des pressions internes croissantes. La population de ces pays, épuisée par des années d''instabilité, est de moins en moins favorable à un soutien inconditionnel à l''Iran en guerre.</p><h2>Les puissances du Golfe repositionnées</h2><p>L''Arabie Saoudite et les Émirats arabes unis adoptent une position de prudence calculée. Sans se réjouir ouvertement des difficultés iraniennes, ils intensifient discrètement leur coopération sécuritaire avec les États-Unis et diversifient leurs approvisionnements énergétiques.</p><h2>La Turquie joue sa propre partition</h2><p>Ankara, partageant une longue frontière avec l''Iran, craint avant tout les flux migratoires et l''instabilité à ses portes. La Turquie maintient des canaux de communication ouverts avec toutes les parties et se positionne comme médiateur potentiel.</p>',
 'Comment le conflit iranien redessine les alliances géopolitiques régionales au Moyen-Orient en 2026.',
 '2026-03-27', 'PUBLIE', 'Thomas Leroy'),

('Crise humanitaire : deux millions de déplacés internes en Iran',
 'crise-humanitaire-deplaces-internes-iran',
 '<h1>Crise humanitaire : deux millions de déplacés internes en Iran</h1><p>Le Haut-Commissariat des Nations Unies pour les réfugiés (HCR) a confirmé ce lundi que le nombre de personnes déplacées à l''intérieur de l''Iran a franchi le seuil des deux millions. Ce chiffre, en augmentation de 30% en l''espace d''un mois, témoigne de l''aggravation de la situation humanitaire sur le terrain.</p><h2>Des convois d''aide bloqués</h2><p>Les organisations humanitaires internationales dénoncent des entraves systématiques à l''acheminement de l''aide. Plusieurs convois du Comité international de la Croix-Rouge (CICR) ont été bloqués aux points de contrôle militaires depuis deux semaines, privant des populations vulnérables de vivres et de médicaments essentiels.</p><h2>Conditions dans les camps de fortune</h2><p>Les camps improvisés aux abords des grandes villes iraniennes accueillent des familles dans des conditions précaires. Surpeuplement, manque d''eau potable et absence de soins médicaux adéquats créent un terrain fertile pour la propagation de maladies.</p><h2>Appels à une trêve humanitaire</h2><p>L''ONU, soutenue par plusieurs ONG internationales, appelle les belligérants à instaurer des corridors humanitaires permettant l''accès aux populations les plus vulnérables. Cet appel, relayé par le Conseil de sécurité, reste pour l''heure sans réponse concrète des parties en conflit.</p>',
 'Le HCR confirme deux millions de déplacés internes en Iran. Conditions des camps et blocage de l''aide humanitaire.',
 '2026-03-26', 'PUBLIE', 'Sophie Martin'),

('Analyse : comment le conflit iranien remodèle le Moyen-Orient',
 'analyse-conflit-iranien-remodele-moyen-orient',
 '<h1>Analyse : comment le conflit iranien remodèle le Moyen-Orient</h1><p>Au-delà des opérations militaires quotidiennes, le conflit iranien produit des transformations profondes et durables sur l''ensemble de la région. Une analyse des dynamiques en jeu s''impose pour comprendre les implications à long terme de cette crise sans précédent.</p><h2>La fracture chiite-sunnite accentuée</h2><p>Le conflit exacerbe les tensions confessionnelles déjà présentes dans la région. Des minorités chiites au Bahreïn, en Arabie Saoudite et au Koweït se trouvent dans une position inconfortable, tiraillées entre leur appartenance nationale et leurs solidarités religieuses. Cette fracture pourrait déstabiliser durablement plusieurs États du Golfe.</p><h2>Le reconfiguration des flux énergétiques</h2><p>L''Iran représentait environ 3% de la production mondiale de pétrole avant le conflit. Sa mise hors jeu partielle oblige les marchés à se reconfigurer. Les pays producteurs alternatifs, notamment l''Arabie Saoudite et l''Irak, augmentent leur production pour combler le déficit, mais les prix restent élevés en raison de l''incertitude géopolitique.</p><h2>L''émergence de nouvelles lignes de fracture</h2><p>Au-delà des clivages traditionnels, le conflit fait émerger de nouvelles lignes de fracture entre États favorables à une intervention internationale et ceux défendant la souveraineté nationale à tout prix. Cette division traverse les institutions régionales et internationales, paralysant les mécanismes de résolution de crise.</p>',
 'Analyse approfondie des impacts du conflit iranien sur les équilibres géopolitiques et économiques du Moyen-Orient.',
 '2026-03-25', 'PUBLIE', 'Thomas Leroy'),

('Offensives militaires dans le nord-ouest : bilan et enjeux stratégiques',
 'offensives-militaires-nord-ouest-bilan-strategique',
 '<h1>Offensives militaires dans le nord-ouest : bilan et enjeux stratégiques</h1><p>Les opérations militaires dans la région du nord-ouest iranien ont connu une accélération significative au cours de la dernière semaine. Les forces gouvernementales ont lancé plusieurs offensives coordonnées pour reprendre le contrôle de zones clés perdues au profit des groupes armés opposés.</p><h2>Objectifs stratégiques des opérations</h2><p>Le nord-ouest iranien revêt une importance stratégique considérable : il abrite d''importantes infrastructures pétrolières et gazières, et sa position frontalière avec la Turquie et l''Irak en fait un couloir de transit vital pour le ravitaillement des forces en présence.</p><h2>Les moyens déployés</h2><p>L''armée iranienne a engagé des unités d''élite des Gardiens de la révolution, appuyées par une artillerie lourde et des drones de combat. Des frappes aériennes ciblées ont visé des positions de commandement et des dépôts logistiques des groupes adverses.</p><h2>Enjeux pour la suite du conflit</h2><p>La maîtrise du nord-ouest conditionnerait en grande partie l''issue du conflit. Un succès gouvernemental dans cette région priverait les groupes armés d''une source importante d''approvisionnement et de revenus, tout en sécurisant des axes logistiques essentiels pour les forces loyalistes.</p>',
 'Bilan des offensives militaires dans le nord-ouest iranien et analyse des enjeux stratégiques de ces opérations.',
 '2026-03-24', 'PUBLIE', 'Sophie Martin'),

('Guerre en Iran : analyse des tensions géopolitiques et origines du conflit',
 'guerre-iran-analyse-tensions-geopolitiques-origines',
 '<h1>Guerre en Iran : analyse des tensions géopolitiques et origines du conflit</h1><p>La situation actuelle en Iran est l''aboutissement d''une accumulation de tensions sur plusieurs décennies. Pour comprendre l''ampleur de la crise, il convient de revenir sur les facteurs structurels qui ont conduit à l''explosion de violence que le pays connaît aujourd''hui.</p><h2>Les racines économiques et sociales</h2><p>Une économie exsangue, une jeunesse sans perspectives et une inégalité croissante ont créé un terreau fertile pour la contestation. Les sanctions internationales, loin d''affaiblir le régime, ont renforcé les mafias économiques proches du pouvoir tout en appauvrissant la classe moyenne, historiquement stabilisatrice.</p><h2>Le rôle des acteurs extérieurs</h2><p>Plusieurs puissances régionales et mondiales sont soupçonnées d''alimenter le conflit, directement ou indirectement. Les livraisons d''armes, le financement de groupes armés et les campagnes de désinformation sur les réseaux sociaux contribuent à l''entretien d''une guerre qui profite à certains acteurs extérieurs.</p><h2>Perspectives de résolution</h2><p>Les experts s''accordent sur un point : une solution militaire seule ne pourra pas résoudre un conflit aux racines aussi profondes. Seule une approche globale, incluant des réformes politiques, une réconciliation nationale et un allègement des sanctions, pourrait ouvrir la voie à une paix durable.</p>',
 'Origines, dynamiques et perspectives du conflit iranien : une analyse géopolitique complète de la crise.',
 '2026-03-22', 'PUBLIE', 'Thomas Leroy')
ON CONFLICT (id) DO NOTHING;

-- Images
INSERT INTO images (url_path, alt_text, article_id)
SELECT '/assets/images/operation-militaire.webp',  'Opérations militaires en Iran',                    id FROM articles WHERE slug = 'bilan-48h-point-complet-conflit'
UNION ALL
SELECT '/assets/images/marche-financiere.webp',    'Marché financier et économie iranienne',            id FROM articles WHERE slug = 'economie-iranienne-impact-sanctions'
UNION ALL
SELECT '/assets/images/diplomatie.webp',           'Négociations diplomatiques à Vienne',               id FROM articles WHERE slug = 'diplomatie-negociations-nucleaire-iranien'
UNION ALL
SELECT '/assets/images/geopolitique.webp',         'Carte géopolitique du Moyen-Orient',                id FROM articles WHERE slug = 'geopolitique-alliances-regionales-conflit-iranien'
UNION ALL
SELECT '/assets/images/humanitaire.webp',          'Déplacés et aide humanitaire en Iran',              id FROM articles WHERE slug = 'crise-humanitaire-deplaces-internes-iran'
UNION ALL
SELECT '/assets/images/absolutvision-WYd_PkCa1BY-unsplash.webp', 'Analyse stratégique du conflit',     id FROM articles WHERE slug = 'analyse-conflit-iranien-remodele-moyen-orient'
UNION ALL
SELECT '/assets/images/operation-militaire.webp',  'Offensives militaires dans le nord-ouest iranien',  id FROM articles WHERE slug = 'offensives-militaires-nord-ouest-bilan-strategique'
UNION ALL
SELECT '/assets/images/geopolitique.webp',         'Tensions géopolitiques et origines du conflit',     id FROM articles WHERE slug = 'guerre-iran-analyse-tensions-geopolitiques-origines'
;
