// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HarshDeoRavi is ERC20 {
    address public owner;
    uint public TotalSupply;

    constructor(string memory TokenName, string memory TokenSymbol) ERC20(TokenName, TokenSymbol) {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    mapping (address => uint) public AvailableBalance;

    // mint function
    function mint(address WalletAddress, uint Amount) public  onlyOwner{
       AvailableBalance[WalletAddress] = AvailableBalance[WalletAddress] + Amount;
        TotalSupply = TotalSupply + Amount;
    }

    // burn function
     function burn(address WalletAddress, uint Amount) public {
        if (AvailableBalance[WalletAddress] >= Amount) {
            AvailableBalance[WalletAddress] = AvailableBalance[WalletAddress] - Amount;
            TotalSupply = TotalSupply - Amount;
        } 
    }
}
