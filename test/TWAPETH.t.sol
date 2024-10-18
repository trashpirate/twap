// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {TWAPETH} from "src/TWAPETH.sol";

contract TwapTest is Test {
    TWAPETH twap;

    /*//////////////////////////////////////////////////////////////
                                 SETUP
    //////////////////////////////////////////////////////////////*/
    function setUp() external virtual {
        twap = new TWAPETH();
    }

    /*//////////////////////////////////////////////////////////////
                                TEST TWAP
    //////////////////////////////////////////////////////////////*/
    function test__TWAPETH__getsPriceInEth() public view {
        uint32 secondsAgo = 300;
        address pool = 0x1d42064Fc4Beb5F8aAF85F4617AE8b3b5B8Bd801;
        uint256 price = twap.calcTwapInEth(pool, secondsAgo);
        console.log(price);
    }

    function test__TWAPETH__getsPriceInUsd() public view {
        uint32 secondsAgo = 300;
        address pool = 0x1d42064Fc4Beb5F8aAF85F4617AE8b3b5B8Bd801;
        uint256 price = twap.calcTwapInUsd(pool, secondsAgo);
        console.log(price);
    }
}
