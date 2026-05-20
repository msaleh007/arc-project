const hre = require("hardhat");

async function main() {
  console.log("🚀 Deploying ArcSaleh Token...");
  
  const ArcToken = await hre.ethers.getContractFactory("ArcToken");
  const token = await ArcToken.deploy();
  await token.waitForDeployment();
  
  const address = await token.getAddress();
  console.log("✅ Token deployed to:", address);
  console.log("🔗 View: https://testnet.arcscan.app/address/" + address);
}

main().catch(console.error);