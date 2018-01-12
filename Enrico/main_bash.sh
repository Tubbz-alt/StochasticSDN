#!/bin/bash

# Obiettivo:
# 1) Iterare il processo di creazione della rete simulata (quindi del file .dzn)
# 2) Dare in pasto in modo iterato il file al risolutore minizinc, in modo da
#    trovare una serie di solizione per piu scenari.

printf "Scenario 1:\n\n"  #prova stampa hello world

python fragments_thrink.py
