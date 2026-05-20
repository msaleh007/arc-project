// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title ArcTestContract
 * @dev Simple contract to deploy on Arc testnet for points/activity
 */
contract ArcTestContract {
    address public owner;
    string public projectName;
    uint256 public deployedAt;
    uint256 public interactionCount;

    mapping(address => uint256) public userInteractions;
    mapping(address => bool) public registeredUsers;
    address[] public users;

    event UserRegistered(address indexed user, uint256 timestamp);
    event Interaction(address indexed user, uint256 count);

    constructor(string memory _projectName) {
        owner = msg.sender;
        projectName = _projectName;
        deployedAt = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Users can register themselves — generates on-chain activity
    function register() external {
        require(!registeredUsers[msg.sender], "Already registered");
        registeredUsers[msg.sender] = true;
        users.push(msg.sender);
        emit UserRegistered(msg.sender, block.timestamp);
    }

    // Any interaction — good for on-chain activity tracking
    function interact() external {
        require(registeredUsers[msg.sender], "Register first");
        userInteractions[msg.sender]++;
        interactionCount++;
        emit Interaction(msg.sender, userInteractions[msg.sender]);
    }

    // View total registered users
    function totalUsers() external view returns (uint256) {
        return users.length;
    }

    // Check if address is registered
    function isRegistered(address _user) external view returns (bool) {
        return registeredUsers[_user];
    }

    // Owner can update project name
    function updateProjectName(string memory _newName) external onlyOwner {
        projectName = _newName;
    }
}
