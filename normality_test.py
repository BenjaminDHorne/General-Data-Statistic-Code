from scipy import stats
import csv
from collections import defaultdict

'''
Benjamin D. Horne

reads in a csv of features, in which the columns are each different features.

Checks the normality of each feature (given each data point is generated indpendent of others)

I use this to determine if I should use one-way ANOVA or a Mann Whitney U Test in showing difference between features.
'''

def is_float(n):
    try:
        cast = float(n)
        return True
    except:
        return False


if __name__ == '__main__':
    columns = defaultdict(list) # each value in each column is appended to a list
    
    file_to_open = ""
    print "small p values mean not from normal"
    with open(file_to_open) as data:
        reader = csv.DictReader(data) # read rows into a dictionary format
        for row in reader: # read a row as {column1: value1, column2: value2,...}
            for (k,v) in row.items(): # go over each column name and value
                if is_float(v) == True:
                    columns[k].append(float(v))

        for feature in columns:
            k2, p = stats.mstats.normaltest(columns[feature])
            print feature
            print k2, p
            if p <= 0.05:
                print "Normal"
            else:
                print "Not Normal"
            print
