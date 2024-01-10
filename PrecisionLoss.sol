// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract PrecisionLoss {
    uint public balance = 550;
    uint public reward;
    uint public factor = 10000;

    // Percentage: 3%
    // reward = .165
    // reward = (550 * 3) / 100 * 100 = 1650 / (100 * 100) = 16.5 * factor(1000) = 165

    // Percentage .03%
    // reward = 550 * 3 / (100 * 1000) = 1650 / (100 * 1000) = .0165 * factor(10000) = 165
    function getReward(uint _percentage) external {
        reward =  (balance * _percentage * factor) / (100 * 1000);
    }

    // reward = 550 / 100 * 3 = 5 * 3 = 15
    function getWrongReward(uint _percentage) external{
        reward = balance / 100 * _percentage;
    }
}