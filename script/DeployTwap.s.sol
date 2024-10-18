// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {Twap} from "./../src/Twap.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployTwap is Script {
    function run() external returns (Twap) {
        HelperConfig config = new HelperConfig();

        (address ethUsdPool) = config.activeNetworkConfig();

        vm.startBroadcast();
        Twap twap = new Twap(ethUsdPool);
        vm.stopBroadcast();
        return twap;
    }
}
