# SimpleSwapper Contract

The `SimpleSwapper` contract enables users to swap Ether for any ERC20 tokens, ensuring a minimum amount of tokens are received. The owner can withdraw tokens and Ether from the contract. Additionally, a mock token is added for testing purposes.


```shell
npm i
npx hardhat node 
npx hardhat compile
npx hardhat test
npx hardhat run scripts/swapper.js --network localhost
```
