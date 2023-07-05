// SPDX-License-Identifier: MIT
import "./Debugger.sol";
import "./Echidna.sol";

contract Account {
    Echidna echidna;
    uint8 accountId;

    constructor(uint8 _accountId) {
        echidna = Echidna(msg.sender);
        accountId = _accountId;
    }

    receive() external payable {
        if (msg.sender == address(echidna)) {
            return;
        }

        echidna.performCallback(accountId);
    }
}
