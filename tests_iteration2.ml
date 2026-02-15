#use "CPtest.ml";;
#use "camlbrick.ml";;


(**
Cette fonction vérifie si les valeurs par défaut de la raquette sont les bonnes
@author Audérick Guthoerl    
*)
let test_fonc_make_paddle () : unit =
  let paddle : t_paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"} in
  let l_result : t_paddle t_test_result = test_exec(make_paddle , "rien en paramètre" , ())
  in
  (
    assert_equals_result_m("crée une raquette des tailles définies au préalable" , paddle , l_result)
  );
;;

(**
Cette fonction vérifie si le renvoie de la position x de la raquette fonctionne
@author Audérick Guthoerl    
*)
let test_fonc_paddle_x () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : int t_test_result = test_exec(paddle_x, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("renvoie la position x de la raquette" , 385 , l_result)
  );
;;

(**
Cette fonction vérifie si le renvoie de la taille (largeur) de la raquette fonctionne
@author Audérick Guthoerl    
*)
let test_fonc_paddle_size_pixel () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : int t_test_result = test_exec(paddle_size_pixel, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("renvoie la largeur de la raquette" , 30 , l_result)
  );
;;

(**
Cette fonction vérifie si le renvoie de la position x de la raquette a diminué de 10
@author Audérick Guthoerl    
*)
let test_fonc_paddle_move_left () : unit = 
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : int t_test_result = test_exec(paddle_move_left, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("diminution de pos_x de 10" , 375 , l_result)
  );
;;

(** 
Cette fonction vérifie si le renvoie de la position x de la raquette a augmenté de 10
@author Audérick Guthoerl    
*)
let test_fonc_paddle_move_right () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : int t_test_result = test_exec(paddle_move_right, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("augmentation de pos_x de 10" , 395 , l_result)
  );
;;



(**
Ces fonctions vérifient si il y a des balles dans le jeu
@author Audérick Guthoerl    
*)
let test_fonc_has_ball_1 () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 1} in
  let l_result : bool t_test_result = test_exec(has_ball, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("verification qu'il y a une balle" , true , l_result)
  );
;;

let test_fonc_has_ball_2 () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : bool t_test_result = test_exec(has_ball, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("verification qu'il y a une balle" , false , l_result)
  );
;;

let test_fonc_has_ball_3 () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : bool t_test_result = test_exec(has_ball, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("verification qu'il y a une balle" , false , l_result)
  );
;;



(**
Cette fonctions vérifie si le nombre de balle dans le jeu est le même que celui renvoyé
@author Audérick Guthoerl    
*)
let test_fonc_balls_count () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 1} in
  let l_result : int t_test_result = test_exec(balls_count, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("compte le nombre de balle" , 1 , l_result)
  );
;;

(**
Cette fonction vérifie si tous les paramètres de toutes les balles sont envoyées
@author Audérick Guthoerl    
*)
let test_fonc_balls_get () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10 ; speed = {x = 1; y = 2}; color = WHITE}; {pos_x = 200; pos_y = 360 ; diam = 15 ; speed = {x = 1; y = 2}; color = WHITE}];
  ball_number = ref 0} in
  let l_result : t_ball list t_test_result = test_exec(balls_get, "prend le jeu en paramètre" , (game))
  in
  (
    assert_equals_result_m("renvoie les balles et leurs informations" , [{pos_x = 385; pos_y = 110 ; diam = 10 ; speed = {x = 1; y = 2}; color = WHITE}; {pos_x = 200; pos_y = 360 ; diam = 15 ; speed = {x = 1; y = 2}; color = WHITE}] , l_result)
  );
;;

(**
Cette fonction vérifie si l'on peut récupérer les paramètres d'une balle spécifique
@author Audérick Guthoerl    
*)
let test_fonc_ball_get () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : t_ball t_test_result = test_exec(ball_get, "prend le jeu en paramètre et un nombre" , (game , 1))
  in
  (
    assert_equals_result_m("renvoie la balle et ses informations" , {pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;} , l_result)
  );
;;

(**
Cette fonction vérifie si l'on peut récupérer la coordonnée x d'une balle spécifique
@author Audérick Guthoerl    
*)
let test_fonc_ball_x () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 250; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE}];
  ball_number = ref 0} in
  let ball : t_ball = {pos_x = 250; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE} in
  let l_result : int t_test_result = test_exec(ball_x, "prend le jeu en paramètre et une balle" , (game , ball))
  in
  (
    assert_equals_result_m("renvoie la position x de la balle" , 250 , l_result)
  );
;;

(**
Cette fonction vérifie si l'on peut récupérer la coordonnée y d'une balle spécifique
@author Audérick Guthoerl    
*)
let test_fonc_ball_y () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let ball : t_ball = {pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;} in
  let l_result : int t_test_result = test_exec(ball_y, "prend le jeu en paramètre et une balle" , (game , ball))
  in
  (
    assert_equals_result_m("renvoie la position y de la balle" , 110 , l_result)
  );
;;

(**
Cette fonction vérifie si l'on peut récuperer le diamètre d'une balle spécifique
@author Audérick Guthoerl    
*)
let test_fonc_ball_size_pixel () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let ball : t_ball = {pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;} in
  let l_result : int t_test_result = test_exec(ball_size_pixel, "prend le jeu en paramètre et une balle" , (game , ball))
  in
  (
    assert_equals_result_m("renvoie la taille de la balle" , 10 , l_result)
  );
;;

(**
Cette fonction verifie si l'on peut recupérer la couleur de la balle
@author Audérick Guthoerl    
*)
let test_fonc_ball_color () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in 
  let ball : t_ball = {pos_x = 250; pos_y = 150 ; diam = 10 ; speed = {x = 1; y = 2}; color = GRAY} in
  let l_result : t_camlbrick_color t_test_result = test_exec(ball_size_pixel, "prend le jeu en paramètre et une balle" , (game , ball))
  in
  (
    assert_equals_result_m("renvoie la couleur" , GRAY , l_result)
  );
;;

test_fonc_make_paddle();;
test_fonc_paddle_x();;
test_fonc_paddle_size_pixel();;
test_fonc_paddle_move_left();;
test_fonc_paddle_move_right();;

test_fonc_has_ball_1();;
test_fonc_has_ball_2();;
test_fonc_has_ball_3();;
test_fonc_balls_count();;
test_fonc_balls_get();;
test_fonc_ball_get();;
test_fonc_ball_x();;
test_fonc_ball_y();;
test_fonc_ball_size_pixel();;
test_fonc_ball_color();;


test_report();;