include "globals.mzn";

array[1..2,1..4] of float: pass = [|0,2.4,2.4,0|0,2.0,2.0,0|];
array[1..2,1..4] of float: p_pass = [|0.4,0.4,0.4,0.4|0.6,0.6,0.6,0.6|];
array[1..2] of 0..1: domain_activated = [1, 1];   % active domains
array[1..2, 1..2] of var 0..1: domain_link_selection;  % the resulting connection matrix


array[1..2, 1..2, 1..2] of float: p = array3d(1..2,1..2,1..2, p_pass); 
array[1..2, 1..2, 1..2] of float: a = array3d(1..2, 1..2, 1..2, pass);
array[1..2] of var float: prob = [0.4,0.6];
array[1..2] of var float: exp_arr;

%
constraint forall(i,j in 1..2 where i < j) (
    if domain_activated[ i ] == 0 then
        domain_link_selection[i,j] = 0 /\ domain_link_selection[j,i] = 0
     else 
        domain_link_selection[i,j] = 1 /\ domain_link_selection[j,i] = 1
     endif
  );
  
% 
constraint forall(k,i,j in 1..2 where i < j) (
    if domain_link_selection[i,j] == 0 then
       a[k,i,j] = 0 /\ a[k,j,i] = 0
    else true
    endif
    );


% Calcolo delle somme pesate tra matrice dei pesi e relativa probabilità
function var float: expected(array[int,int,int] of float: w, array[int,int,int] of float: p, var int: index) = 
  sum ( i in index_set_2of3(w), j in index_set_3of3(w) where i < j) (p[index,i,j]*w[index,i,j]) / sum(prob);

% Calcolo del minimo tra le somme pesate calcolate.
%function var float: risultato() =;
var float: res =  min( i in 1..2) (expected(a,p,i));
%solve minimize (expected(a,p,i))(i in 1..2);
solve minimize res;


output["Mat1:\n"]++[
       join("| ",[show(a[1,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..2]++
           ["\nMat2:\n"]++[
      join("| ",[show(a[2,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..2]++
      ["\nRis: \n["]++[
      join(" ",[show_float(2,2,p[k,i,j]),"*",show_float(2,2,a[k,i,j]),"|"])++
      if j == 2 then "\n" else " " endif | k,i,j in 1..2]++
      ["]"]++["\nRes: ",show(res)]


%1.1  2.4 |  1.3  2.0  |  1  ,  0
  %       |
%3.2  4.1 |  1.2  1.7  |  1  ,  1


