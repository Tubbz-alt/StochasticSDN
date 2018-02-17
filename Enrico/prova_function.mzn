include "globals.mzn";

array[1..2,1..4] of float: pass = [|1.1,2.4,3.2,4.1|1.3,2.0,1.2,1.7|];
array[1..2] of float: p = [0.4,0.6];

array[1..2, 1..2, 1..2] of float: a = array3d(1..2, 1..2, 1..2, pass);

function var float: expected(array[int,int,int] of float: w, array[int] of float: p) = 
  sum (k in index_set_1of3(w), i in index_set_2of3(w), j in index_set_3of3(w)) (p[i]*w[k,i,j]) / sum(p);

var float: res = expected(a,p);

solve minimize res;
%solve satisfy;

output[show(res),"\n",show_float(2, 2, res)]