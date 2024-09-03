package main

import (
	"fmt"
	"sync"
)

{{{mat}}}

var matSize = {{{size}}}

// Function to create a submatrix by removing a specific column
func getSubMatrix(matrix [][]int, rmCol int) [][]int {
	newLen := len(matrix) - 1
	newMatrix := make([][]int, newLen)
	for i := 1; i < len(matrix); i++ {
		row := matrix[i]
		newRow := make([]int, newLen)
		newIdx := 0
		for j := 0; j < len(row); j++ {
			if j != rmCol {
				newRow[newIdx] = row[j]
				newIdx++
			}
		}
		newMatrix[i-1] = newRow
	}
	return newMatrix
}

// Single-threaded function to calculate the determinant
func getDet(matrix [][]int) int {
	if len(matrix) == 1 {
		return matrix[0][0]
	}

	total := 0
	sign := 1

	for i := 0; i < len(matrix); i++ {
		subMatrix := getSubMatrix(matrix, i)
		cofactor := sign * matrix[0][i] * getDet(subMatrix)
		total += cofactor
		sign = -sign
	}

	return total
}

// Parallelized computation of the determinant for the first matrix
func getParallelDet(matrix [][]int) int {
	if len(matrix) == 1 {
		return matrix[0][0]
	}

	total := 0
	sign := 1
	results := make(chan int, matSize)
	var wg sync.WaitGroup

	for i := 0; i < len(matrix); i++ {
		wg.Add(1)
		go func(col int, sign int) {
			defer wg.Done()
			subMatrix := getSubMatrix(matrix, col)
			cofactor := sign * matrix[0][col] * getDet(subMatrix) // Single-threaded calculation for submatrices
			results <- cofactor
		}(i, sign)
		sign = -sign
	}

	// Close the results channel after all goroutines are done
	go func() {
		wg.Wait()
		close(results)
	}()

	// Collect all results
	for result := range results {
		total += result
	}

	return total
}

func main() {
	finalDet := getParallelDet(matrix)
	fmt.Println("Got det ", finalDet)
}

