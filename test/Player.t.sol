// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

import {Judge} from "rock-paper-showtime/src/Judge.sol";
import {Avalanche} from "rock-paper-showtime/test/Gambits.sol";

import {Player} from "../src/Player.sol";

contract PlayerTest is Test {
    Judge internal judge;
    Player internal player;

    function setUp() public {
        judge = new Judge();
        player = new Player();

        judge.register("Avalanche", address(new Avalanche()));
        judge.register("Player", address(player));
    }

    function testAgainstAvalanche() public {
        judge.play("Player", "Avalanche");
    }
}
