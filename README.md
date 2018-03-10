# StochasticSDN

A stochastic minizinc solution to solve a software defined network configuration problem


## Synopsis
In this project we conisider a simulated SDN net (Software Defined Network). This network is composed by a certain number of domains, and into each one there is a certain number of VNF (Virtual Network Function). VNF will be ignored in this project beacause are not study objective. This network represent a graph connected component and our goal is to minimize the links weight between two different domains.
In fragment_thrinks.py file a simulated net is created. This script generate test.dzn file containing all relative net features.
In domain_weights_generation.py file a bunch of scenarios is simulated. This process create ten weight configurations for the same net topology.
Output: 
- fragment_thrinks.py script give in output simulated.net.dzn file
- domain_weights_generation.py script give scenarios_data.dzn file

These file will be the input files in Minizinc model.

## Dependencies
- Python (at least 2.7.13 version)
- Minizinc package


## Installation
To try this project need to install Minizinc package.
Arfet you have runned fragment_thrinks.py and domain_weights_generation.py files, you can run from MiniZinc IDE the Stochestic_solver.mzn file or run from temrinal
```bash
mzn-g12mip <file.mzn> <file.dzn>
```
You can also try to run main_bash.sh script.
This script run all file and give you the result.


## Contributors
**Enrico Valguarnera**<br /> **Davide Allevi**<br /> **Cataldo Picciarelli**
