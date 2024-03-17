//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
contract FundMeTest is Test{
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant INITIAL_BALANCE = 10 ether;

    function setUp() external{
        DeployFundMe deployFundme = new DeployFundMe();
        fundMe = deployFundme.run();
        vm.deal(USER, INITIAL_BALANCE);
    }

    function testMinUSD() public{
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
    function testOwner() public{
        assertEq(fundMe.getOwner(), msg.sender);
    }
    function testVersion() public{
        assertEq(fundMe.getVersion(), 4);
    }
    function testFundLessValue() public{
        vm.expectRevert();
        fundMe.fund();
    }
    function testFundUpdatesFundDataStructures() public{
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getFunderDonatedValue(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
    function testFunderArrayAddsFunder() public{
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunderAddress(0);
        assertEq(funder, USER);
    }

    modifier funded(){
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }
    function testOnlyOwnerCanWithdraw() public funded{
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithSingleFunder() public funded{
        //Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        //Act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        //assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;

        assertEq(endingContractBalance, 0);
        assertEq(startingOwnerBalance+startingContractBalance, endingOwnerBalance);
    }

   function testWithdrawFromMultipleFunders() public funded{
    //Arrange
    
        uint160 numberofFunders = 10;
        uint160 funderStartingIndex = 1;

        for(uint160 funderIndex = funderStartingIndex; funderIndex < numberofFunders; funderIndex++){
            hoax(address(funderIndex), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

    //Act
      
 
    
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();


    //assert
    assert(startingOwnerBalance+startingContractBalance==fundMe.getOwner().balance);
    assert(address(fundMe).balance == 0);


}
    function testWithdrawFromMultipleFundersCheap() public funded{
    //Arrange
    
        uint160 numberofFunders = 10;
        uint160 funderStartingIndex = 1;

        for(uint160 funderIndex = funderStartingIndex; funderIndex < numberofFunders; funderIndex++){
            hoax(address(funderIndex), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

    //Act
      
 
    
    vm.startPrank(fundMe.getOwner());
    fundMe.CheaperWithdraw();
    vm.stopPrank();


    //assert
    assert(startingOwnerBalance+startingContractBalance==fundMe.getOwner().balance);
    assert(address(fundMe).balance == 0);


    }

}


