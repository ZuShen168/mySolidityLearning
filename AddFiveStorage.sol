// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    //overrides
    function store(uint256 value) public override {
        super.store(value + 5);
    }
}