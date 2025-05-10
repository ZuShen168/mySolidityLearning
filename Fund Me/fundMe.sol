//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    
    uint256 public minimumUSD = 5e18;

    function fund() public payable {

        require(convert(msg.value) >= minimumUSD, "didn't send enough ETH");
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price)*1e10;
    }

    function convert(uint256 amount) public view returns (uint256){
        uint256 price = getPrice();
        return (price*amount)/1e18;
    }

}