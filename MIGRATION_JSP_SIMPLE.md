# Migration de Spring Boot vers Java JSP Simple

## Résumé des changements

Cette version transforme l'application Spring Boot en Java JSP pure et simple.

### ✅ Changements effectués :

#### 1. **Pom.xml**
- ✓ Suppression de Spring Boot
- ✓ Suppression de Spring Data JPA
- ✓ Ajout des dépendances minimales: Servlet API, JSP, JSTL, PostgreSQL Driver

#### 2. **Nouvelles classes créées**
- **`DatabaseConnection.java`** - Gestion des connexions JDBC
- **`ArticleDAO.java`** - Accès aux données pour les articles (CRUD en JDBC)
- **`UtilisateurDAO.java`** - Accès aux données pour les utilisateurs (CRUD en JDBC)
- **`LoginServlet.java`** - Gestion des routes `/login` et `/logout`
- **`ArticleServlet.java`** - Gestion des routes `/admin/articles/*`
- **`IndexServlet.java`** - Redirection de la racine `/`
- **`AuthFilter.java`** - Filtre d'authentification pour `/admin/*`

#### 3. **Modèles nettoyés**
- **`Article.java`** - Suppression des annotations JPA (@Entity, @Column, etc.)
- **`Utilisateur.java`** - Suppression des annotations JPA

#### 4. **Configuration**
- **`web.xml`** - Fichier de configuration de l'application web
- **`error.jsp`** - Page d'erreur

#### 5. **JSP mises à jour**
- Correction des taglibs (jakarta.tags.core au lieu de java.sun)
- Correction des URLs avec `${pageContext.request.contextPath}`

## Structure du projet

```
source/src/main/
├── java/com/rewriting/rewriting/
│   ├── db/
│   │   └── DatabaseConnection.java
│   ├── dao/
│   │   ├── ArticleDAO.java
│   │   └── UtilisateurDAO.java
│   ├── model/
│   │   ├── Article.java
│   │   └── Utilisateur.java
│   ├── servlet/
│   │   ├── IndexServlet.java
│   │   ├── LoginServlet.java
│   │   └── ArticleServlet.java
│   └── filter/
│       └── AuthFilter.java
└── webapp/
    ├── WEB-INF/
    │   ├── web.xml
    │   └── views/
    │       ├── login.jsp
    │       └── admin/
    │           ├── navbar.jsp
    │           ├── dashboard.jsp
    │           └── article/
    │               ├── list.jsp
    │               ├── form.jsp
    │               └── view.jsp
    └── error.jsp
```

## Installation et utilisation

### 1. Configurer la base de données

Modifier `DatabaseConnection.java`:
```java
private static final String URL = "jdbc:postgresql://localhost:5432/rewriting";
private static final String USER = "postgres";
private static final String PASSWORD = "postgres";
```

### 2. Compiler le projet

```bash
cd source
mvn clean package
```

### 3. Déployer sur Tomcat

```bash
cp target/rewriting.war $CATALINA_HOME/webapps/
```

## Routes disponibles

| Route | Méthode | Description |
|-------|---------|-------------|
| `/` | GET | Redirection vers `/admin/articles` ou `/login` |
| `/login` | GET, POST | Formulaire et traitement de connexion |
| `/logout` | GET | Déconnexion |
| `/admin/articles` | GET | Liste des articles (authentification requise) |
| `/admin/articles/add` | GET, POST | Formulaire d'ajout et création (authentification requise) |
| `/admin/articles/edit/{id}` | GET, POST | Formulaire d'édition (authentification requise) |
| `/admin/articles/delete/{id}` | GET | Suppression (authentification requise) |

## Avantages de cette approche

✅ **Pas de dépendances lourdes** - Juste les éléments essentiels
✅ **Contrôle complet du code** - Pas d'abstraction du framework
✅ **Performance** - Moins d'overhead d'un framework
✅ **Apprentissage** - Comprendre comment fonctionne réellement une app web Java

## Notes

- Les mots de passe ne sont **pas hashés** - À implémenter pour la production (BCrypt, Argon2, etc.)
- Les sessions sont gérées par le conteneur Tomcat
- JDBC raw - Considérez Hibernate/JPA pour plus de flexibilité
- Les fichiers de contrôleurs et services Spring sont maintenant inutilisés et peuvent être supprimés
