// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    /**
     * @dev 合并两个有序数组为一个有序数组
     * @param arr1 第一个有序数组
     * @param arr2 第二个有序数组
     * @return 合并后的有序数组
     */
    function mergeSortedArrays(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint i = 0; // arr1 的索引
        uint j = 0; // arr2 的索引
        uint k = 0; // 合并后数组的索引
        uint[] memory merged = new uint[](arr1.length + arr2.length);

        // 比较两个数组的元素，将较小的元素放入合并后的数组
        while (i < arr1.length && j < arr2.length) {
            if (arr1[i] < arr2[j]) {
                merged[k++] = arr1[i++];
            } else {
                merged[k++] = arr2[j++];
            }
        }

        // 将 arr1 中剩余的元素放入合并后的数组
        while (i < arr1.length) {
            merged[k++] = arr1[i++];
        }

        // 将 arr2 中剩余的元素放入合并后的数组
        while (j < arr2.length) {
            merged[k++] = arr2[j++];
        }

        return merged;
    }
}