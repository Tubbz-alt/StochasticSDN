

array[1..2,1..3] of int: a = [|1,2,3|5,6,7|];
array[1..3] of var int: p = [1,1,1];

%function var float: expected(array[int,int] of int: w, array[int] of var int: p) = 
  %sum (i in index_set_1of2(w), j in index_set_2of2(w)) (p[i]*w[i][j]) div sum(p);

%var float: res = expected(a,p);


%solve minimize res;
solve satisfy;

output[show(a), "\n",show(index_set_1of2(a)), show(a[1,2])]