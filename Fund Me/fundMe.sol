//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe{
    
    using PriceConverter for uint256;
    uint256 public constant minimumUSD = 5e18;
    address[] private funders; 
    mapping(address => uint256) public addressToAmountFunded;
    address private immutable i_owner;

    modifier onlyOwner() {
        // require(msg.sender == i_owner);
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.convert() >= minimumUSD, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public {
        for (uint i=0; i<funders.length; i++){
            addressToAmountFunded[funders[i]] = 0;
        }
        funders = new address[](0);

        (bool success,) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

}