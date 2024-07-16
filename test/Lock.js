const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleSwapper", function () {
  let swapper;
  let owner;
  let tokenAddress; 

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    owner = deployer;

    // Deploy a swapper token contract
    const Swapper = await ethers.getContractFactory("SimpleSwapper");
    swapper = await Swapper.deploy();
    await swapper.waitForDeployment();
    
    // Deploy a mock token contract
    const MockToken = await ethers.getContractFactory("STOKEN"); 
    const mockToken = await MockToken.deploy("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");
    await mockToken.waitForDeployment();
 
    tokenAddress = mockToken.target;

    // Mint tokens to the swapper contract for testing
    await mockToken.mint(swapper.target, ethers.parseEther("10")); // Adjust amount as needed
  });

  it("should swap Ether to token successfully", async function () {
    const swapAmount = ethers.parseEther("1");
    const minAmount = ethers.parseEther("0.5"); 

    const swapValue = await swapper.swapEtherToToken(tokenAddress, minAmount, { value: swapAmount });
    const receipt = await swapValue.wait();
    console.log(receipt.gasUsed);
  });
});
