%File di prova: si vuole testare il funzionamento di due include in uno stesso file e il corretto import delle variabili nei relativi file .dzn
%

include "prova.dzn";
include "prova2.dzn";

array[1..4] of float: array1;
array[1..4] of float: array2;

solve satisfy;

output["\nArray1: ", show(array1)]++["\nArray2: ", show(array2)]