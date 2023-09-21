# # 1. Create a list named ‘myList’ that has the following elements: 10, 20, 30,
# # ‘apple’, True, 8.10:
# # a. Now in the ‘myList’, append these values: 30, 40
# # b. After that, reverse the elements of the ‘myList’ and store that in
# # ‘reversedList’

# print('\n1q\n')
# myList = [10,20,30,'apple',True,8.10]
# myList.append([30,40])
# print('\na')
# print(myList)
# reversedList = myList[::-1]
# print('\nb')
# print(reversedList)

# 2. Create a dictionary with key values as 1, 2, 3 and the values as ‘data’,
# ‘information’ and ‘text’:
samdictionary = {1:'data',2:'information',3:'test'}
print(samdictionary)

# b. Add ‘features’ in the dictionary
samdictionary[4] = 'feature'
print(samdictionary)
# c. Fetch the ‘data’ element from the dictionary and display it in the output
print(samdictionary[1])

# #3. Create a tuple and add these elements 1, 2, 3, apple, mango in my_tuple.
my_tuple = ()
my_tuple += (1,2,3,'apple','mango')
print(my_tuple)

# 4. Create another tuple named numeric_tuple consisting of only integer
# values 10, 20, 30, 40, 50:
numeric_tuple = (10,20,30,40,50)
# a. Find the minimum value from the numeric_tupl
min_value = min(numeric_tuple)
print(f'minimum value {min_value}')
# b. Concatenate my_tuple with numeric_tuple and store the result in r1
r1 = my_tuple + numeric_tuple
print("Concatenated tuple r1:",r1)
# c. Duplicate the tuple named my_tuple 2 times and store that in ‘newdupli’
newdupli = my_tuple*2
print("Duplicated tuple newdupli:",newdupli)

# 5. Create 2 sets with the names set1 and set2, where set1 contains
# {1,2,3,4,5} and set2 contains {2,3,7,6,1}
set1 = {1,2,3,4,5}
set2 = {2,3,7,6,1}

# Perform the below operation:
# a. set1 union set2
union = set1.union(set2)
print("Union of set1 and set2:", union)

# b. set1 intersection set2
intersection_result = set1.intersection(set2)
print("Intersection of set1 and set2:", intersection_result)

# c. set1 difference set2
difference_result = set1.difference(set2)
print("Difference of set1 and set2:", difference_result)


