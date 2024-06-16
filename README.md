# Reproduction of Rari Finance hack

## Description
This is a reproduction of the $80M Rari Finance hack on April 30 2022, using on-chain fuzzing with Echidna.

We're using a single invariant which checks if an actor is able to increase their balance by an unreasonably large amount. We have a basic set of functions such as `mint`, `borrow` and `exitMarket`, etc. Since the hack involves reentrancy, we've implemented rudementary reentrancy support in [EchidnaReentrancy](src/echidna/EchidnaReentrancy.sol).

After running for approximately 30 minutes (1 worker), we can detect a significant increase in funds for the attacking actor. The shrunk sequence can be seen below.

```
testProfit(): failed!💥
  Call sequence:
    setReentrancyEnabled(true)
    mint(5,10089325332519370949262917519849428342404732088146691233195543578618300570336)
    setReentrancyCallback(4)
    borrow(2,1164710473815707741)
    redeem(2,995200615491)
    testProfit()

Event sequence:
    Panic(1): Using assert
    Debug(«account0Profit», 0) from: 0xa329c0648769a73afac7f9381e08fb43dbea72
    Debug(«account1Profit», 1002263350696681541) from: 0xa329c0648769a73afac7f9381e08fb43dbea72
    Debug(«account2Profit», 0) from: 0xa329c0648769a73afac7f9381e08fb43dbea72

```

## Links
- https://twitter.com/BlockSecTeam/status/1520350965274386433
- https://github.com/SunWeb3Sec/DeFiHackLabs/blob/c4564f5ad21783cb81969540b57b07dd12e53b2a/src/test/Rari_exp.t.sol
