include "globals.mzn";
include "alldifferent.mzn";

int: i = 5;
int: j = 5;

% set of int: n = 1..i;
% set of int: m = 1..j;

array[1..i,1..j] of var 1..5: M;

constraint alldifferent([M[j,i]|i in 1..4]);
constraint M[1,1] > M[2,1] * 2;

solve maximize 2*(i*3) + j;

output
]

