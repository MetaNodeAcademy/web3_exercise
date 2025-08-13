// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract BinarySearch {
    /**
     * @dev 在有序数组中使用二分查找查找目标值
     * @param arr 有序数组
     * @param target 目标值
     * @return 索引，如果未找到则返回 -1
     */
    function binarySearch(uint[] memory arr, uint target) public pure returns (int) {
        uint left = 0;
        uint right = arr.length - 1;
        // 二分查找算法
        while (left <= right) {
            uint mid = left + (right - left) / 2;

            if (arr[mid] == target) {
                return int(mid); // 找到目标值，返回索引
            } else if (arr[mid] < target) {
                left = mid + 1; // 目标值在右半部分
            } else {
                right = mid - 1; // 目标值在左半部分
            }
        }

        return -1; // 未找到目标值，返回 -1
    }
}