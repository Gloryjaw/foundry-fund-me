//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MockV3Aggregator} from "./mocks/MockV3Aggregator.s.sol";
import {Script} from "forge-std/Script.sol";
contract HelperConfig is Script{
    NetworkConfig public mainNetworkConfig;
    uint8 public constant DECIMAL = 8;
    int256 public constant INITIAL_ANSWER = 2000e8;
    struct NetworkConfig{
        address priceFeedAddress;
    }

    constructor(){
        if(block.chainid == 11155111){
            mainNetworkConfig = getSepoliaConfig();
        
        }
        else{
            mainNetworkConfig = getAnvilConfig();
        }
    }

    function getSepoliaConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeedAddress:  0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getAnvilConfig() public returns(NetworkConfig memory){
        vm.startBroadcast();
        MockV3Aggregator anvilContract = new MockV3Aggregator(DECIMAL, INITIAL_ANSWER);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({priceFeedAddress: address(anvilContract)});
        return anvilConfig;
    }

}

