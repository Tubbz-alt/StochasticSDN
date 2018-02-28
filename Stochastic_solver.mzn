%------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%------------------------------------

% Project:  stochastic solution for shortest-path problem in a Software Defined Network (SDN).

% Goal: given an SDN network, with a fixed topology, we want to minimize the total interconnection cost between the domains

% Consideration:  in a fisrt step, following the reference paper, annotations were made for stochastic variables.
                   

% include dzn file containing the simulated net and the scenarios data.
include "simulated_net.dzn";
include "scenarios_data.dzn";

%--------------------------------------------------------------------------------------
% PARAMETERS AND DECISION VARIABLES


% Data from simulated_net.dzn
int: n_vnfs;
int: start_domain;
int: target_domain;
int: M;
array[1..3,1..2] of int: acc_request;
array[1..3,1..2] of int: dis_request;
int: n_domains;
array[1..3] of var int: service_request;
array[1..n_domains] of 0..1: domain_activated;
int: num_vnf_links;
array[1..num_vnf_links, 1..2] of int: vnf_links;
array[1..n_vnfs, 1..8] of int: vnfs;

int: n_row_3d = n_domains*n_domains;

% connection matrix of boolean values. 1 if link between two domains is active. 
array[1..n_domains, 1..n_domains] of var 0..1: domain_link_selection; 

% From scenarios_data.dzn
array[1..n_scenarios, 1..n_row_3d] of float: distance;     % Auxiliar matrix to create the array 3d congif_weights.
array[1..n_scenarios, 1..n_row_3d] of float: matrix_prob; % Probabilities matrix relative to several scenarios/weights configuration.
array[1..n_scenarios] of float: arr;                         % Array of probabilities. Need to weighted sum.
int: n_scenarios;                                           % Number of scenarios.

% Distance matrix. This matrix contains several weights configuration for the same net topology. 
%Created starting from distance matrix.
array[1..n_scenarios, 1..n_domains, 1..n_domains] of float: config_weights =
      array3d(1..n_scenarios, 1..n_domains, 1..n_domains, distance);

% Probabilities matrix. This matrix contains one probability for each matrix.
%Created starting from matrix_prob matrix.
array[1..n_scenarios, 1..n_domains, 1..n_domains] of float:  matrix_probabilities  =
      array3d(1..n_scenarios, 1..n_domains, 1..n_domains, matrix_prob);

%--------------------------------------------------------------------------------------
% CONSTRAINTS


%Checking for start and target domains. They must be active.
constraint assert(domain_activated[start_domain] == 1 /\domain_activated[target_domain] == 1 ,"Domain must be actived");

% Constraint over domain_link_selection. If a domain i is inactive, then deactivate links selection.
constraint
   forall(i,j in 1..n_domains where i < j) (
     if domain_activated[ i ] == 0 then
        domain_link_selection[i,j] = 0 /\ domain_link_selection[j,i] = 0
     else
        domain_link_selection[i,j] = 1 /\ domain_link_selection[j,i] = 1
     endif
  );
  

% CORE FUNCTION: Calculating weighted sum between config_weights matrix3d and probabilities array.
function var float: expected(array[int,int,int] of float: w, array[int,int,int] of float: p, var int: index) =
  sum (k in index_set_1of3(w), i in index_set_2of3(w), j in index_set_3of3(w) where i < j) (p[index,i,j]*w[index,i,j]*domain_link_selection[i,j]) / sum(arr);


%float decision variables containing resulting 
var float: res =  min( i in 1..n_scenarios) (expected(config_weights, matrix_probabilities,i));
var float: res1 = expected(config_weights, matrix_probabilities, 1);
var float: res2 = expected(config_weights, matrix_probabilities, 2);
var float: res3 = expected(config_weights, matrix_probabilities, 3);
var float: res4 = expected(config_weights, matrix_probabilities, 4);
var float: res5 = expected(config_weights, matrix_probabilities, 5);
var float: res6 = expected(config_weights, matrix_probabilities, 6);
var float: res7 = expected(config_weights, matrix_probabilities, 7);
var float: res8 = expected(config_weights, matrix_probabilities, 8);
var float: res9 = expected(config_weights, matrix_probabilities, 9);
var float: res10 = expected(config_weights, matrix_probabilities, 10);

%Solving. Note that the minization is implemented in expected function.
solve satisfy;


% Printing: - three weights configuration matrix (scenario)
%          - resulting values for each scenario
%          - final value: minimum of scenarios total costs. 
output  ["Distance 1:\n["]++[
       join("| ",[show(config_weights[1,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
     ["]"] ++
     ["\nDistance 2:\n"]++[
      join("| ",[show(config_weights[2,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
      ["]"] ++
        ["\nDistance 3:\n"]++[
      join("| ",[show(config_weights[3,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
       ["]"]++
       ["\nDistance 6:\n"]++[
      join("| ",[show(config_weights[6,i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
      ["]"] ++
       ["\nDomain link selection:\n"]++[
      join("| ",[show(domain_link_selection[i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
      
      ["\nRes 1: ", show_float(6,2,res1)]++
      ["\nRes 2: ", show_float(6,2,res2)]++
      ["\nRes 3: ", show_float(6,2,res3)]++
      ["\nRes 4: ", show_float(6,2,res4)]++
      ["\nRes 5: ", show_float(6,2,res5)]++
      ["\nRes 6: ", show_float(6,2,res6)]++
      ["\nRes 7: ", show_float(6,2,res7)]++
      ["\nRes 8: ", show_float(6,2,res8)]++
      ["\nRes 9: ", show_float(6,2,res9)]++
      ["\nRes 10: ", show_float(6,2,res10)]++
      ["\n\nRes: ", show_float(6,2,res)]
       
       
