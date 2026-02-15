(**
Ce module Camlbrick représente le noyau fonctionnel du jeu de casse-brique nommé <b>camlbrick</b>
(un jeu de mot entre le jeu casse-brique et le mot ocaml).


Le noyau fonctionnel consiste à réaliser l'ensemble des structures et autres fonctions capables
d'être utilisées par une interface graphique. Par conséquent, dans ce module il n'y a aucun
aspect visuel! Vous pouvez utiliser le mode console.


Le principe du jeu de casse-brique consiste à faire disparaître toutes les briques d'un niveau
en utilisant les rebonds d'une balle depuis une raquette contrôlée par l'utilisateur.


@author Johan Forestier
@author Enzo Aurousseau
@author Auderick Guthoerl
@author Mathéo Ardouin


@version 1
*)


(** Compteur utilisé en interne pour afficher le numéro de la frame du jeu vidéo.
    Vous pouvez utiliser cette variable en lecture, mais nous ne devez pas modifier
    sa valeur! *)
let frames = ref 0;;


(**
  type énuméré représentant les couleurs gérables par notre moteur de jeu. Vous ne pouvez pas modifier ce type!
  @deprecated Ne pas modifier ce type!
*)
type t_camlbrick_color = WHITE | BLACK | GRAY | LIGHTGRAY | DARKGRAY | BLUE | RED | GREEN | YELLOW | CYAN | MAGENTA | ORANGE | LIME | PURPLE;;


