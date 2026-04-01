const { ethers } = require("hardhat");
const crypto = require("crypto");

async function main() {
  // 1. Generate random secrets
  const secret = ethers.hexlify(crypto.randomBytes(32));
  const nullifier = ethers.hexlify(crypto.randomBytes(32));
  
  // 2. Create the commitment hash
  const commitment = ethers.keccak256(ethers.solidityPacked(["bytes32", "bytes32"], [secret, nullifier]));

  console.log("Keep these secret for withdrawal:");
  console.log("Secret:", secret);
  console.log("Nullifier Hash:", nullifier);
  console.log("---");
  console.log("Submit this to the Deposit function:");
  console.log("Commitment:", commitment);
}

main();
