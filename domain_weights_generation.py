import random
import os
import progress_bar as pb

n_domains = 15
n_scenarios = 10 #to simplify
testFile = 'scenarios_data.dzn'

#Creation of 3d structure containing the distance matrix (domain_link_weights configurations)
def weight_configuration_matrix():
	distance = [[[0 for i in range(n_domains)] for y in range(n_domains)] for k in range(n_scenarios)]
	#distance = [[0 for j in range(n_domains)] for i in range(n_domains)] for k in range(n_scenarios)]
	for k in range(n_scenarios):
		for j in range(n_domains):
			for i in range(n_domains):
				if i < j:
					tmpcost = random.randint(2, 8)
					distance[k][i][j] = tmpcost
					distance[k][j][i] = tmpcost
	return distance


#Creation of 3d matrix containing probabilities. In each matrix there is a probability values.
def probability_distribution():
	matrix_prob = [[0 for i in range(n_domains*n_domains)] for y in range(n_scenarios)]
	array_prob = [1 for i in range(n_scenarios)]

	#Creation of uniform array
	array1 = [0 for i in range(10)]
	for i in range(10):
	    array1[i] = random.uniform(0.1,1.0);

	#Creation of distributional array, dividing by sum each element of array 1
	somma = sum(array1)
	for i in range(10):
	    array1[i] = array1[i]/somma

	for i in range(n_scenarios):
		for j in range(n_domains*n_domains):
			matrix_prob[i][j] = array1[i]
	return matrix_prob, array_prob

#-------------------------------------
# Calling functions

scenarios_matrix = weight_configuration_matrix()
probability_matrix, arr = probability_distribution()


#-------------------------------------
#Stringification of distance

str_dist = "[|"
for k in xrange(0,n_scenarios):
	for i in xrange(0,n_domains):
		for j in xrange(0,n_domains):
			str_dist += str(scenarios_matrix[k][i][j])+","
		str_dist = str_dist[:-1]
		str_dist = str_dist + ','
	str_dist = str_dist[:-1]
	str_dist += "|"
str_dist += "]"

#Stringification of array probabilities
str_array_prob = "["
for i in range(n_scenarios):
	str_array_prob += str(arr[i])+","
str_array_prob = str_array_prob[:-1]
str_array_prob += "]"


#Stringification of matrix probabilities
str_matrix_prob = "[|"
for i in xrange(0,n_scenarios):
	for j in range(0,n_domains*n_domains):
		str_matrix_prob += str(probability_matrix[i][j])+","
	str_matrix_prob = str_matrix_prob[:-1]
	str_matrix_prob += "|"
str_matrix_prob += "]"

#-------------------------------------

# String to write in testFile output
out = "n_scenarios = " + str(n_scenarios)+";\n"
out += "distance = " + str(str_dist)+";\n"
out += "matrix_prob = " + str(str_matrix_prob)+";\n"
out += "arr = " + str(str_array_prob)+";\n"

print("Stiamo \"uscendo\" delle configurazioni per te...")
pb.loading(0.05)

#write in file
with open(testFile, 'w+') as outfile:
	outfile.write(out)
