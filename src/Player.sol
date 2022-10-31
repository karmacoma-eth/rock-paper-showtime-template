// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IPlayer, Throw} from "rock-paper-showtime/src/interfaces/IPlayer.sol";

contract Player is IPlayer {
    function firstThrow(
        string calldata /* opponentName */
    ) external pure returns (Throw) {
        return Throw.Paper;
    }

    function nextThrow(
        Throw /* prevOpponentThrow */
    ) external pure returns (Throw) {
        return Throw.Paper;
    }
}
