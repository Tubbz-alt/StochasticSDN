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
array[1..3, 1..n_row_3d] of var int: distance; % Auxiliar matrix to create the array 3d congif_weights
array[1..n_scenarios] of var int: array_prob; % Probabilities array relative to several scenarios/weights configuration

% Distance matrix. This matrix contains several weights configuration for the same net topology 
array[1..3, 1..n_domains, 1..n_domains] of var int: config_weights = 
      array3d(1..3, 1..n_domains, 1..n_domains, distance);

% Objective to minimize
%var int: total_cost = sum(i in 1..n_domains, j in 1..n_domains where domain_link_weights[i,j] < M) ( domain_link_weights[i,j]* domain_link_selection[i,j] );

% VINCOLI

%controllo sul dominio inziiale e finale --> devono essere attivi
constraint assert(domain_activated[start_domain] == 1 /\domain_activated[target_domain] == 1 ,"Domain must be actived");

% Controllo sui domini attivi. Se un dominio è attivo allora settare a 0 i link tra i e j , nella matrice domain_link_selection
constraint 
  forall(i,j in 1..n_domains where i < j) (
    if domain_activated[ i ] == 0 then
        domain_link_selection[i,j] = 0 /\ domain_link_selection[j,i] = 0
     else 
        domain_link_selection[i,j] = 1 /\ domain_link_selection[j,i] = 1
     endif
  );
  
% funzione che calcola la somma pesata tra l'array contenente i pesi e la relativa probabilità  
function var int: expected(array[int,int,int] of int: w, array[int] of var int: p) = 
  sum (i in index_set_1of3(w), j in index_set_2of3(w), k in index_set_3of3(w)) (p[i]*w[i]) div sum(p);

%solve satisfy;
%solve :: int_search([domain_link_selection[i,j] | i,j in 1..n_domains], first_fail, indomain, complete) minimize total_cost;
solve minimize expected(config_weights, array_prob);

%output["Domain_link_weights:\n["]++[
%       join("| ",[show(domain_link_weights[i,j])]) ++
%       if j == 15 then "\n" else " " endif | i,j in 1..15 ]++
%      ["]"]

%output[show(total_cost),"\n", show(prob_matrix)]


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
       ["\n",show(array_prob)]