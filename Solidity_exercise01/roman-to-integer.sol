// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInteger {
    function romanToInt(string memory s) public pure returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;
        uint prevValue = 0;

        for (uint i = 0; i < b.length; i++) {
            uint32 value = getRomanValue(b[i]);

            if (value > prevValue) {
                result += value - 2 * prevValue;
            } else {
                result += value;
            }
            prevValue = value;
        }
        return result;
    }

    function getRomanValue(bytes1 b) internal pure returns (uint32) {
        if (b == "I") return 1;
        if (b == "V") return 5;
        if (b == "X") return 10;
        if (b == "L") return 50;
        if (b == "C") return 100;
        if (b == "D") return 500;
        if (b == "M") return 1000;
        revert("Invalid Roman numeral");
    }
}
