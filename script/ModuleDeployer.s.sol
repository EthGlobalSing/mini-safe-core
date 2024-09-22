// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";

contract ModuleDeployer is Script {
    MiniSafeModule public module;

    // MODIFY
    address miniSafeModuleController = 0x4f1e8f02982102473fFB53C5F69E2F5Ee584b8D0;
    // uint8 cctpDeploymentChain = 0x6; // Base
    uint8 cctpDeploymentChain = 0xff; // Linea

    function setUp() public {}

    function run() public {
        vm.broadcast();

        uint8[] memory _cctpSupportedChains = new uint8[](6);
        address[] memory _cctpAddresses = new address[](6);

        _cctpSupportedChains[0] = 0; // Ethereum Sepolia
        _cctpSupportedChains[1] = 1; // Avalanche Fuji
        _cctpSupportedChains[2] = 2; // OP Sepolia
        _cctpSupportedChains[3] = 3; // Arbitrum Sepolia
        _cctpSupportedChains[4] = 6; // Base Sepolia
        _cctpSupportedChains[5] = 7; // Polygon PoS Amoy

        // mainnet
        // _cctpAddresses[0] = 0x1682Ae6375C4E4A97e4B583BC394c861A46D8962;
        // _cctpAddresses[1] = 0x2B4069517957735bE00ceE0fadAE88a26365528f;

        // testnet
        _cctpAddresses[0] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // Ethereum Sepolia
        _cctpAddresses[1] = 0xeb08f243E5d3FCFF26A9E38Ae5520A669f4019d0; // Avalanche Fuji
        _cctpAddresses[2] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // OP Sepolia
        _cctpAddresses[3] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // Arbitrum Sepolia
        _cctpAddresses[4] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // Base Sepolia
        _cctpAddresses[5] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // Polygon PoS Amoy

        module = new MiniSafeModule{salt: 0x0e250538228256d4b12dc895ad58284742a988c92af0a6a8e2933dc3d1348fb9}(
            miniSafeModuleController, cctpDeploymentChain, _cctpSupportedChains, _cctpAddresses
        );

        // console.log("module", module);

        vm.broadcast();
    }
}
