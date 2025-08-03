package main

import "sort"

func merge(intervals [][]int) [][]int {
	if len(intervals) == 0 {
		return intervals
	}

	// Sort intervals by start time
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	result := [][]int{intervals[0]}

	for i := 1; i < len(intervals); i++ {
		last := result[len(result)-1]
		current := intervals[i]

		if current[0] <= last[1] { // Overlapping intervals
			last[1] = max(last[1], current[1])
		} else {
			result = append(result, current)
		}
	}

	return result
}

func main() {
	// 测试用例1: [[1,3],[2,6],[8,10],[15,18]] -> [[1,6],[8,10],[15,18]]
	intervals1 := [][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}}
	result1 := merge(intervals1)
	println("Test 1:")
	for _, interval := range result1 {
		println(interval[0], interval[1])
	}

	// 测试用例2: [[1,4],[4,5]] -> [[1,5]]
	intervals2 := [][]int{{1, 4}, {4, 5}}
	result2 := merge(intervals2)
	println("Test 2:")
	for _, interval := range result2 {
		println(interval[0], interval[1])
	}

	// 测试用例3: [[1,4],[0,4]] -> [[0,4]]
	intervals3 := [][]int{{1, 4}, {0, 4}}
	result3 := merge(intervals3)
	println("Test 3:")
	for _, interval := range result3 {
		println(interval[0], interval[1])
	}

	// 测试用例4: [[1,4],[0,0]] -> [[0,0],[1,4]]
	intervals4 := [][]int{{1, 4}, {0, 0}}
	result4 := merge(intervals4)
	println("Test 4:")
	for _, interval := range result4 {
		println(interval[0], interval[1])
	}
}
