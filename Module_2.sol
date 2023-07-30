// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MyBank {
    uint public balance;
    address public owner;
    mapping(address => uint) public AvailableBalance;


     modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can Withdraw.");
        _;
    }

    constructor(uint initialSupply) {
        balance = initialSupply;
        AvailableBalance[msg.sender] = balance;
        owner = msg.sender;
    }
    function CheckBalance () view public returns (uint){
        return balance;
    }  

    function Deposite(address WalletAddress, uint Amount) public {
       AvailableBalance[WalletAddress] = AvailableBalance[WalletAddress] + Amount;
        balance = balance + Amount;
    }

     function Withdraw(address WalletAddress, uint Amount) public onlyOwner{
        if (AvailableBalance[WalletAddress] >= Amount) {
            AvailableBalance[WalletAddress] = AvailableBalance[WalletAddress] - Amount;
            balance = balance - Amount;
        } 
    }
}
