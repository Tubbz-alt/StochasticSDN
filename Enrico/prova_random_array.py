
import random

import numpy as np, numpy.random
random_array = [0 for i in range(10)]

for i in range(10):
    random_array[i] = random.uniform(0.1,1.0);

somma = sum(random_array)

for i in range(10):
    random_array[i] = random_array[i]/somma
#for i in range(10):
#print(sum(random_array))
# dist = np.random.dirichlet(np.ones(10),size=1),2
# dist = np.around(dist,2)
# print("Distribuzione: " + str(dist))
print(random_array)
print(sum(random_array))
