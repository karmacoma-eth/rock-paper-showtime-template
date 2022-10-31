// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";

import {Player} from "../src/Player.sol";

contract PlayerScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        console2.log("Deploying from", vm.addr(deployerPrivateKey));
        Player player = new Player();
        console2.log("Deployed Player at", address(player));
    }
}
