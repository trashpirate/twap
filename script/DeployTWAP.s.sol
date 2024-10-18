// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {TWAP} from "./../src/TWAP.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployTWAP is Script {
    function run() external returns (TWAP) {
        HelperConfig config = new HelperConfig();

        (address ethUsdPool) = config.activeNetworkConfig();

        vm.startBroadcast();
        TWAP twap = new TWAP(ethUsdPool);
        vm.stopBroadcast();
        return twap;
    }
}
