// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        address usdPricePool;
    }

    NetworkConfig public activeNetworkConfig;

    /*//////////////////////////////////////////////////////////////
                                HELPERS
    //////////////////////////////////////////////////////////////*/
    uint256 constant CONSTANT = 0;

    constructor() {
        if (block.chainid == 1 || block.chainid == 123) {
            activeNetworkConfig = getMainnetConfig();
        } else if (block.chainid == 11155111) {
            activeNetworkConfig = getTestnetConfig();
        } else {
            activeNetworkConfig = getAnvilConfig();
        }
    }

    /*//////////////////////////////////////////////////////////////
                          CHAIN CONFIGURATIONS
    //////////////////////////////////////////////////////////////*/
    function getTestnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({usdPricePool: 0x4e68Ccd3E89f51C3074ca5072bbAC773960dFa36});
    }

    function getMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({usdPricePool: 0x4e68Ccd3E89f51C3074ca5072bbAC773960dFa36});
    }

    function getAnvilConfig() public pure returns (NetworkConfig memory) {
        // vm.startBroadcast();
        // vm.stopBroadcast();

        return NetworkConfig({usdPricePool: 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF});
    }

    /*//////////////////////////////////////////////////////////////
                                GETTERS
    //////////////////////////////////////////////////////////////*/
    function getActiveNetworkConfig() public view returns (NetworkConfig memory) {
        return activeNetworkConfig;
    }
}
