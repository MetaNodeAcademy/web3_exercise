//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    // 修复类型不匹配问题：将uint[]改为address[]
    address[] public Candidates;

    // 存储候选人的得票数
    mapping(address => uint256) public candidateVotes;
    // 添加已投票记录映射
    mapping(address => bool) public hasVoted;
    // 添加合约所有者
    address public owner;

    // 添加投票事件
    event VoteCast(
        address indexed voter,
        address indexed candidate,
        uint256 timestamp
    );
    // 添加候选人事件
    event CandidateAdded(address indexed candidate, uint256 timestamp);
    // 添加重置事件
    event VotesReset(uint256 timestamp);

    // 构造函数设置所有者
    constructor() {
        owner = msg.sender;
    }

    // 添加候选人函数
    function addCandidate(address candidate) public {
        require(msg.sender == owner, "Only owner can add candidates");
        require(candidate != address(0), "Invalid candidate address");
        // 检查候选人是否已存在
        for (uint i = 0; i < Candidates.length; i++) {
            require(Candidates[i] != candidate, "Candidate already exists");
        }
        Candidates.push(candidate);
        emit CandidateAdded(candidate, block.timestamp);
    }

    // 允许用户投票给某个候选人
    function vote(address candidate) public {
        // 检查是否已投票
        require(!hasVoted[msg.sender], "You have already voted");
        // 检查候选人是否有效
        bool isValidCandidate = false;
        for (uint i = 0; i < Candidates.length; i++) {
            if (Candidates[i] == candidate) {
                isValidCandidate = true;
                break;
            }
        }
        require(isValidCandidate, "Invalid candidate");

        candidateVotes[candidate]++;
        hasVoted[msg.sender] = true;
        emit VoteCast(msg.sender, candidate, block.timestamp);
    }

    // 返回某个候选人的得票数
    function getVotes(address candidate) public view returns (uint256) {
        return candidateVotes[candidate];
    }

    // 重置所有候选人的得票数
    function resetVotes() public {
        require(msg.sender == owner, "Only owner can reset votes");
        for (uint i = 0; i < Candidates.length; i++) {
            candidateVotes[Candidates[i]] = 0;
        }
        // 重置投票记录
        // 注意：在实际应用中，可能需要更高效的方式来重置投票记录
        // 此处为简化，仅重置候选人票数
        emit VotesReset(block.timestamp);
    }
}
