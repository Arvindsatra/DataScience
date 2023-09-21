import numpy as np

# 1. Create a 3x3 matrix array with values ranging from 2 to 10.

matrix = np.arange(2,11).reshape(3,3)

print(matrix)

# 2. Create a NumPy array having user input values and convert the integer
# type to the float type of the elements of the array. For instance: Original
# array [1, 2, 3, 4] Array converted to a float type: [ 1. 2. 3. 4.]

input_values = input('Enter array elements seperated by spaces: ').split()
array = np.array(input_values, dtype=int)
float_array = array.astype(float)
print("Original array:", array)
print("Array converted to a float type:", float_array)

# 3. Write a NumPy program to append values to the end of an array. For
# instance: Original array: [10, 20, 30] . After that, append values to the end
# of the array: [10 20 30 40 50 60 70 80 90]

original_array = np.array([10,20,30])
values_to_append = np.array([40,50,60,70,80,90])
appended_array = np.append(original_array,values_to_append)
# Print the results
print("Original array:", original_array)
print("Array after appending values:", appended_array)

# 4. Create two NumPy arrays and add the elements of both the arrays and
# store the result in sumArray

array1 = np.array([1,2,3])
array2 = np.array([4,5,6])
sumArray = array1+array2

print("Task 4:")
print("array1:", array1)
print("array2:", array2)
print("sumArray:", sumArray)

# 5. Create a 3x3 array having values from 10-90 (interval of 10) and store that
# in array1

array1 = np.arange(10,100,10).reshape(3,3)

print("\nTask 5:")
print("array1:")
print(array1)

# Perform the following tasks:
# a. Extract the 1st row from the array

first_row = array1[0,:]
print("1st row:", first_row)

# b. Extract the last element from the array

last_element = array1[-1,-1]
print("Last element:", last_element)