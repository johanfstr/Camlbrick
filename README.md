```
_____________________________________________________________________
_|_____|____|____|___|____|____|____|___|____|____|_____|__|______|__
___|____|____|__|_______|_____|____|___|______|_____|__|____|___|____
\_   ___ \____|__|____|_____|  |__\  |______|__|__|__|___|____|  |___
/    \__\/_\__  \___/     \_|  |___| __ \_\    _ \|  |_/ ___\_|  |/_/
\     \_____/ __ \_|  |_|  \|  |___| \_\ \_|  |_\/|  |\  \____|    \_
_\______  /(____  /|__|_|  /|____/_|___  /_|__|___|__|_\___  /|__|__\
_____|__\/___|__\/_______\/___|________\/___|______|_______\/______\/
__|_____|______|______|___|____|____|________|______|____|_____|___|_
```                                                                                                
## Introduction

**Camlbrick** est un jeu de casse-briques développé en **OCaml**, avec une interface graphique basée sur **Labltk**.  

Le principe du jeu est classique :

- Faire disparaître toutes les briques d’un niveau avec une balle
- Contrôler une raquette pour renvoyer la balle
- Gérer plusieurs types de briques : simple, double, bloc, bonus
- Les collisions sont gérées avec la raquette, les murs et les coins de briques

## Motivations

Ce projet a été réalisé dans le cadre d'un enseignement à l'Université de Poitiers.  

L'objectif était de manipuler :

- Les types et structures de données en OCaml (enregistrements, tableaux, listes)
- Les fonctions de manipulation de vecteurs et calculs physiques simples
- La programmation événementielle avec Labltk (souris, clavier, animation)
- La gestion des collisions et de la logique de jeu
- La conception modulaire entre moteur de jeu et interface graphique

## Prérequis

- OCaml ≥ 4.14  
- OPAM  
- Labltk

Installer les bibliothèques nécessaires :

```bash
opam install labltk
```
(sur Linux tk-dev est nécessaire) :
```bash
sudo apt install tk-dev
```

## Compilation et exécution

Après avoir installé labltk, vous pouvez compiler et executer le programme :
```bash
ocamlfind ocamlc -package labltk -linkpkg camlbrick.ml camlbrick_gui.ml camlbrick_launcher.ml -o camlbrick
./camlbrick
```

## ✍️ Auteurs

- Johan Forestier
- Enzo Aurousseau
- Auderick Guthoerl
- Mathéo Ardouin
