
import random
import os
import sys

n_domains = 15
testFile = 'test.dzn'


# Creation n_domains
#------------------------------------
domain_costs = [[0 for x in range(n_domains)] for y in range(n_domains)]

for x in range(n_domains):
	for y in range(n_domains):
		if x < y:
			tmpcost = random.randint(2, 8)
			domain_costs[x][y] = tmpcost
			domain_costs[y][x] = tmpcost


# Stringification of weights
#-------------------------------------
str_domain_link_weights = "[|";
for x in xrange(0,n_domains):
	for y in xrange(0,n_domains):
		str_domain_link_weights += str(domain_costs[x][y])+","
	str_domain_link_weights = str_domain_link_weights[:-1]
	str_domain_link_weights += "|"
str_domain_link_weights += "]"

# String to write in test
out = "domain_link_weights = " + str(str_domain_link_weights)+";\n"

# Open file in read mode and check if last line contains domain_link_weights
# If yes -> last line will be removed
with open(testFile, 'ar+') as outfile:
	# In lines there are all file lines
	lines = outfile.readlines()

	if 'domain_link_weights' in lines[-1]:

		outfile.seek(0, os.SEEK_END)
        #This code means the following code skips the very last character in the file -
        #i.e. in the case the last line is null we delete the last line
        #and the penultimate one
        pos = outfile.tell() - 1
        #Read each character in the file one at a time from the penultimate
        #character going backwards, searching for a newline character
        #If we find a new line, exit the search
        while pos > 0 and outfile.read(1) != "\n":
            pos -= 1
            outfile.seek(pos, os.SEEK_SET)

        #So long as we're not at the start of the file, delete all the characters ahead of this position
        if pos > 0:
            outfile.seek(pos, os.SEEK_SET)
            outfile.truncate()

	# Need write a new line character, after truncate, to format in right way the file
	outfile.write('\n')
	outfile.close()

# Append domain_link_weights to test.dzn file
with open(testFile, 'a+') as outfile:
    outfile.write(out)
