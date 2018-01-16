# StochasticSDN

A stochastic minizinc solution to solve a software defined network configiguration problem


## Synopsis
In this project we conisider an hipothetical SDN (Software Defined Network). This network is composed by a certain number of domains, and into each domain there is a certain number of VNF (Virtual Network Function). This network represent a graph connected component and our goal is to minimize the links weight between two different domains.  


## Installation

To try this project need to install Minizinc package.
You can run from MiniZinc IDE the Progetto_Intelligenza_Artificiale.mzn file or run from temrinal
```bash
mzn-g12mip <file.mzn> <file.dzn>
```

You can also try to run main_bash.sh script in Enrico folder. 
This script iterate Progetto_Intelligenza_artificiale.mzn file for multiple scenarios.


## Contributors
**Enrico Valguarnera**<br /> **Davide Allevi**<br /> **Cataldo Picciarelli**
