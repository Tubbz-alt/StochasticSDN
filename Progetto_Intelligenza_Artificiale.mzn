%------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%------------------------------------

%Soluzione stocastica in Minizinc per la risoluzione di una rete SDN (Software Defined Network).

% Obiettivo: trovare l'interconnessione tra domini con peso minore.
% considerare il peso tra domini come variabile stocastica ed effettuare la conversione (da annotazione a file .mzn) 

%include del file contenente le caratteristiche della rete.
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
array[1..15,1..15] of var int: domain_link_weights;
array[1..3] of var int: service_request;
array[1..15] of var int: domain_activated;
array[1..num_vnf_links, 1..2] of var int: vnf_links;
array[1..n_vnfs, 1..8] of var int: vnfs;


% DEICSION VARIABLES


% VINCOLI

% La soluzione potrebbe essere, riprendendo l'obiettivo sopra spiegato,  minizzare la variabile che identifica i pesi tra domini. 
% Quindi l'idea sarebbe di immagazzinare i links in un array e applicare il solve su di esso. 


solve satisfy;

output[
%     "Number of vnf: " ++ show(n_vnfs) ++ "\n" ++
%     "M :" ++ show(M) ++ "\n" ++
    
%     "Acc_request:[\t" ++
%     join(", ",[show(domain_link_weights[i,j])|i in 1..15, j in 1..15]) ++
%     "\t]"

%Cosi si fa la stampa formattando in output la matrice per righe.
      join(", ",[show(domain_link_weights[i,j])]) ++
      if j == 15 then "\n" else " " endif | i,j in 1..15 
]

