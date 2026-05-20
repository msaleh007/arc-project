const hre = require("hardhat");

async function main() {
  console.log("🚀 Deploying to Arc Testnet...");
  console.log("Chain ID:", hre.network.config.chainId);

  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with address:", deployer.address);

  // Deploy contract
  const ArcTestContract = await hre.ethers.getContractFactory("ArcTestContract");
  const contract = await ArcTestContract.deploy("My Arc Project");

  await contract.waitForDeployment();

  const address = await contract.getAddress();
  console.log("✅ Contract deployed to:", address);
  console.log("🔗 View on explorer: https://explorer.testnet.arc.io/address/" + address);

  // Auto-register deployer
  console.log("\n📝 Registering deployer...");
  const tx = await contract.register();
  await tx.wait();
  console.log("✅ Registered successfully!");

  // First interaction
  console.log("\n⚡ First interaction...");
  const tx2 = await contract.interact();
  await tx2.wait();
  console.log("✅ Interaction recorded!");

  console.log("\n🎉 Done! Save this contract address:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
