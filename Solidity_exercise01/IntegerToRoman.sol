// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerToRoman { 
    function intToRoman(uint num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "Number out of range");

        // 千、百、十、个对应罗马片段查表
        string[4] memory thousands = ["", "M", "MM", "MMM"];
        string[10] memory hundreds  = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        string[10] memory tens      = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        string[10] memory ones      = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];

        uint t = num / 1000;
        uint h = (num / 100) % 10;
        uint te = (num / 10) % 10;
        uint o = num % 10;

        return string(abi.encodePacked(
            thousands[t],
            hundreds[h],
            tens[te],
            ones[o]
        ));
    }
}