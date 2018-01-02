%--------------------------------------------------
% PROGETTO INTELLIGIENZA ARITIFICIALE
%--------------------------------------------------
% Bozza Variabili minizinc:
%   Domini
%   tipi Vnf
%   numero vnf ???
%   Link itra-dominio
%   Link inter-dominio
%   Peso dei collegamenti
int: n_domains = 15;
int: n_vnf = 120;

var 5..n_domains: nd;  %numero dei domini compreso tra 5 e 10
var 5..n_vnf: nv;

var 0..n_vnf: n_dpi; 
var 0..n_vnf: n_wana; 
var 0..n_vnf: n_shaper; 
var 1..n_vnf: n_border; %almeno 1 border
var 0..n_vnf: n_ep; 

constraint n_border = nd;  %numero dei vnf 'border' uguale al numero dei domini
constraint n_ep = nd;  %numero dei vnf 'endpoint' minore uguale al numero dei domini
constraint n_wana + n_dpi + n_shaper >= nv - (n_border + n_ep); %il numero delle vnf deve essere minore o uguale alla somma dei rimanenti tipi di vnf (prova)
constraint n_dpi >= 5 * nd;
constraint n_wana >= 11 * nd;
constraint n_shaper >= 4 * nd;

solve satisfy;

output[
  "Number of domains:", show(nd),"\n",
  "Number of vnf: ", show(n_dpi+n_wana+n_shaper+n_border+n_ep),"\n\n",
  "Number of dpi: ", show(n_dpi), "\n",
  "Number of wana: ", show(n_wana),"\n",
  "Number of shaper: ", show(n_shaper),"\n",
  "Number of border: ", show(n_border), "\n",
  "Number of endpoint: ", show(n_ep), "\n"
]

