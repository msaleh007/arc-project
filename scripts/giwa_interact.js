const hre = require("hardhat");

async function main() {
  const [signer] = await hre.ethers.getSigners();
  
  console.log("Wallet:", signer.address);
  
  // Self transfer - simple activity
  const tx = await signer.sendTransaction({
    to: signer.address,
    value: hre.ethers.parseEther("0.0001"),
    data: "0x" + Buffer.from("GiwaRemit daily activity - msaleh007").toString("hex")
  });
  
  await tx.wait();
  console.log("✅ GIWA TX done! Hash:", tx.hash);
}

main().catch(console.error);