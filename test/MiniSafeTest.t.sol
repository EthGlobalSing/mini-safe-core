// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";
import {SafeProxyFactory} from "../lib/safe-smart-account/contracts/proxies/SafeProxyFactory.sol";
import {Safe} from "@safe/contracts/Safe.sol";
import {ISafe} from "@safe/contracts/interfaces/ISafe.sol";
import {SafeProxy} from "@safe/contracts/proxies/SafeProxy.sol";
import {Enum} from "@safe/contracts/libraries/Enum.sol";
import {VmSafe} from "forge-std/Vm.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MiniSafeTest is Test {
    MiniSafeModule public miniSafeModule;

    VmSafe.Wallet miniSafeController = vm.createWallet(string("_newOwner"));

    SafeProxyFactory safeProxyFactory = SafeProxyFactory(0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2);
    ISafe singleton = ISafe(0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552);

    ERC20 usdc = ERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);

    function setUp() public {
        uint8[] memory _cctpSupportedChains = new uint8[](2);
        address[] memory _cctpAddresses = new address[](2);

        _cctpSupportedChains[0] = 0x6;
        _cctpSupportedChains[1] = 0x2;

        _cctpAddresses[0] = 0x1682Ae6375C4E4A97e4B583BC394c861A46D8962;
        _cctpAddresses[1] = 0x2B4069517957735bE00ceE0fadAE88a26365528f;

        miniSafeModule = new MiniSafeModule(address(miniSafeController.addr), 0x6, _cctpSupportedChains, _cctpAddresses);
        // miniSafeModule.setNumber(0);
    }

    function test_SetupMiniSafe() public {
        address[] memory _owners = new address[](1);
        _owners[0] = address(this);

        uint256 _threshold = 1;

        // create safe
        bytes memory initializer = abi.encodeWithSelector(
            Safe.setup.selector, _owners, _threshold, address(0), address(0), address(0), address(0), 0, address(0)
        );
        SafeProxy safeProxy = safeProxyFactory.createProxyWithNonce(address(singleton), initializer, 1);

        ISafe safe = Safe(payable(safeProxy));

        console.log("CREATED SAFE");
        console.log("safe", address(safe));
        console.log("owner", safe.getOwners()[0]);

        // fund module with usdc
        vm.prank(0x0B0A5886664376F59C351ba3f598C8A8B4D0A6f3);
        usdc.transfer(address(safe), 100_000_000_000);

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
            abi.encodePacked(uint256(uint160(address(this))), uint8(0), uint256(1))
        );

        console.log("ENABLED MODULE");

        // add delegate
        bytes memory _dataAddDelegate = abi.encodeWithSignature("addDelegate(address)", miniSafeController);
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
            abi.encodePacked(uint256(uint160(address(this))), uint8(0), uint256(1))
        );

        // set allowance
        bytes memory _dataSetAllowance = abi.encodeWithSignature(
            "setAllowance(address,address,uint96,uint16,uint32)",
            miniSafeController.addr,
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
            abi.encodePacked(uint256(uint160(address(this))), uint8(0), uint256(1))
        );

        // miniSafeController can transfer tokens

        uint256 safeUsdcBefore = usdc.balanceOf(address(safe));

        address payable to = payable(0x1234AA39B223fe8D0A0E5c4f27Ead9083c751234);

        vm.prank(miniSafeController.addr);
        miniSafeModule.executeAllowanceTransfer(safe, address(usdc), to, 1, miniSafeController.addr);

        uint256 safeUsdcAfter = usdc.balanceOf(address(safe));

        console.log(safeUsdcBefore - safeUsdcAfter);
    }
}
