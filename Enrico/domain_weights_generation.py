import random
import os
import sys
n_domains = 15
n_scenarios = 3 #to simplify
testFile = 'scenarios_data.dzn'

#Creation of 3d structure containing the distance matrix (domain_link_weights configurations)
distance = [[[0 for i in range(n_domains)] for y in range(n_domains)] for k in range(n_scenarios)]
#distance = [[0 for j in range(n_domains)] for i in range(n_domains)] for k in range(n_scenarios)]
for k in range(n_scenarios):
	for j in range(n_domains):
		for i in range(n_domains):
			if i < j:
				tmpcost = random.randint(2, 8)
				distance[k][i][j] = tmpcost
				distance[k][j][i] = tmpcost

print("Matrice 3d:\n{}".format(distance))

#Stringification of probabilities
#-------------------------------------
str_dist = "[|";
for k in xrange(0,n_scenarios):
	for i in xrange(0,n_domains):
		for j in xrange(0,n_domains):
			str_dist += str(distance[k][i][j])+","
		str_dist = str_dist[:-1]
		str_dist = str_dist + ','
	str_dist += "|"
str_dist += "]"

print(len(str_dist))


# String to write in testFile output
out2 = "distance = " + str(str_dist)+";\n"

# TODO: CREATION OF PROBABILITIES ARRAY


#write in file
with open(testFile, 'w+') as outfile:
	outfile.write(out2)
