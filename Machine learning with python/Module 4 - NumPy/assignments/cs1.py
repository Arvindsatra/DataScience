import numpy as np
# 1. Create a function that takes dimensions as tuples e.g. (3, 3) and a numeric
# value and returns a NumPy array of the given dimension filled with the
# given value e.g.: solve((3, 3), 5) will return
# [
# [5, 5, 5],
# [5, 5, 5],
# [5, 5, 5]
# ]

def solve(dimensions, value):
    rows,cols = dimensions
    array = np.full((rows,cols),value)
    return array

# 2. Create a method that takes n NumPy arrays of the same dimensions,
# sums them and returns the answer

def sum_arrays(arrays):
    if len(arrays) == 0:
        raise ValueError("list of array is empty")
    
    sumed = np.zeros_like(arrays[0])
    for array in arrays:
        if array.shape != sumed.shape:
            raise ValueError("ALL ARRAY MUST HAVE THE SAME DIMENSIONS")
        sumed += array

    return sumed

# 3. Given a 2 D Array of N X M Dimension, write a function that accepts this
# array as well as two numbers N and M. The method should return the
# top-left N X M sub matrix, e.g:
# [
# [1, 2, 3],
# [4, 5, 6],
# [7, 8, 9],
# ]
# top_left_sub_matrix (matrix, 2, 2) -> should return:
# [
# [1, 2]
# [4, 5]
# ]

def top_left_sub_matrix(matrix, N, M):
    if N <= 0 or M <= 0:
        raise ValueError("N and M must be positive integers")

    if matrix.shape[0] < N or matrix.shape[1] < M:
        raise ValueError("Matrix dimensions are smaller than N x M")

    sub_matrix = matrix[:N,:M]
    return sub_matrix

# 4. Given a 2 D Array of N X M Dimension, write a function that accepts this
# array as well as two numbers N and M. The method should return the
# bottom-right N X M sub matrix, e.g:
# [
# [1, 2, 3],
# [4, 5, 6],
# [7, 8, 9],
# ]
# sub_matrix(matrix, 1, 1) -> should return : (Keep in mind these arrays are
# zero indexed)
# [
# [5, 6]
# [8, 9]
# ]

def bottom_right(matrix,N,M):
    sub_matrix = matrix[N:,M:]
    return sub_matrix

# 5. Given a 1 D NumPy Array. Write a function that accepts this array as
# parameters. The method should return a dictionary with 'mean' and
# 'std_dev' as key and array's mean and array's standard deviation as
# values:
# [1, 1, 1]
# solution(arr) -> should return :
# {'mean': 1.0, 'std_dev': 0.0}

def solution(arr):
    if not isinstance(arr,np.ndarray) or arr.ndim != 1:
        raise ValueError("Input must be 1d numpy array")
    mean = np.mean(arr)
    std_dev = np.std(arr)
    result = {'mean':mean,'std_dev':std_dev}
    return result


if __name__ == '__main__':
    print('\nfor task1')
    row = int(input("enter the number of rows: "))
    col = int(input("enter the number of columns: "))
    val = int(input("enter the value for the array: "))
    dimensions = (row, col)
    result = solve(dimensions, val)
    print(result)
    
    print('\nfor task2')
    rows = int(input("Enter number of rows: "))
    cols = int(input("Enter number of columns: "))
    num_arrays = int(input("enter number of arrays: "))
    arrays = []

    for i in range(num_arrays):
            print(f"enter values for array {i+1} ({rows*cols} values): ")
            values = list(map(int,input().split()))
            array = np.array(values).reshape(rows, cols)
            arrays.append(array)
    results = sum_arrays(arrays)
    print('sum of arrays')
    print(results)

    # Example usage for task 3

    matrix = np.array([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ])
    N = 2
    M = 2

    result = top_left_sub_matrix(matrix, N, M)
    print(f"for task 3 original matrix:\n {matrix} ")
    print(f"after using function:\n {result}")
    
    # Example usage for tast 4


    matrix = np.array([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ])
    N = 1
    M = 1

    result = bottom_right(matrix, N, M)
    print(f"for task 4 original matrix:\n {matrix} ")
    print(f"after using function:\n {result}")
    
    # Example usage for tast 5
    arr = np.array([1, 1, 1])
    result_dict = solution(arr)
    print(result_dict)