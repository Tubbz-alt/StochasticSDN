%array[1..2,1..2,1..2] of int: matrix = array3d(1..2,1..2,1..2, [])

include "scenarios_data.dzn";

int: n_domains = 15;
int: n_row_3d = n_domains*n_domains;
int: n_scenarios = 3;

array[1..n_scenarios, 1..n_row_3d] of var int: distance;

array[1..n_scenarios, 1..n_domains, 1..n_domains] of var int: matrix = 
      array3d(1..n_scenarios, 1..n_domains, 1..n_domains, distance);
    
    
solve satisfy;

%output[show(distance)]
output["Distance 1:\n["]++[
       join("| ",[show(matrix[1,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
     ["]"] ++
     ["\nDistance 2:\n"]++[
      join("| ",[show(matrix[2,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
       ["]"] ++ 
        ["\nDistance 3:\n"]++[
      join("| ",[show(matrix[3,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
       ["]"]