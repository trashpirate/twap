// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {TWAP} from "./TWAP.sol";

contract TWAPETH is TWAP {
    address constant WETH_USDT_POOL = 0x4e68Ccd3E89f51C3074ca5072bbAC773960dFa36;

    constructor() TWAP(WETH_USDT_POOL) {}
}
