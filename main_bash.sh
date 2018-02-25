#!/bin/bash

#Goal: 1) Create a simulated network.
#      2) Generate a weights configuration matrix
#      3) Solve with minizinc to find the better
#         minimum total cost overall scenarios.

# Creating simulated network.
python fragments_thrink.py

#Creating
python domain_weights_generation.py

echo "\nDi seguito i costi totali dei cammini minimi\n"
mzn-gecode Stochastic_solver.mzn
