# Rock Paper Showtime Template

This is the *Player Template* for the RPS on-chain game. This repository uses the main [rock-paper-showtime](https://github.com/karmacoma-eth/rock-paper-showtime) repo as a dependency and lets you build, test and deploy your own strategy.

## Getting Started

### Pre-requisites

- install an editor like [VS Code](https://code.visualstudio.com/) with the [Solidity extension](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
- install foundryup: `curl -L https://foundry.paradigm.xyz | bash`
- install foundry: `foundryup`
- click `Use this template` to create a fork
- checkout your fork: `git clone git@github.com:<github-user>/<template-fork>.git`

### Sanity check

You should now be able to build and test your setup:

```
forge build
forge test
```

### Work on your strategy

The point of this workshop will be to develop a smart contract that implements a rock-paper-scissors strategy against other smart contracts. You can check out the default [src/Player.sol]:

```solidity
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
```

It implements the [IPlayer.sol](https://github.com/karmacoma-eth/rock-paper-showtime/blob/main/src/interfaces/IPlayer.sol) interface:

- the function `firstThrow` takes one string argument (the name of your opponent for this game) and returns a `Throw` (i.e. rock, paper or scissors)
- the function `nextThrow` takes one `Throw` argument (the previous move of your opponent) and also returns a `Throw`

If you want to get a deeper understanding of how a game plays out, you can check [Judge.sol](https://github.com/karmacoma-eth/rock-paper-showtime/blob/main/src/Judge.sol):

- first, both players register their contract under a name (using `Judge.register(string _name, address _addr)`)
- then someone invokes `Judge.play(string player1, string player2)`
- the game looks up the addresses registered under these names
- the game invokes `firstThrow(opponentName)` on each player's contract
- the game then invokves `nextThrow(prevOpponentThrow)` on each player's contract until one of them gets to 2 wins

Note:
- each player only has 50k gas available to compute their next move
- the game stops with a draw if there are no winner after 5 rounds

With that in mind, you should be ready to implement some strategies that are more intelligent than the default one, a gambit called the Bureaucrat because it only throws paper.


### Test against live opponents

When you run `forge test -vvvv --match testAgainstCrescendo`, you can see how your local strategy _would_ play out against a registered opponent, in this case `crescendo`. This lets you test your strategy against live players without having to redeploy every time!

### Deploy

When you are done building and testing, you're ready to deploy and go against live opponents!

First you need a little bit of setup. Create a file called `.env` with the following format:

```
PRIVATE_KEY=
MUMBAI_RPC_URL=
ETHERSCAN_API_KEY=
```

Then create a new address and private key with

```
cast wallet new
```

Paste the private key in `.env` and fund the new address at https://mumbaifaucet.com/.

Then enter your favorite RPC url and Polygonscan API keys in `.env`.

You are now ready to deploy!

```
source .env

# dry run
forge script script/Player.s.sol --rpc-url $MUMBAI_RPC_URL

# actually perform the deployment
forge script script/Player.s.sol --rpc-url $MUMBAI_RPC_URL --broadcast --verify
```
