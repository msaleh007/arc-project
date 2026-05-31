// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SimpleStaking
 * @dev A basic staking contract where users stake an ERC-20 token
 *      and earn time-based rewards. Built for testnet learning/activity.
 * @notice Deploy with the address of an ERC-20 token (e.g. your SALEH token).
 */

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SimpleStaking {
    // ====== State ======
    IERC20 public stakingToken;
    address public owner;

    // Reward: 1% of staked amount per day (simple, for testnet)
    uint256 public constant REWARD_RATE_PER_DAY = 1; // 1%
    uint256 public constant SECONDS_PER_DAY = 86400;

    struct StakeInfo {
        uint256 amount;       // how many tokens staked
        uint256 since;        // timestamp when staked
        uint256 claimed;      // total rewards claimed
    }

    mapping(address => StakeInfo) public stakes;
    uint256 public totalStaked;

    // ====== Events ======
    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 reward);

    // ====== Constructor ======
    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
        owner = msg.sender;
    }

    // ====== Core Functions ======

    /// @notice Stake tokens. User must approve this contract first.
    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0");

        // If already staking, claim pending rewards first
        if (stakes[msg.sender].amount > 0) {
            _claimReward();
        }

        stakingToken.transferFrom(msg.sender, address(this), amount);

        stakes[msg.sender].amount += amount;
        stakes[msg.sender].since = block.timestamp;
        totalStaked += amount;

        emit Staked(msg.sender, amount);
    }

    /// @notice Unstake all tokens and claim rewards.
    function unstake() external {
        StakeInfo storage info = stakes[msg.sender];
        require(info.amount > 0, "Nothing staked");

        uint256 amount = info.amount;
        _claimReward();

        info.amount = 0;
        info.since = 0;
        totalStaked -= amount;

        stakingToken.transfer(msg.sender, amount);

        emit Unstaked(msg.sender, amount);
    }

    /// @notice Claim accumulated rewards without unstaking.
    function claimReward() external {
        require(stakes[msg.sender].amount > 0, "Nothing staked");
        _claimReward();
    }

    function _claimReward() internal {
        uint256 reward = pendingReward(msg.sender);
        if (reward > 0) {
            stakes[msg.sender].since = block.timestamp;
            stakes[msg.sender].claimed += reward;
            // Reward paid from contract's token balance (owner should fund it)
            stakingToken.transfer(msg.sender, reward);
            emit RewardClaimed(msg.sender, reward);
        }
    }

    // ====== View Functions ======

    /// @notice Calculate pending (unclaimed) reward for a user.
    function pendingReward(address user) public view returns (uint256) {
        StakeInfo memory info = stakes[user];
        if (info.amount == 0) return 0;

        uint256 timeStaked = block.timestamp - info.since;
        // reward = amount * rate% * (timeStaked / 1 day)
        uint256 reward = (info.amount * REWARD_RATE_PER_DAY * timeStaked)
                         / (100 * SECONDS_PER_DAY);
        return reward;
    }

    /// @notice Get a user's staked amount.
    function stakedBalance(address user) external view returns (uint256) {
        return stakes[user].amount;
    }

    /// @notice Owner can fund the contract with reward tokens.
    function fundRewards(uint256 amount) external {
        require(msg.sender == owner, "Only owner");
        stakingToken.transferFrom(msg.sender, address(this), amount);
    }
}
