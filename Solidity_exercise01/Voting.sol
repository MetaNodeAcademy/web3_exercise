// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    uint[] public Candidates;
    mapping(address => uint) public CandidateToVoteCount;

    function vote(address candidate) public {
        CandidateToVoteCount[candidate]++;
    }

    function getVotes(address candidate) public view returns (uint) {
        return CandidateToVoteCount[candidate];
    }

    function resetVotes(address[] calldata candidates) public {
        for (uint i = 0; i < candidates.length; i++) {
            CandidateToVoteCount[candidates[i]] = 0;
        }
    }
}
