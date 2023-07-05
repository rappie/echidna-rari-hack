// SPDX-License-Identifier: MIT

import "./EchidnaReentrancy.sol";
import "./Debugger.sol";


contract EchidnaDebug is EchidnaReentrancy {
    // function debugReplayHack(uint8 accountId) public {
    //     uint8 functionId = 4; // exitMarkets
    //     updateReentrancy(true, functionId, 0);
    //     mint(accountId, 15000000000000);
    //     borrow(accountId, 1977 ether);
    //     redeem(accountId, 14000000000000);
    // }
}
