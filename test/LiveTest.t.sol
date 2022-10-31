// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

import {Judge} from "rock-paper-showtime/src/Judge.sol";

import {Player} from "../src/Player.sol";

contract LiveTest is Test {
    // the identifiers of the forks
    uint256 mumbaiFork;

    // uncomment to use the one defined in .env
    // string MUMBAI_RPC_URL = vm.envString("MUMBAI_RPC_URL");
    // string MUMBAI_RPC_URL = "https://rpc-mumbai.maticvigil.com";
    string MUMBAI_RPC_URL = "https://matic-mumbai.chainstacklabs.com";

    Judge judge;
    Player player;

    function setUp() public {
        mumbaiFork = vm.createFork(MUMBAI_RPC_URL);
        vm.selectFork(mumbaiFork);

        judge = Judge(0x1bc02dCf4786F27Dab39cFe97A2825e8804396c1);

        player = new Player();
        judge.register("player", address(player));
    }

    /// @dev tests the local strategy against a named strategy deployed on mumbai. Pick any player that has registered!
    function testAgainstCrescendo() public {
        judge.play("player", "crescendo");
    }
}
