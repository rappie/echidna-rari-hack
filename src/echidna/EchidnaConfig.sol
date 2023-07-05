// SPDX-License-Identifier: MIT

contract EchidnaConfig {
    address payable internal ADDRESS_ACCOUNT0;
    address payable internal ADDRESS_ACCOUNT1;
    address payable internal ADDRESS_ACCOUNT2;

    uint256 internal constant STARTING_TOKEN_BALANCE = 1_000_000_000e6;
    uint256 internal constant STARTING_ETH_BALANCE = 1000 ether;

    function getAccount(uint8 accountId)
        internal
        view
        returns (address account)
    {
        if (accountId <= 1) {
            account = ADDRESS_ACCOUNT0;
        } else if (accountId < 128) {
            account = ADDRESS_ACCOUNT1;
        } else {
            account = ADDRESS_ACCOUNT2;
        }
    }
}
