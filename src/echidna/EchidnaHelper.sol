// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./Debugger.sol";

contract EchidnaHelper is EchidnaSetup {
    function mint(uint8 accountId, uint256 amount) public {
        address account = getAccount(accountId);

        amount = amount % (usdc.balanceOf(account) + 1);

        hevm.prank(account);
        uint256 error = fUsdc.mint(amount);
    }

    function redeem(uint8 accountId, uint256 amount) public {
        address account = getAccount(accountId);

        uint256 underlyingBalance = fUsdc.balanceOfUnderlying(account);
        amount = amount % (underlyingBalance + 1);

        hevm.prank(account);
        fUsdc.redeemUnderlying(amount);
    }

    function borrow(uint8 accountId, uint256 amount) public {
        address account = getAccount(accountId);

        address[] memory ctokens = new address[](1);
        ctokens[0] = address(fUsdc);
        hevm.prank(account);
        comptroller.enterMarkets(ctokens);

        (uint256 error, uint256 liquidity, uint256 shortfall) = comptroller
            .getAccountLiquidity(account);
        amount = amount % (liquidity + 1);

        hevm.prank(account);
        fEth.borrow(amount);
    }

    function repay(uint8 accountId, uint256 amount) public {
        address account = getAccount(accountId);

        uint256 borrowed = fEth.borrowBalanceCurrent(account);
        amount = amount % (borrowed + 1);

        hevm.prank(account);
        fEth.repayBorrow{value: amount}();
    }

    function exitMarket(uint8 accountId) public {
        address account = getAccount(accountId);
        hevm.prank(account);
        comptroller.exitMarket(address(fUsdc));
    }

    function accrueInterest() public {
        fUsdc.accrueInterest();
        fEth.accrueInterest();
    }

    // function transfer(
    //     uint8 fromAccId,
    //     uint8 toAccId,
    //     uint256 amount
    // ) public {
    //     address from = getAccount(fromAccId);
    //     address to = getAccount(toAccId);

    //     hevm.prank(from);
    //     cUsdc.transfer(to, amount);
    // }
}
