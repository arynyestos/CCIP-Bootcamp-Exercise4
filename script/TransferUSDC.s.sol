// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {TransferUSDC} from "../src/TransferUSDC.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract TransferUSDCScript is Script {
    TransferUSDC public transferUSDC;

    function setUp() public {}

    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        (address router, address link, address usdc) = helperConfig.activeNetworkConfig();

        vm.startBroadcast();

        transferUSDC = new TransferUSDC(router, link, usdc);

        vm.stopBroadcast();
    }
}
