

array[1..2,1..6] of int: pass = [|1,2,3,4,5,6|7,8,9,10,11,12|];
array[1..3] of var int: p = [1,1,1];

array[1..2, 1..3, 1..3] of var int: a = array3d(1..2, 1..3, 1..3, pass);
%function var float: expected(array[int,int,int] of int: w, array[int] of var int: p) = 
  %sum (i in index_set_1of3(w), j in index_set_2of3(w), k in index_set_3of3(w)) (p[i]*w[k][i,j]) div sum(p);

%var float: res = expected(a,p);


%solve minimize res;
solve satisfy;

output[show(pass), show(a)]%, "\n", show(a[1,2]), show(res)]