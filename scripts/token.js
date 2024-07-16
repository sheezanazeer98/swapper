const { ethers } = require("hardhat");

async function main() {
//   Get the contract factory
  const contract = await ethers.getContractFactory("STOKEN");

  // Deploy the contract
  const deployedContract = await contract.deploy("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");

  await deployedContract.waitForDeployment();

  console.log("STOKEN Contract deployed to", deployedContract.target);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });