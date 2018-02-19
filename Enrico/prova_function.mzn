include "globals.mzn";

array[1..2,1..4] of float: pass = [|1.1,2.4,3.2,4.1|1.3,2.0,1.2,1.7|];
array[1..2] of float: p = [0.4,0.6];
array[1..2, 1..2] of var 0..1: dls = [|1,0|1,1|];  % the resulting connection matrix

array[1..2, 1..2, 1..2] of float: a = array3d(1..2, 1..2, 1..2, pass);

% TODO vincolo che leghi matrice a con matrice dls. Giusto?

% TODO controllare il calcolo che viene fatto dalla funzione e ragionare sulla correttezza della funzione scritta.


function var float: expected(array[int,int,int] of float: w, array[int] of float: p) = 
  sum (k in index_set_1of3(w), i in index_set_2of3(w), j in index_set_3of3(w)) (p[i]*w[k,i,j]*dls[i,j]) / sum(p);

var float: res = expected(a,p);

solve minimize res;
%solve satisfy;

output[show(res),"\n",show_float(2, 2, res), "\n"]++
    ["Mat1:\n"]++[
       join("| ",[show(a[1,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..2]++
           ["\nMat2:\n"]++[
      join("| ",[show(a[2,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..2]


%1.1  2.4 |  1.3  2.0  |  1  ,  0
  %       |
%3.2  4.1 |  1.2  1.7  |  1  ,  1


