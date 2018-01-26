#!/bin/bash

# Obiettivo:
# 1) Iterare il processo di creazione della rete simulata (quindi del file .dzn)
# 2) Dare in pasto in modo iterato il file al risolutore minizinc, in modo da
#    trovare una serie di solizione per piu scenari.

DEL=+++++++++++++++++++++++++++++++++++++++++++

for (( i = 1; i <= 3; i++ )); do
  printf "$DEL\n\t\tSCENARIO  $i\t\t\n$DEL\n\n"  #prova stampa hello world

  # Esecuzione dello script che crea il file .dzn, contenente le variabili che
  # identificano la rete simulata.
  # Ogni esecuzione e ogni set di varibiali identificano uno scenario differente.
  python fragments_thrink.py

  #Esecuzione del programma minizinc caricando il file .dzn
  # TO-DO comando

  #prova git con Cata

  # ATTENZIONE: POTREBBE CAPITARE DI DOVER SETTARE LA VARIABILE PATH..AGGIUNGENDO
  # IL PATH DELLA CARTELLA MINIZINC
  mzn-g12mip Progetto_Intelligenza_Artificiale_Enrico.mzn

  printf '\n'
done
