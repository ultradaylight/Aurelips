// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

/// @custom:security-contact https://github.com/ultradaylight
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20FlashMint} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import  "contracts/ERC20Blocklist.sol";
import  "contracts/ERC20Custodian.sol";
import  "contracts/Mineable.sol";

contract Aurelips is ERC20, ERC20Permit, ERC20FlashMint, Ownable, Mineable, ERC20Custodian, ERC20Blocklist {
    constructor(address recipient, address initialOwner)
        ERC20("Aurelips", "ALIPS")
        ERC20Permit("Aurelips")
        Ownable(initialOwner)
    {
        _mint(recipient, 1000000000 * 10 ** decimals());
    }

    function _isCustodian(address user) internal view override returns (bool) {
        return user == owner();
    }

    function blockUser(address user) public onlyOwner {
        _blockUser(user);
    }

    function unblockUser(address user) public onlyOwner {
        _unblockUser(user);
    }

    
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Custodian, ERC20Blocklist)
    {
        super._update(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value, bool emitEvent)
        internal
        override(ERC20, ERC20Blocklist)
    {
        super._approve(owner, spender, value, emitEvent);
    }
}