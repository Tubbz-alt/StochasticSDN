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
int: n_vnf = 120;

%tipi di vnf
int: dpi = 120; 
int: wana = 120;
int: shaper = 120;
int: border = 120;
int: endpoint = 120;


var 5..n_domains: nd;  %numero dei domini compreso tra 5 e 10
var 5..n_vnf: nv;

var 5..dpi: n_dpi; %almeno 5 dpi
var 10..wana: n_wana; %almeno 10 wana
var 9..shaper: n_shaper; %almeno 9 shaper
var 1..border: n_border; %almeno 1 border
var 1..endpoint: n_ep; %almeno 1 endpoint

%-------------------------------------------
% VINCOLI
%-------------------------------------------


constraint n_border = nd;  %numero dei vnf 'border' uguale al numero dei domini
constraint n_ep = nd;  %numero dei vnf 'endpoint' uguale al numero dei domini
constraint n_wana + n_dpi + n_shaper >= nv - (n_border + n_ep); %il numero delle vnf deve essere minore o uguale alla somma dei rimanenti tipi di vnf (prova)

%risolvo massimizzando quanti piu nodi possibili e per piu domini possibili
solve maximize nv + nd;

output[
  "Number of domains:", show(nd),"\n",
  "Number of vnf: ", show(n_dpi+n_wana+n_shaper+n_border+n_ep),"\n\n",
  "Number of dpi: ", show(n_dpi), "\n",
  "Number of wana: ", show(n_wana),"\n",
  "Number of shaper: ", show(n_shaper),"\n",
  "Number of border: ", show(n_border), "\n",
  "Number of endpoint: ", show(n_ep), "\n"
]

