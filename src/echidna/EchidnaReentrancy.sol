// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaReentrancy is EchidnaHelper {
    bool internal enabled;
    uint8 internal callback;
    uint256 internal uint0;

    function updateReentrancy(
        bool _enabled,
        uint8 _callback,
        uint256 _uint0
    ) public {
        enabled = _enabled;
        callback = _callback;
        uint0 = _uint0;
    }

    function setReentrancyEnabled(bool _enabled) public {
        enabled = _enabled;
    }

    function setReentrancyCallback(uint8 _callback) public {
        callback = _callback;
    }

    function setReentrancyUint0(uint256 _uint0) public {
        uint0 = _uint0;
    }

    function performCallback(uint8 accountId) public {
        if (!enabled) return;

        uint256 functionId = (callback % 6) + 1;

        if (functionId == 1) {
            mint(accountId, uint0);
        } else if (functionId == 2) {
            redeem(accountId, uint0);
        } else if (functionId == 3) {
            borrow(accountId, uint0);
        } else if (functionId == 4) {
            repay(accountId, uint0);
        } else if (functionId == 5) {
            exitMarket(accountId);
        } else if (functionId == 6) {
            accrueInterest();
        }
    }
}
