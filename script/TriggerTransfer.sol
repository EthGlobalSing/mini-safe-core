// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";
import {ISafe} from "@safe/contracts/interfaces/ISafe.sol";

contract TriggerTransfer is Script {
    // MODIFY
    // MiniSafeModule miniSafeModule = MiniSafeModule(0x4BfeB254D4018C8a8E9E7BD7A75994C74060fAD3); // Base
    MiniSafeModule miniSafeModule = MiniSafeModule(0x4B64746Ed487B0f36B5e913113C3dc5892A1cd5E); // Linea
    address miniSafeModuleController = 0x4f1e8f02982102473fFB53C5F69E2F5Ee584b8D0; // EOA
    // ISafe safe = ISafe(0xC931619fDBf6E442548A19cfBe9954306d7ca683); // Base
    ISafe safe = ISafe(0xC931619fDBf6E442548A19cfBe9954306d7ca683); // Linea
    // address usdc = 0x036CbD53842c5426634e7929541eC2318f3dCF7e; // Base
    address usdc = 0x0E9FE0B4c20eFfbB270d79ce6D18A77280D32C08; // Base
    address payable to = payable(0x3C5f72aFD4ED3E971af1e91FD4cfC5886Def009F); // Linea
    uint8 toChain = 0xff; // ETH Sepolia
    // 0x2 // OP sepolia
    uint96 amount = 100;

    function setUp() public {}

    function run() public {
        vm.broadcast();

        console.log(msg.sender);

        miniSafeModule.executeAllowanceTransfer(safe, address(usdc), to, amount, miniSafeModuleController, toChain);

        // vm.broadcast();
    }
}
