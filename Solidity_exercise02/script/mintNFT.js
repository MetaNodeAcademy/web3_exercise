// scripts/mintNFT.js
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  const CA_Nft = await ethers.getContract("CA_Nft");

  const tokenURI =
    "ipfs://bafkreie7wslruvrq5pfzxzg4ybhxevjbeexpbck6lzjnkp6ezvv7c742gq";
  const tx = await CA_Nft.mintNFT(deployer.address, tokenURI);
  await tx.wait();

  console.log("NFT minted with token ID: 1");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
