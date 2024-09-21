// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";
import {ISafe} from "@safe/contracts/interfaces/ISafe.sol";
import {Enum} from "@safe/contracts/libraries/Enum.sol";

contract EnableModule is Script {
    MiniSafeModule miniSafeModule = MiniSafeModule(0xa821877c265906dC0801f80ec540b0665c825E4c);

    // MODIFY
    address miniSafeModuleController = 0x4f1e8f02982102473fFB53C5F69E2F5Ee584b8D0;
    ISafe safe = ISafe(0xC931619fDBf6E442548A19cfBe9954306d7ca683);
    address usdc = 0x036CbD53842c5426634e7929541eC2318f3dCF7e; // Base

    function setUp() public {}

    function run() public {
        vm.broadcast();

        // enable module
        bytes memory _dataEnableModule = abi.encodeWithSignature("enableModule(address)", address(miniSafeModule));
        safe.execTransaction(
            address(safe),
            0, // value
            _dataEnableModule,
            Enum.Operation.Call,
            0,
            0,
            0,
            address(0),
            payable(0),
            abi.encodePacked(uint256(uint160(address(msg.sender))), uint8(0), uint256(1))
        );

        vm.broadcast();

        // add delegate
        bytes memory _dataAddDelegate = abi.encodeWithSignature("addDelegate(address)", miniSafeModuleController);
        safe.execTransaction(
            address(miniSafeModule),
            0, // value
            _dataAddDelegate,
            Enum.Operation.Call,
            0,
            0,
            0,
            address(0),
            payable(0),
            abi.encodePacked(uint256(uint160(address(msg.sender))), uint8(0), uint256(1))
        );

        vm.broadcast();

        // set allowance
        bytes memory _dataSetAllowance = abi.encodeWithSignature(
            "setAllowance(address,address,uint96,uint16,uint32)",
            miniSafeModuleController,
            usdc,
            100_000_000,
            60 * 24 * 30,
            20_000_000
        );
        safe.execTransaction(
            address(miniSafeModule),
            0, // value
            _dataSetAllowance,
            Enum.Operation.Call,
            0,
            0,
            0,
            address(0),
            payable(0),
            abi.encodePacked(uint256(uint160(address(msg.sender))), uint8(0), uint256(1))
        );

        vm.broadcast();
    }
}
