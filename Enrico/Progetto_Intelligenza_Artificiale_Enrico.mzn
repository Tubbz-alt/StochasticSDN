%------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%------------------------------------

% Soluzione stocastica in Minizinc per la risoluzione di una rete SDN (Software Defined Network).

% Obiettivo: trovare l'interconnessione tra domini con peso minore.
% considerare il peso tra domini come variabile stocastica ed effettuare la conversione (da annotazione a file .mzn)


% include del file contenente le caratteristiche della rete.
include "test.dzn";

% PARAMETERS
int: n_vnfs;
int: start_domain;
int: target_domain;
int: M;
int: n_domains;
int: num_vnf_links;

array[1..3,1..2] of var int: acc_request;
array[1..3,1..2] of var int: dis_request;

array[1..n_domains,1..n_domains] of var int: domain_link_weights;

array[1..3] of var int: service_request;
array[1..n_domains] of 0..1: domain_activated; % domains where lie the start and target vnf
array[1..n_domains, 1..n_domains] of var 0..1: domain_link_selection;  % the resulting connection matrix
array[1..num_vnf_links, 1..2] of var int: vnf_links;
array[1..n_vnfs, 1..8] of var int: vnfs;


% DEICSION VARIABLES

% objective to minimize
var int: total_cost = sum(i in 1..n_domains, j in 1..n_domains where domain_link_weights[i,j] < M) ( domain_link_weights[i,j]* domain_link_selection[i,j] );

% VINCOLI

%L'idea è quella di creare una variabile (parametro) stocastica per i pesi. Il singolo peso tra due domini cosi
% è un valore aleatorio (compreso in un range finito). Si vuole trovare una soluzione per il cammino migliore attraverso
%  tutti i domini della rete.

%solve satisfy;
solve :: int_search([domain_link_selection[i,j] | i,j in 1..n_domains], first_fail, indomain, complete) minimize total_cost;

% output["Domain_link_weights:\n["]++[
%       join("| ",[show(domain_link_weights[i,j])]) ++
%       if j == 15 then "\n" else " " endif | i,j in 1..15 ]++
%       ["]"]

output[show(total_cost)]
