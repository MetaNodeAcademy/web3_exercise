package main

import "fmt"

func longestCommonPrefix(strs []string) string {
	if len(strs) == 0 {
		return ""
	}

	prefix := strs[0]
	for _, str := range strs {
		if len(str) < len(prefix) {
			prefix = prefix[:len(str)]
		}
		for i := 0; i < len(prefix) && i < len(str); i++ {
			if prefix[i] != str[i] {
				prefix = prefix[:i]
				break
			}
		}
	}
	return prefix
}

func main() {
	fmt.Println(longestCommonPrefix([]string{"ab", "a"}))
	fmt.Println(longestCommonPrefix([]string{"dog", "racecar", "car"}))
}
