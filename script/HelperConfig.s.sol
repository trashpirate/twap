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
    address WETH_USD_POOL = vm.envAddress("WETH_USD_POOL");

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
    function getTestnetConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({usdPricePool: WETH_USD_POOL});
    }

    function getMainnetConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({usdPricePool: WETH_USD_POOL});
    }

    function getAnvilConfig() public view returns (NetworkConfig memory) {
        // vm.startBroadcast();
        // vm.stopBroadcast();

        return NetworkConfig({usdPricePool: WETH_USD_POOL});
    }

    /*//////////////////////////////////////////////////////////////
                                GETTERS
    //////////////////////////////////////////////////////////////*/
    function getActiveNetworkConfig() public view returns (NetworkConfig memory) {
        return activeNetworkConfig;
    }
}
