package main

import "fmt"

func singleNumber(arr []int) int {
	result := 0
	for _, num := range arr {
		result ^= num
	}
	return result
}

func main() {
	arr := []int{2, 2, 1, 1, 3}
	result := singleNumber(arr)
	fmt.Println(result)
}
