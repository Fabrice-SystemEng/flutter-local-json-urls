# Local JSON URL Hub (my_urls)

Une application Android épurée et légère développée avec Flutter, permettant de centraliser et d'accéder rapidement à vos liens personnels (outils IA, documentations, tableaux de bord, tutoriels) à partir d'un simple fichier de configuration local au format JSON.

L'interface se présente sous la forme d'un tableau minimaliste optimisé pour les écrans mobiles, masquant l'affichage des URLs brutes et rendant le nom du lien directement cliquable.

## Fonctionnalités
- **Lecture 100% Locale** : Aucun serveur ou base de données externe requis, l'application lit directement un fichier sur le stockage de votre téléphone.
- **Interface Épurée** : Tableau à 2 colonnes (*Nom* et *Infos*). Le nom est souligné en bleu et ouvre le navigateur par défaut lors du clic.
- **Mode Sombre** : Support natif du thème clair et du thème sombre d'Android.
- **Bouton Actualiser** : Permet de recharger instantanément la liste après avoir modifié le fichier JSON sans relancer l'application.

---

## Configuration du fichier `liens.json`

Pour alimenter l'application, vous devez créer un fichier nommé exactement `liens.json` et le placer sur la mémoire interne de votre téléphone Android.

### Structure attendue du JSON
Le fichier doit contenir un tableau d'objets (entre crochets `[...]`). Chaque objet représentant un lien doit posséder strictement trois clés : `"nom"`, `"url"`, et `"infos"`.

Voici un exemple type :

```json
[
  {
    "nom": "IA Chat Z ai",
    "url": "[https://chat.z.ai/](https://chat.z.ai/)",
    "infos": "IA"
  },
  {
    "nom": "Tuto AI Modal",
    "url": "[https://modal.com/docs/guides](https://modal.com/docs/guides)",
    "infos": "Documentation"
  },
  {
    "nom": "Bitdefender Central",
    "url": "[https://central.bitdefender.com/](https://central.bitdefender.com/)",
    "infos": "Sécurité"
  }
]
