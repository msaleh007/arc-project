require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.24",
  networks: {
    giwa_testnet: {
      url: "https://sepolia-rpc.giwa.io",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 91342,
    },
    arc_testnet: {
      url: "https://rpc.testnet.arc.network",
      chainId: 5042002,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    robinhood_testnet: {
      url: "https://docs-demo.robinhood-testnet.quiknode.pro/",
      chainId: 46630,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
};