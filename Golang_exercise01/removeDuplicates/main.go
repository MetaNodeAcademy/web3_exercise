package main

import "fmt"

func removeDuplicates(nums []int) int {
	if len(nums) == 0 {
		return 0
	}
	i := 0
	for j := 1; j < len(nums); j++ {
		if nums[j] != nums[i] {
			i++
			nums[i] = nums[j]
		}
	}
	return i + 1
}

func main() {
	nums := []int{1, 2, 2, 3, 4, 4, 5}
	newLength := removeDuplicates(nums)
	fmt.Println("New length:", newLength)
	fmt.Println("Modified array:", nums[:newLength])
}
