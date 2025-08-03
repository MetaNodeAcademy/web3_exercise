package main

import "fmt"

func twoSum(nums []int, target int) []int {
	numMap := make(map[int]int)
	for i, num := range nums {
		if j, ok := numMap[target-num]; ok {
			return []int{j, i}
		}
		numMap[num] = i
	}
	return nil
}
func main() {
	fmt.Println(twoSum([]int{2, 7, 11, 15}, 9))
}
