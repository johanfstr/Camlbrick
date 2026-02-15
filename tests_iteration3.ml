#use "CPtest.ml";;
#use "camlbrick.ml";;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
    let test_fonc_ball_modif_speed(): unit =
    let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
    solid = Array.make_matrix 30 20 BK_empty;
    param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
    color = Array.make 5 WHITE;
    ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
    ball_number = ref 0} in 
    let ball : t_ball = {pos_x = 250; pos_y = 150 ; diam = 10 ; speed = {x = 1; y = 2}; color = WHITE} in
    let l_result : t_ball t_test_result = test_exec(ball_modif_speed, "prend le jeu(t_camlbrick), la balle(t_ball), et un vecteur vitesse(t_vect_2) en paramètre",(game, ball, dv))
    in
    (
      assert_equals_result_m("modifie la vitesse de la balle par addition ou soustraction", (11, 12), l_result)
    );
  ;;
  
  (**
      Cette fonction vérifie que la vitesse de la balle est bien multiplié
      @author Aurousseau Enzo
      *)
  let test_fonc_ball_modif_speed_sign(): unit =
    let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
    solid = Array.make_matrix 30 20 BK_empty;
    param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
    color = Array.make 5 WHITE;
    ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
    ball_number = ref 0} in 
    let ball : t_ball = {pos_x = 250; pos_y = 150 ; diam = 10 ; speed = {x = 1; y = 2}; color = WHITE} in
    let l_result : t_ball t_test_result = test_exec(ball_modif_speed_sign, "prend le jeu(t_camlbrick), la balle(t_ball), et un vecteur vitesse(t_vect_2) en paramètre",(game, ball, sv))
    in 
    (
      assert_equals_result_m("modifie la vitesse de la balle par modification", (5, 20), l_result)
    );
  ;;
  
  (**
      Cette fonction Vérifie qu'un point(x, y) soit dans le cercle
      @author Aurousseau Enzo
      *)
  let test_fonc_is_inside_circle(): unit = 
    let l_result : int t_test_result = test_exec(is_inside_circle, "prend les coordonnées d'un point en x et y, d'un cercle avec cx et cy, et le radius", ( cx, cy, rad, x, y) )
    in
    (
      assert_true_m("renvoie true si le point est dans le cercle", true, l_result)
    );
  ;;
  
  (**
      Cette fonction Détecte qu'un point(x, y) soit dans un rectangle formé
      @author Aurousseau Enzo
      *)
  let test_fonc_is_inside_quad(): unit =
    let l_result : int t_test_result = test_exec(is_inside_circle, "prend les coordonnées d'un point en x et y, et x1, x2, y1, y2 les points du rectangle", ( x1,y1,x2,y2, x,y) )
    in
    (
      assert_true_m("renvoie true si le point est dans un rectangle formé", true, l_result)
    );
  ;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
  let test_fonc_min(): unit =
    let x = 5 in
    let y = 10 in
    let l_result : int t_test_result = test_exec(min, "Prend 2 entiers x et y, et renvoie le plus petit des deux", (x, y))
  in
  (
    assert_true_m("Renvoie la plus petite valeur entre x et y", x1, l_result)
  );
;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_max(): unit =
  let x = 5 in
  let y = 10 in
  let l_result : int t_test_result = test_exec(max, "Prend 2 entiers x, y, et renvoie le plus grand des 2", (x, y))
  in
  (
    assert_true_m("Renvoie la plus grande valeur entre x et y", y1, l_result)
  );
;;


(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_ball_remove_out_of_border(): unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball1 = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball2 = [{pos_x = 300; pos_y = 85 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  ball3 = [{pos_x = 1000; pos_y = 700 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  balls = [ball1, ball2, ball3]}
  let l_result : t_ball t_test_result = test_exec(ball_remove_out_of_border, "prend le jeu en paramètre et une balle" , (game , balls))
  in
  (
    assert_value_in_list_m("renvoie une liste de balle à l'interieur des bordures" , [ball1, ball2], l_result)
  );
;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_ball_hit_paddle(): unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  paddle = [{width = ref 20; height = 10; pos_x = 200; pos_y = 500; color = RED}]}
  let l_result : bool t_test_result = test_exec(ball_hit_paddle,  "prend le jeu en paramètre, une balle, et une raquette" , (game , balls, paddle))
  in
  (
    assert_true_m("Teste la colision avec la raquette", true, l_result)
  );
;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_ball_hit_corner_brick(): unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];
  paddle = [{width = ref 20; height = 10; pos_x = 200; pos_y = 500; color = RED}]}
  let i = 1 in
  let j = 1 in
  let l_result = bool t_test_result = test_exec(ball_hit_corner_brick, "prend le jeu en paramètre, une balle, un entier i et j qui correspondent aux indices des briques(ligne i et colonne j)", (game, ball, i, j))
  in 
  (
    assert_true_m("Test collision avec un coin de la brique", true,l_result) ;;
  );
;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_ball_hit_side_brick(): unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 385; pos_y = 110 ; diam = 10; speed = {x = 1; y = 2}; color = WHITE;}];}
  let i = 1 in
  let j = 1 in
  let l_result = bool t_test_result = test_exec(ball_hit_side_brick, "prend le jeu en paramètre, une balle, un entier i et j qui correspondent aux indices des briques(ligne i et colonne j)", (game, ball, i, j))
  in 
  (
    assert_true_m("Test collision avec un coin de la brique", true,l_result) ;;
  )
;;

(**
    Cette fonction vérifie que la vitesse de la balle est bien modifié
    @author Aurousseau Enzo
    *)
let test_fonc_game_test_hit_balls(): unit =





test_fonc_ball_modif_speed();;
test_fonc_ball_modif_speed_sign();;
test_fonc_is_inside_circle();;
test_fonc_is_inside_quad();;
test_fonc_min();;
test_fonc_max();;
test_fonc_ball_remove_out_of_border();;

test_fonc_ball_hit_paddle();;
test_fonc_ball_hit_corner_brick();;
test_fonc_ball_hit_side_brick();;


test_report();;