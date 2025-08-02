package main

import "testing"

func TestIsValid(t *testing.T) {
	tests := []struct {
		name     string
		input    string
		expected bool
	}{
		{"empty string", "", true},
		{"simple valid parentheses", "()", true},
		{"multiple valid parentheses", "()[]{}", true},
		{"nested valid parentheses", "{[()]}", true},
		{"complex valid parentheses", "{[]}()", true},
		{"simple invalid parentheses", "(]", false},
		{"mismatched parentheses", "([)]", false},
		{"missing closing", "(", false},
		{"missing opening", ")", false},
		{"complex invalid", "([)]", false},
		{"nested invalid", "{[}]", false},
		{"only opening", "(((", false},
		{"only closing", ")))", false},
		{"valid long sequence", "({[]})[()]", true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := isValid(tt.input)
			if result != tt.expected {
				t.Errorf("isValid(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}
