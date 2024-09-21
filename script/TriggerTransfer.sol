// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";
import {ISafe} from "@safe/contracts/interfaces/ISafe.sol";

contract TriggerTransfer is Script {
    MiniSafeModule miniSafeModule = MiniSafeModule(0xa821877c265906dC0801f80ec540b0665c825E4c);

    // MODIFY
    address miniSafeModuleController = 0x4f1e8f02982102473fFB53C5F69E2F5Ee584b8D0;
    ISafe safe = ISafe(0xC931619fDBf6E442548A19cfBe9954306d7ca683);
    address usdc = 0x036CbD53842c5426634e7929541eC2318f3dCF7e; // Base
    address payable to = payable(0x3C5f72aFD4ED3E971af1e91FD4cfC5886Def009F);
    uint8 toChain = 0x2; // Base sepolia

    function setUp() public {}

    function run() public {
        vm.broadcast();

        console.log(msg.sender);

        miniSafeModule.executeAllowanceTransfer(safe, address(usdc), to, 1, miniSafeModuleController, toChain);

        // vm.broadcast();
    }
}
