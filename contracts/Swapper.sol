// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for interacting with the Uniswap V2 Router
interface IUniswapV2Router02 {
    function WETH() external pure returns (address);
    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
}

// Interface for interacting with ERC20 tokens
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

// Interface for the ERC20 swapper contract
interface ERC20Swapper {
    function swapEtherToToken(address token, uint minAmount) external payable returns (uint);
}


contract EtherToTokenSwapper is ERC20Swapper {
    address public owner;  
    IUniswapV2Router02 public uniswapRouter;  

 
    constructor(address _uniswapRouter) {
        owner = msg.sender;
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
    }

    // Modifier to restrict function access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    /**
     * @notice Swaps Ether for a specified ERC20 token using Uniswap V2.
     * @param token The address of the ERC20 token to receive.
     * @param minAmount The minimum amount of tokens to receive from the swap.
     * @return The amount of tokens received from the swap.
     */
    function swapEtherToToken(address token, uint minAmount) external override payable returns (uint) {
        require(msg.value > 0, "No Ether sent");  

        uint tokens = getEstimatedTokensForEth(token, msg.value);  

        require(tokens >= minAmount, "Received less tokens than expected");  

        address[] memory path = new address[](2);  // Define the swap path
        path[0] = uniswapRouter.WETH();  // Ether address
        path[1] = token;  // Target token address

        uint[] memory amounts = uniswapRouter.swapExactETHForTokens{ value: msg.value }(
            minAmount,
            path,
            msg.sender,
            block.timestamp + 300 
        );

        return amounts[1];  
    }

    /**
     * @notice Gets the estimated amount of tokens for a given amount of Ether.
     * @param token The address of the ERC20 token to estimate.
     * @param ethAmount The amount of Ether to use for the estimate.
     * @return The estimated amount of tokens for the given Ether amount.
     */
    function getEstimatedTokensForEth(address token, uint ethAmount) public view returns (uint) {
        address[] memory path = new address[](2);  
        path[0] = uniswapRouter.WETH();  
        path[1] = token;  

        uint[] memory amounts = uniswapRouter.getAmountsOut(ethAmount, path);  
        return amounts[1];  
    }

    /**
     * @notice Gets the balance of a specific ERC20 token for a given account.
     * @param tokenadd The address of the ERC20 token.
     * @param account The address of the account to query.
     * @return The balance of the specified token for the given account.
     */
    function tokenBalanceOf(address tokenadd, address account) public view returns (uint) {
        IERC20 token = IERC20(tokenadd);  
        uint balance = token.balanceOf(account);  
        return balance;  
    }

    /**
     * @notice Sets a new contract owner. Can only be called by the current owner.
     * @param newOwner The address of the new owner.
     */
    function setOwner(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    /**
     * @notice Updates the Uniswap V2 Router address. Can only be called by the owner.
     * @param newRouter The address of the new Uniswap V2 Router.
     */
    function updateUniswapRouter(address newRouter) external onlyOwner {
        uniswapRouter = IUniswapV2Router02(newRouter);
    }
}
