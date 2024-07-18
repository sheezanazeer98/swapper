const { ethers } = require("hardhat");

async function main() {
//   Get the contract factory
  const contract = await ethers.getContractFactory("EtherToTokenSwapper");

  // Deploy the contract
  const deployedContract = await contract.deploy("0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008"); // uniswapRouter Address

  await deployedContract.waitForDeployment();

  console.log("EtherToTokenSwapper Contract deployed to", deployedContract.target);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });