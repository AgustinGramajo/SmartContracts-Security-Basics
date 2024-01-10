// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ColdWarm {
    using SafeMath for uint8;

    uint8 public value1 = 2**8 -2;
    uint8 public value2;

    function addValue(uint8 _amount) external{
        value1 += _amount;
    }

    function subValue(uint8 _amount) external{
        unchecked{
            value2 -= _amount;
        }
    }

    function subValue2(uint8 _amount) view external{
        value2.sub(_amount);
    }
}