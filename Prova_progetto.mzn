%------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%------------------------------------
  %Soluzione stocastica in Minizinc per la risoluzione di una rete SDN (Software Defined Network).

% Bozza Variabili minizinc:
%   Domini
%   tipi Vnf
%   numero vnf ???
%   Link itra-dominio
%   Link inter-dominio
%   Peso dei collegamenti

%-----------------------------------
% VARIABILI
%-----------------------------------

%numero massimo di domini
int: n_domains = 15;

%numero di vnf totali
int: n_vnf = 20;

%tipi di vnf
var 1..n_vnf: dpi;
var 1..n_vnf: wana;
var 1..n_vnf: shaper;
var 1..n_vnf: border;
var 1..n_vnf: endpoint; 


var 5..n_domains: nd;  %numero dei domini compreso tra 5 e 10
var 5..n_vnf: nv;


%-------------------------------------------
% VINCOLI
%-------------------------------------------

constraint dpi >= 5; %almeno 5 dpi
constraint wana >= 10; %almeno 10 wana
constraint shaper >= 9; %almeno 9 shaper
constraint border >= 1; %almeno 1 border
constraint endpoint >= 1; %almeno 1 endpoint
constraint border = nd;  %numero dei vnf 'border' uguale al numero dei domini
constraint endpoint = nd;  %numero dei vnf 'endpoint' uguale al numero dei domini
%constraint wana + dpi + shaper >= nv - (border + ep); %il numero delle vnf deve essere minore o uguale alla somma dei rimanenti tipi di vnf (prova)

%risolvo massimizzando quanti piu nodi possibili e per piu domini possibili
%solve maximize nv + nd;

solve satisfy;

output[
  "Number of domains:", show(nd),"\n",
  "Number of vnf: ", show(dpi+wana+shaper+border+endpoint),"\n\n",
  "Number of dpi: ", show(dpi), "\n",
  "Number of wana: ", show(wana),"\n",
  "Number of shaper: ", show(shaper),"\n",
  "Number of border: ", show(border), "\n",
  "Number of endpoint: ", show(endpoint), "\n"
]
