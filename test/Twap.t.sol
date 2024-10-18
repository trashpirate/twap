// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Twap} from "src/Twap.sol";
import {DeployTwap} from "script/DeployTwap.s.sol";

contract TwapTest is Test {
    Twap twap;
    DeployTwap deployer;

    /*//////////////////////////////////////////////////////////////
                                 SETUP
    //////////////////////////////////////////////////////////////*/
    function setUp() external virtual {
        deployer = new DeployTwap();
        twap = deployer.run();
    }

    /*//////////////////////////////////////////////////////////////
                                TEST Twap
    //////////////////////////////////////////////////////////////*/
    function test__Twap__getsPriceInEth() public view {
        uint32 secondsAgo = 300;
        address pool = 0x1d42064Fc4Beb5F8aAF85F4617AE8b3b5B8Bd801;
        uint256 price = twap.calcTwapInEth(pool, secondsAgo);
        console.log(price);
    }

    function test__Twap__getsPriceInUsd() public view {
        uint32 secondsAgo = 300;
        address pool = 0x1d42064Fc4Beb5F8aAF85F4617AE8b3b5B8Bd801;
        uint256 price = twap.calcTwapInUsd(pool, secondsAgo);
        console.log(price);
    }
}
