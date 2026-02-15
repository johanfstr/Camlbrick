#use "CPtest.ml";;
#use "camlbrick.ml";;


(**
Cette fonction fait bouger le paddle avec la souris
@author Johan Forestier     
*)
let test_fonc_canvas_mouse_move () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let x : int = 0 in
  let y : int = 0 in
  let l_result : unit t_test_result = test_exec(canvas_mouse_move, "fait bouger le paddle avec la souris", (game, x, y)) in
  (
    assert_equals_m("fait bouger le paddle avec la souris", unit, l_result)
  );
;;

(**
Cette fonction fait bouger le paddle avec les flèches directionnelles
@author Johan Forestier     
*)
let test_fonc_canvas_keyreleased ()  : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : unit t_test_result = test_exec(canvas_keyreleased, "fait bouger le paddle avec les flèches directionnelles", (game, keyString, keyCode)) in
  (
    assert_equals_m("fait bouger le paddle avec avec les flèches directionnelles", unit, l_result)
  );
;;

(**
Cette fonction fait bouger le paddle avec les flèches directionnelles 
*)
let test_fonc_canvas_keyreleased () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : unit t_test_result = test_exec(canvas_keyreleased, "fait bouger le paddle avec les flèches directionnelles", (game, keyString, keyCode)) in
  (
    assert_equals_m("fait bouger le paddle avec avec les flèches directionnelles", unit, l_result)
  );
;;

(**
Cette fonction gère l'animation de la balle et les collisions    
*)
let test_fonc_animate_action () : unit =
  let game : t_camlbrick = {paddle = {width = 30 ; height = 10 ; pos_x = ref 385; pos_y = 100; color = "red"};
  solid = Array.make_matrix 30 20 BK_empty;
  param = {world_width = 800; world_bricks_height = 600; world_empty_height = 200; brick_width = 40; brick_height = 20; paddle_init_width = 100; paddle_init_height = 20; time_speed = ref 20};
  color = Array.make 5 WHITE;
  ball = [{pos_x = 0; pos_y = 0; diam = 0; speed = {x = 1; y = 2}; color = WHITE;}];
  ball_number = ref 0} in
  let l_result : unit t_test_result = test_exec(canvas_mouse_move, "gère l'animation de la balle et les collisions", (game)) in
  (
    assert_equals_m("gère l'animation de la balle et les collisions", unit, l_result)
  );
;;

test_fonc_canvas_mouse_move ();;
test_fonc_canvas_keyreleased ();;
test_fonc_canvas_keyreleased ();;
test_fonc_animate_action ();;

test_report();;