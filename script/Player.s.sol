// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";

import {Player} from "../src/Player.sol";

contract PlayerScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        Player player = new Player();
        console2.log("Deployed Player at", address(player));
    }
}
