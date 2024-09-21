// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MiniSafe} from "../src/MiniSafe.sol";

contract MiniSafeTest is Test {
    MiniSafe public minisafe;

    function setUp() public {
        minisafe = new MiniSafe();
        minisafe.setNumber(0);
    }

    function test_Increment() public {
        minisafe.increment();
        assertEq(minisafe.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        minisafe.setNumber(x);
        assertEq(minisafe.number(), x);
    }
}
