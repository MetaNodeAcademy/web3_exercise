package main

import "fmt"

func isPalindrome(x int) bool {
	reverted := 0
	original := x
	for x > 0 {
		reverted = reverted*10 + x%10
		x /= 10
	}
	return original == reverted
}

func main() {
	fmt.Println(isPalindrome(121))
}
