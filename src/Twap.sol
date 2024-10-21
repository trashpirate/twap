// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*//////////////////////////////////////////////////////////////
                                IMPORTS
//////////////////////////////////////////////////////////////*/
import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import {TickMath} from "@uniswap/v3-core/contracts/libraries/TickMath.sol";

/**
 *  @title Twap
 *  @notice This contract allows the functionality to calculate the Twap of a Uniswap V3 pool.
 *  @dev Needs to be adjusted if pool token1 != WETH
 */
contract Twap {
    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    address immutable i_wethUsdPool;

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    constructor(address wethUsdPool) {
        if (wethUsdPool == address(0)) {
            i_wethUsdPool = 0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8;
        } else {
            i_wethUsdPool = wethUsdPool;
        }
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function calcTwapInEth(address pool, uint32 secondsAgo) public view returns (uint256) {
        uint32[] memory secondsAgos = new uint32[](2);
        secondsAgos[0] = secondsAgo;
        secondsAgos[1] = 0;

        // get tickCumulatives
        (int56[] memory tickCumulatives,) = IUniswapV3Pool(pool).observe(secondsAgos);

        // calculate TWAP in terms of ticks
        int56 tickDifference = tickCumulatives[1] - tickCumulatives[0];
        int56 averageTick = tickDifference / int56(uint56(secondsAgo));

        // calculate TWAP in terms of ETH per token (assuming pool token1 == WETH)
        uint256 sqrtPriceX96 = uint256(TickMath.getSqrtRatioAtTick(int24(averageTick)));
        uint256 ethPerToken = (sqrtPriceX96 * sqrtPriceX96 * 1e18) >> 192;

        return ethPerToken;
    }

    function calcTwapInTokens(address pool, uint32 secondsAgo) public view returns (uint256) {
        uint32[] memory secondsAgos = new uint32[](2);
        secondsAgos[0] = secondsAgo;
        secondsAgos[1] = 0;

        // get tickCumulatives
        (int56[] memory tickCumulatives,) = IUniswapV3Pool(pool).observe(secondsAgos);

        // calculate TWAP in terms of ticks
        int56 tickDifference = tickCumulatives[1] - tickCumulatives[0];
        int56 averageTick = tickDifference / int56(uint56(secondsAgo));

        // calculate TWAP in terms of ETH per token (assuming pool token1 == WETH)
        uint256 sqrtPriceX96 = uint256(TickMath.getSqrtRatioAtTick(int24(averageTick)));
        uint256 ethPerToken = (sqrtPriceX96 * sqrtPriceX96 * 1e18) >> 192;

        return (1e18 * 1e18) / ethPerToken;
    }

    function calcTwapInUsd(address pool, uint32 secondsAgo) public view returns (uint256) {
        uint256 ethPrice = calcTwapInEth(pool, secondsAgo);
        uint256 ethUsdPrice = calcTwapInEth(i_wethUsdPool, secondsAgo);

        return ethPrice * ethUsdPrice / 1e6;
    }
}
