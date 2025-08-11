// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {
    function reverse(string memory input) public pure returns (string memory) {
        bytes memory inputBytes = bytes(input);
        bytes memory result = new bytes(inputBytes.length);
        for (uint i = 0; i < inputBytes.length; i++) {
            result[i] = inputBytes[inputBytes.length - 1 - i];
        }
        return string(result);
    }
}
