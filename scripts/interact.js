const hre = require("hardhat");

const CONTRACT_ADDRESS = "0x80FA38299826D22Bc7e907E31281A0D74691F9Bc";

async function main() {
  const contract = await hre.ethers.getContractAt("ArcTestContract", CONTRACT_ADDRESS);
  const [signer] = await hre.ethers.getSigners();
  
  console.log("Interacting with:", CONTRACT_ADDRESS);
  
  const tx = await contract.interact();
  await tx.wait();
  
  const count = await contract.userInteractions(signer.address);
  console.log("✅ Total interactions:", count.toString());
}

main().catch(console.error);