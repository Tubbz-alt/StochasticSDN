%------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%------------------------------------

% Soluzione stocastica in Minizinc per la risoluzione di una rete SDN (Software Defined Network).
% Obiettivo: trovare l'interconnessione tra domini con peso minore.
% considerare il peso tra domini come variabile stocastica ed effettuare la conversione (da annotazione a file .mzn)

% include del file contenente le caratteristiche della rete.
include "globals.mzn";
include "simulated_net.dzn";
include "scenarios_data.dzn";

% PARAMETERS

% From simulated_net.dzn
int: n_vnfs;
int: start_domain; 
int: target_domain;
int: M;
int: n_domains;
int: num_vnf_links;
int: n_row_3d = n_domains*n_domains;
int: n_scenarios = 3;
array[1..3,1..2] of var int: acc_request;
array[1..3,1..2] of var int: dis_request;
array[1..3] of var int: service_request;
array[1..n_domains] of 0..1: domain_activated; % domains where lie the start and target vnf
array[1..n_domains, 1..n_domains] of var 0..1: domain_link_selection;  % the resulting connection matrix
array[1..num_vnf_links, 1..2] of var int: vnf_links;
array[1..n_vnfs, 1..8] of var int: vnfs;

% From scenarios_data.dzn
array[1..n_scenarios, 1..n_row_3d] of float: distance; % Auxiliar matrix to create the array 3d congif_weights
array[1..n_scenarios, 1..n_row_3d] of float: matrix_prob; % Probabilities matrix relative to several scenarios/weights configuration
array[1..n_scenarios] of float: array_prob; % Probabilities array, containing prob for each scenario.
% Distance matrix. This matrix contains several weights configuration for the same net topology 
array[1..n_scenarios, 1..n_domains, 1..n_domains] of float: config_weights = 
      array3d(1..n_scenarios, 1..n_domains, 1..n_domains, distance);

% Probabilities matrix. This matrix contains one probability for each matrix.
array[1..n_scenarios, 1..n_domains, 1..n_domains] of float:  matrix_probabilities  =
      array3d(1..n_scenarios, 1..n_domains, 1..n_domains, matrix_prob);

% Objective to minimize
%var int: total_cost = sum(i in 1..n_domains, j in 1..n_domains where config_weights[i,j] < M) (config_weights[i,j]* domain_link_selection[i,j] );


% VINCOLI

%controllo sul dominio inziiale e finale --> devono essere attivi
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

%array[1..n_scenarios, 1..n_domains, 1..n_domains] of float: mat = (k in 1..n_scenarios, i in 1..n_domains, j in 1..n_domains )(config_weights[k,i,j]*domain_link_selection[i,j]);
% Check domain link selection. If a link is inactive, set to 0 the relative weights in congif_weights.
% constraint forall(k in 1..n_scenarios, i in 1..n_domains, j in 1..n_domains where i < j) (
%   if domain_link_selection[i,j] == 0 then
%     config_weights[k,i,j] = 0 /\ config_weights[k,j,i] = 0
% else true
%  endif
% );

% Calculating weighted sum between config_weights matrix3d and probabilities array.  
function var float: expected(array[int,int,int] of float: w, array[int,int,int] of float: p, var int: index) = 
  sum (k in index_set_1of3(w), i in index_set_2of3(w), j in index_set_3of3(w)) (p[index,i,j]*w[index,i,j]) / sum(array_prob);

var float: res =  min( i in 1..n_scenarios) (expected(config_weights, matrix_probabilities,i));


%solve minimize res;
solve satisfy;

output["Distance 1:\n["]++[
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
       ["\nDomain link selection:\n"]++[
      join("| ",[show(domain_link_selection[i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..n_domains ]++
       ["\nRes: ", show(res)]