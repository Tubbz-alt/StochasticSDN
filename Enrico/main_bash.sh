#!/bin/bash

#Goal: 1) Create a simulated network.
#      2) Iterate link weights Generation
#      3) Find the shortest path, solving  with .mzn file

# Delimiter
DEL=+++++++++++++++++++++++++++++++++++++++++++

# Creating simulated network.
python fragments_thrink.py

for (( i = 1; i <= 3; i++ )); do
  printf "$DEL\n\t\tSCENARIO  $i\t\t\n$DEL\n\n"

  # Generating new weights configuration
  python domain_weights_generation.py

  #Solving with Minizinc
  mzn-g12mip Progetto_Intelligenza_Artificiale_Enrico.mzn

  printf '\n'
done
