// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for ERC20 token functions
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

// Interface for the ERC20Swapper contract
interface ERC20Swapper {
    function swapEtherToToken(address token, uint minAmount) external payable returns (uint);
}

contract SimpleSwapper is ERC20Swapper {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Swaps Ether to the specified ERC20 token.
     * @dev Transfers a minimum amount of tokens to the sender if the contract holds sufficient tokens.
     * @param token The address of the ERC20 token contract.
     * @param minAmount The minimum amount of tokens to receive.
     * @return The amount of tokens transferred.
     */
    function swapEtherToToken(address token, uint minAmount) external override payable returns (uint) {
        require(msg.value > 0, "Must send Ether to swap");

        IERC20 tokenContract = IERC20(token);
        uint tokenBalance = tokenContract.balanceOf(address(this));
        require(tokenBalance >= minAmount, "Not enough tokens in contract");

        tokenContract.transfer(msg.sender, minAmount);

        return minAmount;
    }

    /**
     * @notice Withdraws specified amount of tokens from the contract.
     * @dev Only the owner can call this function to withdraw tokens.
     * @param token The address of the ERC20 token contract.
     * @param amount The amount of tokens to withdraw.
     */
    function withdrawTokens(address token, uint amount) external {
        require(msg.sender == owner, "Only owner can withdraw tokens");

        IERC20(token).transfer(msg.sender, amount);
    }

    /**
     * @notice Withdraws specified amount of Ether from the contract.
     * @dev Only the owner can call this function to withdraw Ether.
     * @param amount The amount of Ether to withdraw.
     */
    function withdrawEther(uint amount) external {
        require(msg.sender == owner, "Only owner can withdraw Ether");

        payable(msg.sender).transfer(amount);
    }

    /**
     * @notice Fallback function to receive Ether.
     * @dev Allows the contract to receive Ether directly.
     */
    receive() external payable {}
}
