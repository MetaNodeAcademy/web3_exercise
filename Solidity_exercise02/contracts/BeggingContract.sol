// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

 
contract BeggingContract {
    // The address of the contract owner
    address public owner; 

    // Mapping from a donor's address to their total donated amount
    mapping(address => uint256) private _donations;

    // Event to be emitted upon a successful donation
    event Donation(address indexed donor, uint256 amount);

   
    constructor() {
        owner = msg.sender;
    }

  
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

  
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero.");
        _donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

  
    /**
     * @dev Allows the contract owner to withdraw a specific amount of funds.
     * @param amount The amount in wei to withdraw.
     */
    function withdrawAmount(uint256 amount) public onlyOwner {
        require(amount > 0, "Withdraw amount must be greater than zero.");
        require(address(this).balance >= amount, "Insufficient balance for the requested amount.");

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Withdrawal failed.");
    }

    /**
     * @dev Allows the contract owner to withdraw the entire balance of the contract.
     */
    function withdrawAll() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw.");
 
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdrawal failed.");
    }


    function getDonation(address donor) public view returns (uint256) {
        return _donations[donor];
    }
} 
