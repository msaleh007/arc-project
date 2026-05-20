const { ethers } = require("ethers");
const fs = require("fs");
require("dotenv").config();

async function main() {
  const provider = new ethers.JsonRpcProvider("https://rpc.testnet.arc.network");
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  console.log("Deploying from:", wallet.address);

  const abi = JSON.parse(fs.readFileSync("./artifacts/contracts/USDCPayment.sol/USDCPayment.json")).abi;
  const bytecode = JSON.parse(fs.readFileSync("./artifacts/contracts/USDCPayment.sol/USDCPayment.json")).bytecode;

  const factory = new ethers.ContractFactory(abi, bytecode, wallet);
  
  const USDC = "0x3600000000000000000000000000000000000000";
  
  console.log("Deploying USDCPayment...");
  const contract = await factory.deploy(USDC);
  
  console.log("TX Hash:", contract.deploymentTransaction().hash);
  await contract.waitForDeployment();
  
  console.log("✅ Deployed to:", await contract.getAddress());
}

main().catch(console.error);