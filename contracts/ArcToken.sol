// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ArcToken is ERC20 {
    constructor() ERC20("ArcSaleh Token", "AST") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}