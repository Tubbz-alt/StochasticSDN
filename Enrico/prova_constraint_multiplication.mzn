array[1..3,1..16] of float: mat1 = [|1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16|1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16|1,22,33,44,5,6,7,8,9,10,11,12,13,14,15,16|];
array[1..3,1..16] of float: mat2 = [|0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3|0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5|0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2|];
array[1..3] of float: prob = [1,1,1];
array[1..4] of var 0..1: active = [1,0,1,1];
array[1..4,1..4] of var 0..1: matbool; 
array[1..3,1..4,1..4] of float: mat3d = array3d(1..3,1..4,1..4, mat1);
array[1..3,1..4,1..4] of float: matprob = array3d(1..3,1..4,1..4, mat2);

constraint
   forall(i,j in 1..4 where i < j)(
     if active[ i ] == 0 then
        matbool[i,j] = 0 /\ matbool[j,i] = 0
     else
        matbool[i,j] = 1 /\ matbool[j,i] = 1
     endif
);
  
function var float: expected(array[int,int,int] of var float: w, array[int,int,int] of var float: p, var int: index) = sum (k in index_set_1of3(w), i in index_set_2of3(w), j in index_set_3of3(w) where i < j) (p[index,i,j]*w[index,i,j]*matbool[i,j]) / sum(prob);

%var float: res1 = expected(mat3d, matprob, 1);
%var float: res2 = expected(mat3d, matprob, 2);
%var float: res3 = expected(mat3d, matprob, 3);
var float: res =  min( i in 1..3) (expected(mat3d, matprob,i));

solve satisfy;

output["Mat3d 1:\n"]++[
      join("| ",[show(mat3d[1,i,j])]) ++
      if j == 4 then "|\n" else " " endif | i,j in 1..4 ]++
      ["Mat3d 2 :\n"]++[
      join("| ",[show(mat3d[2,i,j])]) ++
      if j == 4 then "|\n" else " " endif | i,j in 1..4 ]++
      ["Mat3d 3:\n"]++[
      join("| ",[show(mat3d[3,i,j])]) ++
      if j == 4 then "|\n" else " " endif | i,j in 1..4 ]++
      ["\nMat Bool:\n"]++[
      join("| ",[show(matbool[i,j])]) ++
      if j == 4 then "|\n" else " " endif | i,j in 1..4 ]++
      %["\nRes 1: ",show(res1)]++
      %["\nRes 2: ",show(res2)]++
      %["\nRes 3: ",show(res3)]++
      ["\n\nRES: ",show(res)]