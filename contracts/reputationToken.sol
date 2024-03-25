// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract Reputation is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    
    using SafeMath for uint256;
    

    //Mapping to store reputation data by token ID
    mapping (uint256=>Reputation) public reputationData;

    //Mapping to store address of token owner by token ID
    mapping (uint256=>address) public tokenIDToOwner;

    constructor(uint256 initialTokenSupply, address initialOwner)
        ERC20("Reputation", "REP")
        Ownable(initialOwner)
    {_mint(initialOwner, initialTokenSupply);}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function increaseAllowance(address spender, uint256 tokenValue) public onlyOwner{
        increaseAllowance(spender, tokenValue);
    }

    function decreaseAllowance(address spender, uint256 tokenValue) public onlyOwner{
        decreaseAllowance(spender, tokenValue);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}

/*
for all addresses in room
_mint(address, 1);


*/
