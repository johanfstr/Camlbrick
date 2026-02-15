#use "CPtest.ml";;
#use "camlbrick.ml";;


vec2_add_scalar
vec2_mult
vec2_mult_scalar
(**
Cette fonction test si l'addition de deux vecteurs fonctionne bel et bien
@author Auderick Guthoerl    
*)
let test_fonc_vec2_add1() : unit =
  let l_vec_a : t_vec2 = {x = 0 ; y = 5} and l_vec_b : t_vec2 = {x = 2 ; y = 3} in
  let l_result : t_vec2 t_test_result = test_exec(vec2_add,"les deux vecteurs =", (l_vec_a,l_vec_b))
  in
  (
    assert_equals_result_m("addition de deux vecteurs {0;5} et {2;3}" , {x = 2 ; y = 8} , l_result)
  )
  ;;
;;

let test_fonc_vec2_add2() : unit =
  let l_vec_a : t_vec2 = {x = 2 ; y = -4} and l_vec_b : t_vec2 = {x = -6 ; y = 3} in
  let l_result : t_vec2 t_test_result = test_exec(vec2_add,"les deux vecteurs =", (l_vec_a,l_vec_b))
  in
  (
    assert_equals_result_m("addition de deux vecteurs {2;-4} et {-6;3}" , {x = -4 ; y = -1} , l_result)
  )
  ;;
;;



(**
Cette fonction test si l'addition du vecteur et des scalaires fonctionne
@author Auderick Guthoerl
*)
let test_fonc_vec2_add_scalar1() : unit =
  let l_vec_a : t_vec2 = {x = 4 ; y = 9} in
  let l_result : t_vec2 t_test_result = test_exec(vec2_add_scalar,"le vecteur et les 2 scalaires", (l_vec_a,6,1))
  in
  (
    assert_equals_result_m("addition du vecteur {4;9} et des scalaires 6 et 1" , {x = 10; y = 10} , l_result)
  )
  ;;
;;

let test_fonc_vec2_add_scalar2() : unit =
  let l_vec_a : t_vec2 = {x = -4 ; y = -9} in
  let l_result : t_vec2 t_test_result = test_exec(vec2_add_scalar,"le vecteur et les 2 scalaires", (l_vec_a,-6,-1))
  in
  (
    assert_equals_result_m("addition du vecteur {4;9} et des scalaires 6 et 1" , {x = -10; y = -10} , l_result)
  )
  ;;
;;

test_fonc_vec2_add1();;
test_fonc_vec2_add2();;

test_fonc_vec2_add_scalar1();;
test_fonc_vec2_add_scalar2();;
test_report();;