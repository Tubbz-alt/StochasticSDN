#!/bin/bash

#Goal: 1) Create a simulated network.
#      2) Generate a matrix3d containing several weight configurations with a probability distribution.
#      3) Solve with minizinc to find the better minimum total cost overall scenarios.

# Creating simulated network.
python fragments_thrink.py

# Creating matrix3d of scenarios (each scenario correspond to different weights
# configuration for same net topology) and matrix3d of relative probabilities.
# For each scenario il linked a probebility.
python domain_weights_generation.py

#Solving with Minizinc model.
echo "Di seguito i costi totali per tutti gli scenari:"
mzn-gecode Stochastic_solver.mzn
