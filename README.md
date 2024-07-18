# SimpleSwapper Contract

The SimpleSwapper contract enables users to swap Ether for ERC-20 tokens using the Uniswap V2 Router. It is designed for safety, performance, and usability, ensuring a fair and efficient token exchange while allowing owner-driven upgrades for enhanced security.


## Uniswap V2 Router Address
- 0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008


## Test ERC20 Token Addresses
- 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238
- 0x42aeC7D641D2b34695e9Aee553a5D19b2c001596
- 0x18f833C09ED91c32B575f6C289142C2b647d3a1c


##  Contract Evaluation 

### Safety and Trust Minimization
- Uses Uniswap V2 Router, a trusted and widely-used DEX.
- Owner can update the Uniswap router address in case of a critical vulnerability.
- Ensures a fair exchange rate by reverting if the received token amount is less than the minimum expected amount.

### Performance
- Reasonable gas cost for the `swapEtherToToken` function, considering the Uniswap V2 Router's complexity.
- Reasonable deployment cost, given the simplicity of the contract.

### Upgradeability
- Owner can update the Uniswap router address.
- Future upgrades could include a upgradable proxy contract or a modular design for more comprehensive upgradeability.

### Usability and Interoperability
- Usable for Externally Owned Accounts (EOAs) with Ether.
- `swapEtherToToken` function is interoperable with other contracts, following the ERC20Swapper interface.

### Readability and Code Quality
- Readable and well-structured code.
- Modular design using interfaces (`IUniswapV2Router02` and `IERC20`).




```shell
npm i
npx hardhat compile
npx hardhat run scripts/swapper.js --network localhost
```
