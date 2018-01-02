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
int: M = 10;
array[acc_request] of int: lista;  % E per gli array e matriciii???


% DEICSION VARIABLES


% VINCOLI

% La soluzione potrebbe essere, riprendendo l'obiettivo sopra spiegato,  minizzare la variabile che identifica i pesi tra domini. 
% Quindi l'idea sarebbe di immagazzinare i links in un array e applicare il solve su di esso. 


solve satisfy;

output[
    show(n_vnfs)
]

