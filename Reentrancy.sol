// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Victim is ReentrancyGuard{
    
    mapping(address => uint) public balances;

    constructor() payable {}

    function deposit() external payable{
        balances[msg.sender] += msg.value;
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function withdraw() nonReentrant external payable  {
        // Check
        require(balances[msg.sender] > 0, "not enough balance!");
        // Effect
        balances[msg.sender] = 0;
        // Interact Pattern
        payable(msg.sender).transfer(balances[msg.sender]);
    }
}

contract Attacker {
    address public victim;
    bool flag;
    constructor(address _victim) payable {
        victim = _victim;
    }

    function deposit() external payable returns(bool status) {
        (status, ) = victim.call{value: 1 ether}(abi.encodeWithSignature("deposit()"));
    }

    function attack() external returns(bool status){
        (status, ) = victim.call(abi.encodeWithSignature("withdraw()"));
    }

    receive() payable external {
        bool status;

        if (!flag)
            (status, ) = victim.call(abi.encodeWithSignature("withdraw()"));

        flag = true;
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }
}