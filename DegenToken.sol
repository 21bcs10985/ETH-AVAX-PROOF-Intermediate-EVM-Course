// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DegenToken {
    string public name = "Degen";
    string public symbol = "DGN";
    uint public totalSupply;
    address public owner;

    mapping(address => uint) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint Amount);
    event Mint(address indexed to, uint Amount);
    event Burn(address indexed from, uint Amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    constructor(uint initialSupply) {
        totalSupply = initialSupply;
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }


    function transfer(address to, uint Amount) external returns (bool) {
        require(to != address(0), "Invalid recipient address.");
        require(Amount <= balanceOf[msg.sender], "Insufficient balance.");

        balanceOf[msg.sender] -= Amount;
        balanceOf[to] += Amount;
        emit Transfer(msg.sender, to, Amount);
        return true;
    }


    function mint(address to, uint Amount) external onlyOwner {
        require(to != address(0), "Invalid recipient address.");
        totalSupply += Amount;
        balanceOf[to] += Amount;
        emit Mint(to, Amount);
    }

    function burn(uint Amount) external {
        require(Amount <= balanceOf[msg.sender], "Insufficient balance.");

        balanceOf[msg.sender] -= Amount;
        totalSupply -= Amount;
        emit Burn(msg.sender, Amount);
    }

    function transferFrom(address from, address to, uint Amount) external returns (bool) {
        require(to != address(0), "Invalid recipient address.");
        require(Amount <= balanceOf[from], "Insufficient balance.");
        balanceOf[from] -= Amount;
        balanceOf[to] += Amount;
        emit Transfer(from, to, Amount);
        return true;
    }
}
