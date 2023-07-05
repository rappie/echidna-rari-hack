// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";

contract EchidnaTest is EchidnaDebug {
    int256 constant PROFIT_TARGET = 1 ether;


    uint256 account0InitialValue;
    uint256 account1InitialValue;
    uint256 account2InitialValue;

    constructor() public EchidnaDebug() {
        account0InitialValue = getAccountValue(ADDRESS_ACCOUNT0);
        account1InitialValue = getAccountValue(ADDRESS_ACCOUNT1);
        account2InitialValue = getAccountValue(ADDRESS_ACCOUNT2);
    }

    function testProfit() public {
        uint256 account0Value = getAccountValue(ADDRESS_ACCOUNT0);
        uint256 account1Value = getAccountValue(ADDRESS_ACCOUNT1);
        uint256 account2Value = getAccountValue(ADDRESS_ACCOUNT2);

        int256 account0Profit = int256(account0Value) -
            int256(account0InitialValue);
        int256 account1Profit = int256(account1Value) -
            int256(account1InitialValue);
        int256 account2Profit = int256(account2Value) -
            int256(account2InitialValue);

        Debugger.log("account0Profit", account0Profit);
        Debugger.log("account1Profit", account1Profit);
        Debugger.log("account2Profit", account2Profit);

        assert(account0Profit <= PROFIT_TARGET);
        assert(account1Profit <= PROFIT_TARGET);
        assert(account2Profit <= PROFIT_TARGET);
    }

    function getAccountValue(address account) internal returns (uint256 value) {
        uint256 ethDecimals = 18;
        uint256 usdcDecimals = 6;

        uint256 ethBalance = account.balance;
        uint256 usdcBalance = usdc.balanceOf(account);

        uint256 ethPrice = 1 ether;
        uint256 usdcPrice = oracle.price(address(usdc));

        uint256 ethValue = (ethBalance * ethPrice) / (10**ethDecimals);
        uint256 usdcValue = (usdcBalance * usdcPrice) / (10**usdcDecimals);

        value = ethValue + usdcValue;
    }
}
