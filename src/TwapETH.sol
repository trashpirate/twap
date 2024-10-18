// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Twap} from "./Twap.sol";

contract TwapETH is Twap {
    address constant WETH_USDT_POOL = 0x4e68Ccd3E89f51C3074ca5072bbAC773960dFa36;

    constructor() Twap(WETH_USDT_POOL) {}
}
