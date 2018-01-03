include "test2.dzn";

%Si acquisisce la variabile dal file .dzn in questo modo:
% nel caso di un array si devono indicare le dimensioni dell'array
%Sia che sia monodimensionale che bisimensionale.

%Nel caso gli indici non combacino esattamente con la dimensione della struttura
%Dichiarata nel file .dzn si incorre in errore

% Dentro le quadre, prima la dimensione delle righe e poi delle colonne
%L'array deve essere dichiarato con lo stesso nome che compare nel file .dzn 
array[1..4,1..5] of var int: acc_request;

solve satisfy;

% La formattazione della stampa puo essere fatta cosi. 
% La join serve per effettuare una split dei valori, in questo caso
% tramite virgole.


output[
    "acc_request:[\t" ++
    join(", ",[show(acc_request[1,j])|j in 1..5]) ++
    "\n\t\t" ++
    join(", ",[show(acc_request[2,j])|j in 1..5]) ++
    "\n\t\t" ++
    join(", ",[show(acc_request[3,j])|j in 1..5]) ++
    "\n\t\t" ++
    join(", ",[show(acc_request[4,j])|j in 1..5]) ++
    "\t]"
]