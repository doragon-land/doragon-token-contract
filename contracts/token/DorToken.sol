// SPDX-License-Identifier: MIT

pragma solidity 0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import './../token/BEP20.sol';

contract DorToken is Ownable, BEP20 {    
    constructor(address wallet, uint256 totalSupply) Ownable() BEP20("Dor Token","DOR") {
        _mint(wallet, totalSupply);
        transferOwnership(wallet);
    }
}