import random
import os
import progress_bar as pb

n_domains = 15
n_scenarios = 3 #to simplify
testFile = 'scenarios_data.dzn'

#TODO definire tutte le funzioni e richiamarle sotto prima della strighification , come ha fatto tong


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


#Creation of 3d matrix containing probabilities. In each matrix there is a probability values.
matrix_prob = [[0 for i in range(n_domains*n_domains)] for y in range(n_scenarios)]
array_prob = [0 for i in range(n_scenarios)]
for i in range(n_scenarios):
	prob = round(random.uniform(0.1, 1.0),2)
	array_prob[i] = prob
	for j in range(n_domains*n_domains):
		matrix_prob[i][j] = prob


#Stringification of distance
#-------------------------------------
str_dist = "[|"
for k in xrange(0,n_scenarios):
	for i in xrange(0,n_domains):
		for j in xrange(0,n_domains):
			str_dist += str(distance[k][i][j])+","
		str_dist = str_dist[:-1]
		str_dist = str_dist + ','
	str_dist = str_dist[:-1]
	str_dist += "|"
str_dist += "]"

#Stringification of array probabilities
str_array_prob = "["
for i in range(n_scenarios):
	str_array_prob += str(array_prob[i])+","
str_array_prob = str_array_prob[:-1]
str_array_prob += "]"


#Stringification of matrix probabilities
#-------------------------------------
str_matrix_prob = "[|"
for i in xrange(0,n_scenarios):
	for j in range(0,n_domains*n_domains):
		str_matrix_prob += str(matrix_prob[i][j])+","
	str_matrix_prob = str_matrix_prob[:-1]
	str_matrix_prob += "|"
str_matrix_prob += "]"

# String to write in testFile output

out = "distance = " + str(str_dist)+";\n"
out += "matrix_prob = " + str(str_matrix_prob)+";\n"
out += "array_prob = " + str(array_prob)+";\n"

print("Stiamo \"uscendo\" delle configurazioni per te...")
pb.loading(0.1)

#write in file
with open(testFile, 'w+') as outfile:
	outfile.write(out)