const hre = require("hardhat");

async function main() {
  // Arc Testnet USDC address
  const USDC_ADDRESS = "0x3600000000000000000000000000000000000000";

  console.log("Deploying USDCPayment contract...");

  const USDCPayment = await hre.ethers.getContractFactory("USDCPayment");
  const payment = await USDCPayment.deploy(USDC_ADDRESS);

  await payment.waitForDeployment();

  const address = await payment.getAddress();
  console.log("✅ USDCPayment deployed to:", address);
}

main().catch(console.error);