// SPDX-License-Identifier: MIT

import "./IHevm.sol";
import "./EchidnaConfig.sol";
import "./Debugger.sol";
import "./Account.sol";

import "../interface/IUSDC.sol";
import "../interface/IcEther.sol";
import "../interface/ICErc20.sol";
import "../interface/IComptroller.sol";
import "../interface/IRariMasterPriceOracle.sol";

contract EchidnaSetup is EchidnaConfig {
    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    Account account0 = new Account(0);
    Account account1 = new Account(2);
    Account account2 = new Account(128);

    IUSDC usdc = IUSDC(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IcEther fEth = IcEther(payable(0x26267e41CeCa7C8E0f143554Af707336f27Fa051));
    ICErc20 fUsdc = ICErc20(0xEbE0d1cb6A0b8569929e062d67bfbC07608f0A47);
    IComptroller comptroller =
        IComptroller(0x3f2D1BC6D02522dbcdb216b2e75eDDdAFE04B16F);
    IRariMasterPriceOracle oracle =
        IRariMasterPriceOracle(0xe980EFB504269FF53F7F4BC92a2Bd1e31B43f632);

    constructor() {
        // not sure if still necessary, but just in case
        hevm.roll(14684813);

        hevm.prank(usdc.masterMinter());
        usdc.configureMinter(address(this), type(uint256).max);

        ADDRESS_ACCOUNT0 = payable(address(account0));
        ADDRESS_ACCOUNT1 = payable(address(account1));
        ADDRESS_ACCOUNT2 = payable(address(account2));

        ADDRESS_ACCOUNT0.transfer(STARTING_ETH_BALANCE);
        ADDRESS_ACCOUNT1.transfer(STARTING_ETH_BALANCE);
        ADDRESS_ACCOUNT2.transfer(STARTING_ETH_BALANCE);

        usdc.mint(ADDRESS_ACCOUNT0, STARTING_TOKEN_BALANCE);
        usdc.mint(ADDRESS_ACCOUNT1, STARTING_TOKEN_BALANCE);
        usdc.mint(ADDRESS_ACCOUNT2, STARTING_TOKEN_BALANCE);

        hevm.prank(ADDRESS_ACCOUNT0);
        usdc.approve(address(fUsdc), type(uint256).max);
        hevm.prank(ADDRESS_ACCOUNT1);
        usdc.approve(address(fUsdc), type(uint256).max);
        hevm.prank(ADDRESS_ACCOUNT2);
        usdc.approve(address(fUsdc), type(uint256).max);
    }
}
