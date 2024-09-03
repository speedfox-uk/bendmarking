package main

import "fmt"

{{{mat}}}

var matSize = {{{size}}}

func getSubMatrix(matrix [][]int, rmCol int) [][]int{ 
	newLen := len(matrix) -1;
        newMatrix := make([][]int, newLen);
	for i:=1; i<len(matrix);i++{
		row := matrix[i];
		newRow := make([]int, newLen)
		newIdx := 0
		for j:=0; j<len(row); j++{
			if j!= rmCol{
				newRow[newIdx] = row[j]
				newIdx++
			}
		}
		newMatrix[i-1] = newRow
	}
	return newMatrix;
}

func getDet(matrix [][]int,) int{
	if len(matrix) == 1{
		return matrix[0][0];
	}

        total := 0;
	sign := 1;
	for i:=0;i<len(matrix); i++{
		subMatrix := getSubMatrix(matrix, i)
                cofactor := sign * matrix[0][i] * getDet(subMatrix);
		total += cofactor;
		sign = sign * -1;
	}
        
	return total;

}

func main() {
	finalDet := getDet(matrix)
	fmt.Println("Got det ", finalDet);
}
