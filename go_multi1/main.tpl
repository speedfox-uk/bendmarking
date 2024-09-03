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

func getCofactor(matrix [][]int, col int, sign int, chnl chan<- int){
	subMatrix := getSubMatrix(matrix, col)
	cofactor := sign * matrix[0][col] * getDet(subMatrix);
	chnl <- cofactor;
}

func getDet(matrix [][]int,) int{
	if len(matrix) == 1{
		return matrix[0][0];
	}

        total := 0;
	results := make(chan int)
	numCfs := len(matrix)
	for i:=0;i<numCfs; i++{
		sign := 1
		if (i%2) != 0{
			sign = -1
		}
		go getCofactor(matrix, i, sign, results)
		
	}

	for i:=0;i<numCfs; i++{
		total += <- results
	}

        
	return total;

}

func main() {
	finalDet := getDet(matrix)
	fmt.Println("Got det ", finalDet);
}
