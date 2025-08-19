const { ethers } = require("hardhat");
import "../contracts/CA_Token.sol";

async function main() {
  const CA_Token = await ethers.getContractFactory("CA_Token");
  const ca_token = await CA_Token.deploy();
  await ca_token.deployed();
  console.log("CA_Token deployed to:", ca_token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
