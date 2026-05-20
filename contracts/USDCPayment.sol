// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract USDCPayment {
    address public owner;
    IERC20 public usdc;
    
    uint256 public totalPayments;
    
    event PaymentSent(address indexed from, address indexed to, uint256 amount);
    
    constructor(address _usdcAddress) {
        owner = msg.sender;
        usdc = IERC20(_usdcAddress);
    }
    
    function sendPayment(address to, uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(usdc.transferFrom(msg.sender, to, amount), "Transfer failed");
        totalPayments++;
        emit PaymentSent(msg.sender, to, amount);
    }
    
    function getBalance(address account) external view returns (uint256) {
        return usdc.balanceOf(account);
    }
}