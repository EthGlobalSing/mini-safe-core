// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MiniSafe} from "../src/MiniSafeModule.sol";

contract MiniSafeTest is Test {
    MiniSafe public minisafe;

    SafeProxyFactory safeProxyFactory = SafeProxyFactory(0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2);

    function setUp() public {
        minisafe = new MiniSafe();
        minisafe.setNumber(0);
    }

    function test_SetupMiniSafe() public {
        // create safe

        // add module

        // add delegate

        // set allowance

        // transfer tokens

        assertEq(1, 1);
    }
}
