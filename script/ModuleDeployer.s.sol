// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MiniSafeModule} from "../src/MiniSafeModule.sol";

contract ModuleDeployer is Script {
    MiniSafeModule public module;

    address sender = 0x55aFE7FDbB76B478d83e2151B468f7C74442B46C;
    address miniSafeModuleController = 0x4f1e8f02982102473fFB53C5F69E2F5Ee584b8D0;

    uint8 cctpDeploymentChain = 0x6; // Base

    function setUp() public {}

    function run() public {
        vm.broadcast();

        uint8[] memory _cctpSupportedChains = new uint8[](2);
        address[] memory _cctpAddresses = new address[](2);

        _cctpSupportedChains[0] = 0x6; // Base
        _cctpSupportedChains[1] = 0x2; // OP

        // mainnet
        // _cctpAddresses[0] = 0x1682Ae6375C4E4A97e4B583BC394c861A46D8962;
        // _cctpAddresses[1] = 0x2B4069517957735bE00ceE0fadAE88a26365528f;

        // testnet
        _cctpAddresses[0] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // Base
        _cctpAddresses[1] = 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5; // OP

        module = new MiniSafeModule{salt: 0x0e250538228256d4b12dc895ad58284742a988c92af0a6a8e2933dc3d1348fb9}(
            miniSafeModuleController, cctpDeploymentChain, _cctpSupportedChains, _cctpAddresses
        );
        vm.broadcast();
    }
}
