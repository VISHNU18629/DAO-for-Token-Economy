// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DAOTokenEconomy {
    address public owner;
    string public projectTitle = "DAO for Token Economy";
    string public projectDescription = "Develop a DAO that controls the issuance and distribution of a projects tokens.";

    mapping(address => uint256) public tokenBalances;
    uint256 public totalSupply;

    event TokensIssued(address indexed to, uint256 amount);
    event TokensDistributed(address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function issueTokens(uint256 _amount) external onlyOwner {
        totalSupply += _amount;
        tokenBalances[owner] += _amount;
        emit TokensIssued(owner, _amount);
    }

    function distributeTokens(address _to, uint256 _amount) external onlyOwner {
        require(tokenBalances[owner] >= _amount, "Insufficient tokens to distribute");
        tokenBalances[owner] -= _amount;
        tokenBalances[_to] += _amount;
        emit TokensDistributed(_to, _amount);
    }

    function checkBalance(address _account) external view returns (uint256) {
        return tokenBalances[_account];
    }
} 
