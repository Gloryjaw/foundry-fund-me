//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./Helperconfig.s.sol";

contract DeployFundMe is Script{
    function run() external returns(FundMe){
        HelperConfig helperConfig = new HelperConfig();
        address priceFeedAddress = helperConfig.mainNetworkConfig();
        vm.startBroadcast();
        FundMe fundMe = new FundMe( priceFeedAddress);
        vm.stopBroadcast();
        return fundMe;
    }
}