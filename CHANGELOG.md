# Journal des modifications

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier sert au dépôt et à rédiger les notes de version Steam ; RimWorld ne l'affiche pas en jeu.

## [1.0.0] — non publié

Première version. RimWorld 1.6. Aucun code, aucune def, aucun fichier d'autrui : uniquement des
patchs xpath.

### Surfaces — 330 objets confiés à Knick Knacks

Quinze mods sources. Les objets reçoivent `SEX_Clutter` plus `SEX_BedroomClutter` ou
`SEX_DiningRoomClutter` selon la pièce. Un colon en récréation va les chercher et les pose.

Trois conditions structurelles décident de l'éligibilité : empreinte 1x1,
`altitudeLayer BuildingOnTop`, `isEdifice false`. Vingt et un objets posés en
`BuildingBelowTop` ou en couche `Item` sont convertis par conditionnel.

### Murs — 18 objets confiés à Colonists' Deco

Trois mods sources. Contrat plus lourd : `thingClass`, `CompProperties_Decoration` et
`modExtensions`, dont deux référencent l'assembly du mod. Tout est sous
`PatchOperationFindMod`, avec **un garde par def** et non un pour tout le fichier — une
`PatchOperationSequence` s'arrête à la première opération qui échoue.

### Masquage de l'Architecte

Diner Supplies et Office Supplies sont les deux seules sources couvertes à 100 %. Leurs entrées
sont retirées de l'onglet Mobilier vanilla : une opération par mod, la catégorie étant portée par
leur unique base abstraite. Non généralisable — ailleurs la couverture est partielle et masquer
reviendrait à supprimer.

### Ce qui a été délibérément écarté

Le tri sémantique a coupé bien plus que le tri structurel. Les 204 décalcomanies d'Outer Rim et
les 43 logos de Miniature Props sont en couche sol ; les quatorze « conformes » de Gerrymon's
Graveyard sont des pierres tombales ; l'art de Marketable Craftsmanship est crafté et le donner
gratuitement casserait l'économie ; `ucp_wallswitch` est un `Building_PowerSwitch` et
`LSK_RB_Laptop` un `Building_WorkTable`. Le détail est en tête de chaque fichier de patch.