(**
  Cette structure regroupe tous les attributs globaux,
  pour paramétrer notre jeu vidéo.
  <b>Attention:</b> Il doit y avoir des cohérences entre les différents paramètres:
  <ul>
  <li> la hauteur totale de la fenêtre est égale à la somme des hauteurs de la zone de briques du monde et
  de la hauteur de la zone libre.</li>
  <li>la hauteur de la zone des briques du monde est un multiple de la hauteur d'une seule brique. </li>
  <li>la largeur du monde est un multiple de la largeur d'une seule brique. </li>
  <li>initialement la largeur de la raquette doit correspondre à la taille moyenne.</li>
  <li>la hauteur initiale de la raquette doit être raisonnable et ne pas toucher un bord de la fenêtre.</li>
  <li>La variable <u>time_speed</u> doit être strictement positive. Et représente l'écoulement du temps.</li>
  </ul>
*)
type t_camlbrick_param = {
  world_width : int; (** largeur de la zone de dessin des briques *)
  world_bricks_height : int; (** hauteur de la zone de dessin des briques *)
  world_empty_height : int; (** hauteur de la zone vide pour que la bille puisse évoluer un petit peu *)


  brick_width : int; (** largeur d'une brique *)
  brick_height : int; (** hauteur d'une brique *)


  paddle_init_width : int; (** largeur initiale de la raquette *)
  paddle_init_height : int; (** hauteur initiale de la raquette *)


  time_speed : int ref; (** indique l'écoulement du temps en millisecondes (c'est une durée approximative) *)
};;


(** Enumeration des différents types de briques.
  Vous ne devez pas modifier ce type.    
*)
type t_brick_kind = BK_empty | BK_simple | BK_double | BK_block | BK_bonus;;


(**
  Cette fonction renvoie le type de brique pour représenter les briques de vide.
  C'est à dire, l'information qui encode l'absence de brique à un emplacement sur la grille du monde.
  @return Renvoie le type correspondant à la notion de vide.
  @deprecated  Cette fonction est utilisé en interne.    
*)
let make_empty_brick() : t_brick_kind =
  BK_empty
;;


(**
    Enumeration des différentes tailles des billes.
    La taille  normale d'une bille est [BS_MEDIUM].
 
    Vous pouvez ajouter d'autres valeurs sans modifier les valeurs existantes.
*)
type t_ball_size = BS_SMALL | BS_MEDIUM | BS_BIG;;


(**
Enumeration des différentes taille de la raquette. Par défaut, une raquette doit avoir la taille
[PS_SMALL].


  Vous pouvez ajouter d'autres valeurs sans modifier les valeurs existantes.
*)
type t_paddle_size = PS_SMALL | PS_MEDIUM | PS_BIG;;


(**
  Enumération des différents états du jeu. Nous avons les trois états de base:
    <ul>
    <li>[GAMEOVER]: qui indique si une partie est finie typiquement lors du lancement du jeu</li>
    <li>[PLAYING]: qui indique qu'une partie est en cours d'exécution</li>
    <li>[PAUSING]: indique qu'une partie en cours d'exécution est actuellement en pause</li>
    </ul>
   
    Dans le cadre des extensions, vous pouvez modifier ce type pour adopter d'autres états du jeu selon
    votre besoin.
*)
type t_gamestate = GAMEOVER | PLAYING | PAUSING;;


(** Itération 1
  @author Mathéo Ardouin
*)
type t_vec2 =
  {mutable x : int; mutable y : int}
;;


(**
  Cette fonction permet de créer un vecteur 2D à partir de deux entiers.
  Les entiers représentent la composante en X et en Y du vecteur.


  Vous devez modifier cette fonction.
  @author Mathéo Ardouin
  @param x première composante du vecteur
  @param y seconde composante du vecteur
  @return Renvoie le vecteur dont les composantes sont (x,y).
 
*)
let make_vec2(x,y : int * int) : t_vec2 =
  (
    {x = x ; y = y}
  )
;;


(**
  Cette fonction renvoie un vecteur qui est la somme des deux vecteurs donnés en arguments.
  @author Auderick Guthoerl
  @param a premier vecteur
  @param b second vecteur
  @return Renvoie un vecteur égale à la somme des vecteurs.
 
*)
let vec2_add(a,b : t_vec2 * t_vec2) : t_vec2 =
  (
    {x = a.x + b.x; y = a.y + b.y}
  )
;;


(**
  Cette fonction renvoie un vecteur égale à la somme d'un vecteur
  donné en argument et un autre vecteur construit à partir de (x,y).
 
  Cette fonction est une optimisation du code suivant (que vous ne devez pas faire en l'état):
  {[
let vec2_add_scalar(a,x,y : t_vec2 * int * int) : t_vec2 =
  vec2_add(a, make_vec2(x,y))
;;
  ]}


  @param a premier vecteur
  @param x composante en x du second vecteur
  @param y composante en y du second vecteur
  @return Renvoie un vecteur qui est la résultante du vecteur
*)
let vec2_add_scalar(a,x,y : t_vec2 * int * int) : t_vec2 =
  (
    {x = a.x + x; y = a.y + y }
  )
;;


(**
  Cette fonction calcul un vecteur où
  ses composantes sont la résultante de la multiplication  des composantes de deux vecteurs en entrée.
  Ainsi,
    {[
    c_x = a_x * b_x
    c_y = a_y * b_y
    ]}
  @param a premier vecteur
  @param b second vecteur
  @return Renvoie un vecteur qui résulte de la multiplication des composantes.
*)
let vec2_mult(a,b : t_vec2 * t_vec2) : t_vec2 =
  (* Itération 1 *)
  (
    {x = a.x * b.x; y = a.y * b.y }
  )
;;


(**
  Cette fonction calcul la multiplication des composantes du vecteur a et du vecteur construit à partir de (x,y).
  Cette fonction est une optimisation du code suivant (que vous ne devez pas faire en l'état):
  {[
let vec2_mult_scalar(a,x,y : t_vec2 * int * int) : t_vec2 =
  vec2_mult(a, make_vec2(x,y))
;;
  ]}
   
*)
let vec2_mult_scalar(a,x,y : t_vec2 * int * int) : t_vec2 =
  (* Itération 1 *)
  (
    {x = a.x * x; y = a.y * y }
  )
;;


(** Itération 2
  @author Ardouin Matheo    
*)
type t_ball = {
  mutable pos_x : int;
  mutable pos_y : int ;
  diam : int;
  mutable speed : t_vec2;
  color : t_camlbrick_color;
  }
;;


(** Itération 2
  @author Ardouin Matheo
*)
type t_paddle = {
  width : int;
  height : int;
  pos_x :  int ref;
  pos_y : int;
  color : string;
  }
;;


(** Itération 1, 2, 3 et 4
   @author Mathéo Ardouin
*)
type t_camlbrick =
 {
  solid : t_brick_kind array array;
  param : t_camlbrick_param;
  color : t_camlbrick_color array;
  paddle : t_paddle;
  mutable ball : t_ball list;
  ball_number : int ref;
  }
;;


(**
  Cette fonction construit le paramétrage du jeu, avec des informations personnalisable avec les contraintes du sujet.
  Il n'y a aucune vérification et vous devez vous assurer que les valeurs données en argument soient cohérentes.
  @return Renvoie un paramétrage de jeu par défaut      
*)
let make_camlbrick_param() : t_camlbrick_param = {
   world_width = 800;
   world_bricks_height = 600;
   world_empty_height = 200;


   brick_width = 40;
   brick_height = 20;


   paddle_init_width = 100;
   paddle_init_height = 20;


   time_speed = ref 20;
}
;;


(**
  Cette fonction extrait le paramétrage d'un jeu à partir du jeu donné en argument.
  @author Ardouin Matheo
  @param game jeu en cours d'exécution.
  @return Renvoie le paramétrage actuel.
  *)
let param_get (game : t_camlbrick) : t_camlbrick_param =
  {
    world_width = game.param.world_width;
    world_bricks_height = game.param.world_bricks_height;
    world_empty_height = game.param.world_empty_height;
 
    brick_width = game.param.brick_width;
    brick_height = game.param.brick_height;
 
    paddle_init_width = game.param.paddle_init_width;
    paddle_init_height = game.param.paddle_init_height;
 
    time_speed = game.param.time_speed;
  }
;;


(**
  @author Ardouin Matheo
  Cette fonction crée une raquette par défaut au milieu de l'écran et de taille normal.  
*)
let make_paddle() : t_paddle =
  (* Itération 2 *)
 (
  {
    width = 30;
    height = 10;
    pos_x = ref 385 ;
    pos_y = 100;
    color = "red";
  }
 )
;;


(**
  @author Ardouin Matheo
  Cette fonction crée une balle par défaut au milieu de l'écran et de taille normal.  
  @param x représente les coordonnées de la bamlle
  @param y représente les coordonnées de la balle
  @param size représente le diamétre de la balle
  @return Renvoie le type de brique à partir des coordonnées dans la zone de briques
*)
let make_ball(x,y, size : int * int * int) : t_ball =
  (* Itération 3 *)
  {
    pos_x = x;
    pos_y = y;
    diam = size;
    speed = {x = 1; y = 2};
    color = WHITE;
  }
;;


let set_brick() : t_brick_kind =
 let random_brick_type = Random.int 5 in
 if random_brick_type = 0 then
     BK_empty
   else if random_brick_type = 1 then
     BK_simple
   else if random_brick_type = 2 then
     BK_double
   else if random_brick_type = 3 then
     BK_block
   else
   BK_bonus
;;


(**
  Cette fonction crée une nouvelle structure qui initialise le monde avec aucune brique visible.
  Une raquette par défaut et une balle par défaut dans la zone libre.
  @return Renvoie un jeu correctement initialisé
  @author Ardouin Matheo
*)
let make_camlbrick() : t_camlbrick =
  let param = make_camlbrick_param() in
  let paddle = make_paddle() in
  let brick_cols = param.world_width / param.brick_width in
  let brick_rows = param.world_bricks_height / param.brick_height in
  let bricks = Array.make_matrix brick_rows brick_cols (set_brick()) in
  let color = Array.make 5 ORANGE in
  let ball = [make_ball(400, 650, 10)] in
  let ball_number = ref 0 in

  {solid = bricks; param = param; color = color; paddle = paddle; ball = ball; ball_number = ball_number}
;;


(**
  Fonction utilitaire qui permet de traduire l'état du jeu sous la forme d'une chaîne de caractère.
  Cette fonction est appelée à chaque frame, et est affichée directement dans l'interface graphique.
 
  Vous devez modifier cette fonction.

  @param game représente le jeu en cours d'exécution.
  @return Renvoie la chaîne de caractère représentant l'état du jeu.
*)
let string_of_gamestate(game : t_camlbrick) : string =
  (* Itération 1,2,3 et 4 *)
  "INCONNU"
;;


(**
  Cette fonction permet de connaître le type de brique à l'aide des coordonnées données du jeu.
  @author Johan Forestier
  @param game représente le jeu en cours d'exécution.
  @param i représente les coordonnées
  @param j représente les coordonnées
  @return Renvoie le type de brique à partir des coordonnées dans la zone de briques
*)
let brick_get(game, i, j : t_camlbrick * int * int)  : t_brick_kind =
  let bricks_rows = 20 in
  let bricks_cols = 30 in
  let empty_height = 0 (* hauteur à partir de laquelle les briques sont vides *) in

  if i >= 0 && i < bricks_rows && j >= 0 && j < bricks_cols then
    if i < (empty_height / game.param.brick_height) then
      BK_empty
    else
      BK_simple
  else
    BK_empty
;;


(**
  Cette fonction permet de modifier le type de brique, comme si elle était touchée par une balle à l'aide des coordonnées données du jeu.
  @author Johan Forestier
  @param game représente le jeu en cours d'exécution.
  @param i représente les coordonnées
  @param j représente les coordonnées
  @return Réalise les modifications dans la zone de brique pour faire évoluer une brique.
*)
let brick_hit(game, i, j : t_camlbrick * int * int)  : t_brick_kind =
  if brick_get(game, i, j) = BK_double then
    BK_simple
  else
    BK_empty
;;


(**
@author Enzo Aurousseau
@param game représente le jeu et ces paramètres
@param i représente les coordonnées
@param j représente les coordonnées
@return renvoie une couleur en fonction du type de brique
*)
let brick_color(game, i, j : t_camlbrick * int * int) : t_camlbrick_color =
 let brick_kind = set_brick() in
   if brick_kind = BK_empty
   then BLACK
   else
     if brick_kind = BK_simple
     then ORANGE
     else
       if brick_kind = BK_double
       then YELLOW
       else
         if brick_kind = BK_block
         then BLUE
         else (* brick_kind = BK_bonus *)GREEN
;;


(**
Cette foncion permet de recuperer la position du paddle
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return renvoie la position du paddle
*)
let paddle_x(game : t_camlbrick) : int=
  (* Itération 2 *)
  !(game.paddle.pos_x )
;;


(**
  Cette fonction permet de recuperer la largeur du paddle
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return int : revoie la taille du paddle 
*)
let paddle_size_pixel(game : t_camlbrick) : int =
  (* Itération 2 *)
  game.paddle.width
;;


(**
  La fonction met à jour la position de la raquette vers la gauche de 10 unités si la position actuelle le permet.
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return unit 
*)
let paddle_move_left(game : t_camlbrick) : unit =
  (* Itération 2 *)
  (      
    if !(game.paddle.pos_x) > 40
      then
        game.paddle.pos_x := !(game.paddle.pos_x)- 10
  )
;;


(** Itération 2
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return unit
*)
let paddle_move_right(game : t_camlbrick) : unit =
  (
    if !(game.paddle.pos_x) < 730
      then
        game.paddle.pos_x := !(game.paddle.pos_x) + 10
  )
;;


(** Itération 2
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return bool : nous dis si il y a une balle en jeu
*)
let has_ball(game : t_camlbrick) : bool =
  if !(game.ball_number) = 0
    then
      false
    else
      true
;;


(** Itération 2
    @author Ardouin Matheo
    @param game représente le jeu en cours d'exécution.
    @return int : nombre de ball en jeu
*)
let balls_count(game : t_camlbrick) : int =
  !(game.ball_number)
;;


(** Itération 2
    @author Forestier Johan
    @param game représente le jeu et ces paramètres
    @return retourne la i ème balle d'une partie
*)
let balls_get(game : t_camlbrick) : t_ball list =
    game.ball
;;


(** Itération 2
   @author Forestier Johan
   @param game représente le jeu et ces paramètres
   @return retourne la i ème balle d'une partie
*)
let ball_get(game, i : t_camlbrick * int) : t_ball =
  List.nth game.ball i
;;


(** Itération 2
   @author Aurousseau Enzo
   @param game représente le jeu et ces paramètres
   @param ball représente les paramètres de la balle
   @return retourne la position x de la balle
*)
let ball_x(game,ball : t_camlbrick * t_ball) : int =
  ball.pos_x
;;


(** Itération 2
   @author Aurousseau Enzo
   @param game représente le jeu et ses paramètres
   @param ball représente les paramètres de la balle
   @return int : retourne la position y de la balle
*)
let ball_y(game, ball : t_camlbrick * t_ball) : int =
  ball.pos_y
;;


(** Itération 2
   @author Aurousseau Enzo
   @param game représente le jeu et ses paramètres
   @param ball représente les paramètres de la balle
   @return int : retourne la taille de la balle
*)
let ball_size_pixel(game, ball : t_camlbrick * t_ball) : int =
  ball.diam
;;


(** Itération 2
   @author Aurousseau Enzo
   @param game représente le jeu et ses paramètres
   @param ball représente les paramètres de la balle
   @return int : retourne la couleur de la balle
*)
let ball_color(game, ball : t_camlbrick * t_ball) : t_camlbrick_color =
  ball.color
;;


(** Itération 3
  Cette fonction modifie la vitesse d'une balle
   @author Forestier Johan
   @param game représente le jeu et ses paramètres
   @param ball représente les paramètres de la balle
   @param dv thyhty
   @return unit 
*)
let ball_modif_speed(game, ball, dv : t_camlbrick * t_ball * t_vec2) : unit =
  ball.speed <- vec2_add(ball.speed, dv)
;;


(** Itération 3
  Cette fonctioin modifie le signe de la vitesse d'une balle
   @author Forestier Johan
   @param game représente le jeu et ses paramètres
   @param ball représente les paramètres de la balle
   @param sv tyhty
   @return unit
*)
let ball_modif_speed_sign(game, ball, sv : t_camlbrick * t_ball * t_vec2) : unit =
  ball.speed <- vec2_mult(ball.speed, sv)
;;


(** Itération 3
  @param cx  la coordonnée x du centre du cercle
   @param cy  la coordonnée y du centre du cercle
   @param rad  le rayon du cercle
   @param x  la coordonnée x du point à vérifier
   @param y  la coordonnée y du point à vérifier
   @return bool :vrai si un point (x,y) se trouve à l'intérieur d'un disque de centre (cx,cy)
*)
let is_inside_circle(cx,cy,rad, x, y : int * int * int * int * int) : bool =
  let distance_squared = (x - cx) * (x - cx) + (y - cy) * (y - cy) in
  let radius_squared = rad * rad in
  distance_squared <= radius_squared
;;


(** Itération 3
   @author Forestier Johan
   @param x1  la coordonnée x du premier coin du rectangle
   @param y1  la coordonnée y du premier coin du rectangle
   @param x2  la coordonnée x du deuxième coin du rectangle
   @param y2  la coordonnée y du deuxième coin du rectangle
   @param x  la coordonnée x du point à vérifier
   @param y  la coordonnée y du point à vérifier
   @return vrai si un point (x,y) se trouve à l'intérieur d'un rectangle formé
*)
let min (x, y : int * int) : int =
  if x < y then x else y
;;
let max (x, y : int * int) : int =
  if x > y then x else y
;;
let is_inside_quad(x1,y1,x2,y2, x,y : int * int * int * int * int * int) : bool =
  x >= min(x1, x2) && x <= max(x1, x2) && y >= min(y1, y2) && y <= max(y1, y2)
;;


(** Itération 3
  Supprime les balles hors du terrain de jeu
    @author Forestier Johan
    @param game représente le jeu et ses paramètres
    @param balls représente les paramètres de la balle
    @return renvoie une nouvelle liste sans les mauvaises balles
*)
let ball_remove_out_of_border(game, balls : t_camlbrick * t_ball list ) : t_ball list =
  let valid_balls = ref [] in
  let n = List.length balls in
  for i = 0 to n - 1 do
    let ball = ball_get(game, i) in
    let ball_center_x = ball_x(game, ball) + ball_size_pixel(game, ball) / 2 in
    let ball_center_y = ball_y(game, ball) + ball_size_pixel(game, ball) / 2 in
    if is_inside_circle (0, 0, 800, ball_center_x, ball_center_y)
      && is_inside_quad (0, 0, 800, 600, ball_center_x, ball_center_y)
    then
      valid_balls := ball :: !valid_balls
  done;
  game.ball <- !valid_balls;
  !valid_balls
;;


(** Itération 3
  verifie si la balle entre en collision avec le paddle, ajuste la vitesse de la balle en conséquence
    @author Forestier Johan
    @param game représente le jeu et ses paramètres
    @param ball représente les paramètres de la balle
    @param paddle représente les paramètres du paddle
    @return unit
*)
let ball_hit_paddle(game,ball,paddle : t_camlbrick * t_ball * t_paddle) : unit =
  let ball_radius = ball.diam / 2 in
  let paddle_width = paddle.width in
  let paddle_pos_x = !(paddle.pos_x) in
  let paddle_pos_y = paddle.pos_y in
  let ball_center_x = ball.pos_x + ball_radius in


  (* Vérifier si la balle entre en collision avec la raquette *)
  let paddle_collision =
    ball_center_x >= paddle_pos_x && ball_center_x <= paddle_pos_x + paddle_width &&
    ball.pos_y + ball.diam >= 770
  in


  (* Si la collision est détectée, ajuster la vitesse de la balle *)
  if paddle_collision then
    let paddle_segment_width = paddle_width / 5 in
    let collision_position = ball_center_x - paddle_pos_x in
    let segment_number = collision_position / paddle_segment_width in
    let segment_center_x = paddle_pos_x + (segment_number * paddle_segment_width) + (paddle_segment_width / 2) in


    (* Modifier la vitesse de la balle en fonction du segment touché *)
    let diff = ball_center_x - segment_center_x in
    let max_speed_change = 5 in
    let speed_change = (diff * max_speed_change) / (paddle_segment_width / 2) in
    ball.speed <- { x = ball.speed.x + speed_change; y = -ball.speed.y }
  else
    ()
;;


(** Itération 3
  Fonction qui verifie si une balle touche le coin d'une brick
    @author Forestier Johan
    @param game représente le jeu et ses paramètres
    @param ball représente les paramètres de la balle
    @param i représente les coordonnées de la balle en x
    @param j représente les coordonnées de la balle en y
    @return un booleen qui nous informe si la balle a touhé ou non un coin de briques
*)
let ball_hit_corner_brick(game,ball, i,j : t_camlbrick * t_ball * int * int) : bool =
  let brick_width = game.param.brick_width in
  let brick_height = game.param.brick_height in
  let brick_pos_x = (j - 1) * brick_width in
  let brick_pos_y = (i - 1) * brick_height in


  let ball_pos_x = ball.pos_x in
  let ball_pos_y = ball.pos_y in
  let ball_radius = ball.diam / 2 in


  let corners = [
    (brick_pos_x, brick_pos_y);
    (brick_pos_x + brick_width, brick_pos_y);
    (brick_pos_x, brick_pos_y + brick_height);
    (brick_pos_x + brick_width, brick_pos_y + brick_height)
  ] in


  let num_corners = List.length corners in
  let collision = ref false in


  for k = 0 to num_corners - 1 do
    let corner_x, corner_y = List.nth corners k in
    let distance_squared = (ball_pos_x - corner_x) * (ball_pos_x - corner_x) + (ball_pos_y - corner_y) * (ball_pos_y - corner_y) in
    let radius_squared = ball_radius * ball_radius in
    if distance_squared <= radius_squared then
      collision := true
  done;


  !collision
;;


(** Itération 3
    @author Forestier Johan
    @param game représente le jeu et ses paramètres
    @param game représente le jeu et ses paramètres
    @param ball représente les paramètres de la balle
    @param i entier, coordonnée i de la brique
    @param j entier, coordonnée j de la brique
    @return vrai si la balle entre en collision avec un côté de la brique spécifiée
*)
let ball_hit_side_brick(game, ball, i, j : t_camlbrick * t_ball * int * int) : bool =
  let brick_width = game.param.brick_width in
  let brick_height = game.param.brick_height in
  let brick_pos_x = j * brick_width in
  let brick_pos_y = i * brick_height in
  let ball_pos_x = ball_x (game, ball) in
  let ball_pos_y = ball_y (game, ball) in
  let ball_radius = ball_size_pixel (game, ball) / 2 in
  let sides = [
    (brick_pos_x, brick_pos_y + brick_height / 2); (* Left side *)
    (brick_pos_x + brick_width, brick_pos_y + brick_height / 2); (* Right side *)
    (brick_pos_x + brick_width / 2, brick_pos_y); (* Top side *)
    (brick_pos_x + brick_width / 2, brick_pos_y + brick_height) (* Bottom side *)
  ] in
  let num_sides = List.length sides in
  let collision = ref false in
  for k = 0 to num_sides - 1 do
    let side_x, side_y = List.nth sides k in
    let distance_squared = (ball_pos_x - side_x) * (ball_pos_x - side_x) + (ball_pos_y - side_y) * (ball_pos_y - side_y) in
    let radius_squared = ball_radius * ball_radius in
    if distance_squared <= radius_squared then
      collision := true
  done;
  !collision
;;


(** Itération 3
    @author Forestier Johan
    @param game représente le jeu et ses paramètres
    @param balls liste des balles
    @return unit
*)
let game_test_hit_balls (game, balls : t_camlbrick * t_ball list) : unit =
  let valid_balls = ref [] in
  let num_balls = List.length balls in
  for i = 0 to num_balls - 1 do
    let ball = List.nth balls i in
    let ball_center_x = ball.pos_x + ball.diam / 2 in
    let ball_center_y = ball.pos_y + ball.diam / 2 in
    let within_x = ball_center_x >= 0 && ball_center_x <= game.param.world_width in
    let within_y = ball_center_y >= 0 && ball_center_y <= game.param.world_bricks_height + game.param.world_empty_height in
    if within_x && within_y then (
      ball_hit_paddle(game, ball, game.paddle);  (* Vérifier la collision avec la raquette *)
      (* Vérifier la collision avec les briques *)
      let brick_is_hit = ref false in
      let ball_grid_x = ball_center_x / game.param.brick_width in
      let ball_grid_y = ball_center_y / game.param.brick_height in
      if ball_grid_x >= 0 && ball_grid_x < Array.length game.solid && ball_grid_y >= 0 && ball_grid_y < Array.length game.solid.(0) then (
        if ball_hit_side_brick (game, ball, ball_grid_x, ball_grid_y) || ball_hit_corner_brick (game, ball, ball_grid_x, ball_grid_y) then (
          brick_is_hit := true;
          game.solid.(ball_grid_x).(ball_grid_y) <- brick_hit(game, ball_grid_x, ball_grid_y);
        )
      );
      valid_balls := ball :: !valid_balls
    )
  done;
  game.ball <- !valid_balls;
;;


(**
  Cette fonction est appelée par l'interface graphique avec le jeu en argument et la position
  de la souris dans la fenêtre lorsqu'elle se déplace.
  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @author Forestier Johan
  @param game la partie en cours.
  @param x l'abscisse de la position de la souris
  @param y l'ordonnée de la position de la souris    
*)
let canvas_mouse_move(game,x,y : t_camlbrick * int * int) : unit =
  let paddle_width = game.paddle.width in
  let new_paddle_x = if x < paddle_width / 2 then 0
  else if x > game.param.world_width - (paddle_width / 2) then game.param.world_width - paddle_width
  else x - (paddle_width / 2) in
  game.paddle.pos_x := new_paddle_x
;;


(**
  Cette fonction est appelée par l'interface graphique avec le jeu en argument et la position
  de la souris dans la fenêtre lorsqu'un bouton est enfoncé.
  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
  @param button numero du bouton de la souris enfoncé.
  @param x l'abscisse de la position de la souris
  @param y l'ordonnée de la position de la souris    
*)
let canvas_mouse_click_press(game,button,x,y : t_camlbrick * int * int * int) : unit =
  ()
;;


(**
  Cette fonction est appelée par l'interface graphique avec le jeu en argument et la position
  de la souris dans la fenêtre lorsqu'un bouton est relaché.
  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
  @param button numero du bouton de la souris relaché.
  @param x l'abscisse de la position du relachement
  @param y l'ordonnée de la position du relachement  
*)
let canvas_mouse_click_release(game,button,x,y : t_camlbrick * int * int * int) : unit =
  ()
;;


(**
  Cette fonction est appelée par l'interface graphique lorsqu'une touche du clavier est appuyée.
  Les arguments sont le jeu en cours, la touche enfoncé sous la forme d'une chaine et sous forme d'un code
  spécifique à labltk.
 
  Le code fourni initialement permet juste d'afficher les touches appuyées au clavier afin de pouvoir
  les identifiées facilement dans nos traitements.

  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
  @param keyString nom de la touche appuyée.
  @param keyCode code entier de la touche appuyée.  
*)
let canvas_keypressed(game, keyString, keyCode : t_camlbrick * string * int) : unit =
  print_string("Key pressed: ");
  print_string(keyString);
  print_string(" code=");
  print_int(keyCode);
  print_newline();
  print_int( !(game.paddle.pos_x));
  if keyCode = 65361 then
    paddle_move_left (game)
  else
    if keyCode = 65363 then
      paddle_move_right (game)
;;


(**
  Cette fonction est appelée par l'interface graphique lorsqu'une touche du clavier est relachée.
  Les arguments sont le jeu en cours, la touche relachée sous la forme d'une chaine et sous forme d'un code
  spécifique à labltk.
 
  Le code fourni initialement permet juste d'afficher les touches appuyées au clavier afin de pouvoir
  les identifiées facilement dans nos traitements.

  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
  @param keyString nom de la touche relachée.
  @param keyCode code entier de la touche relachée.  
*)
let canvas_keyreleased(game, keyString, keyCode : t_camlbrick * string * int) =
  print_string("Key released: ");
  print_string(keyString);
  print_string(" code=");
  print_int(keyCode);
  print_newline()
;;


(**
  Cette fonction est utilisée par l'interface graphique pour connaitre l'information
  l'information à afficher dans la zone Custom1 de la zone du menu.
*)
let custom1_text() : string =
  (* Iteration 4 *)
  "<Rien1>"
;;


(**
  Cette fonction est utilisée par l'interface graphique pour connaitre l'information
  l'information à afficher dans la zone Custom2 de la zone du menu.
*)
let custom2_text() : string =
  (* Iteration 4 *)
  "<Rien2>"
;;


(**
  Cette fonction est appelée par l'interface graphique lorsqu'on clique sur le bouton
  de la zone de menu et que ce bouton affiche "Start".
 
  Vous pouvez réaliser des traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
*)
let start_onclick(game : t_camlbrick) : unit=
  ()
;;


(**traitements spécifiques, mais comprenez bien que cela aura
  un impact sur les performances si vous dosez mal les temps de calcul.
  @param game la partie en cours.
*)
let stop_onclick(game : t_camlbrick) : unit =
  ()
;;


(**
  Cette fonction est appelée par l'interface graphique pour connaitre la valeur
  du slider Speed dans la zone du menu.

  Vous pouvez donc renvoyer une valeur selon votre désir afin d'offrir la possibilité
  d'interagir avec le joueur.
*)
let speed_get(game : t_camlbrick) : int =
  0
;;


(**
  Cette fonction est appelée par l'interface graphique pour indiquer que le
  slide Speed dans la zone de menu a été modifiée.
 
  Ainsi, vous pourrez réagir selon le joueur.
*)
let speed_change(game,xspeed : t_camlbrick * int) : unit=
  print_endline("Change speed : "^(string_of_int xspeed));
;;


(** Iteration 1,2,3 et 4
    @author Forestier Johan
    Cette fonction est appelée par l'interface graphique à chaque frame
    du jeu vidéo.
    Vous devez mettre tout le code qui permet de montrer l'évolution du jeu vidéo. 
    @param game la partie en cours.
*)
let animate_action(game : t_camlbrick) : unit =
  let num_balls = List.length game.ball in
  for i = 0 to num_balls - 1 do
    let ball = List.nth game.ball i in
    let initial_pos_x = ball.pos_x in
    let initial_pos_y = ball.pos_y in
    ball.pos_x <- initial_pos_x + ball.speed.x;
    ball.pos_y <- initial_pos_y + ball.speed.y;
    game_test_hit_balls(game, [ball]);
    let new_pos_x = ball.pos_x in
    let new_pos_y = ball.pos_y in
    if ball.pos_x <> new_pos_x || ball.pos_y <> new_pos_y then (
      ball.pos_x <- initial_pos_x;
      ball.pos_y <- initial_pos_y;
    )
    else (
      if ball.pos_x < 0 || ball.pos_x + ball.diam > game.param.world_width && not (ball.pos_y + ball.diam >= game.param.world_bricks_height + game.param.world_empty_height) then
        ball.speed.x <- -ball.speed.x; (* Rebondir sur les bords horizontaux *)
      if ball.pos_y < 0 || ball.pos_y + ball.diam > game.param.world_bricks_height + game.param.world_empty_height && not (ball.pos_y + ball.diam >= game.param.world_bricks_height + game.param.world_empty_height) then
        ball.speed.y <- -ball.speed.y; (* Rebondir sur les bords verticaux *)
      if ball_hit_corner_brick(game, ball, ball.pos_x, ball.pos_y) || ball_hit_side_brick(game, ball, ball.pos_x, ball.pos_y) then
        ball.speed.y <- -ball.speed.y;
    )
  done
;;


