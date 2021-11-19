// SPDX-License-Identifier: MIT

pragma solidity 0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import './../token/BEP20.sol';
import '@openzeppelin/contracts/utils/Context.sol';

abstract contract BPContract {
    function protect(
        address sender,
        address receiver,
        uint256 amount
    ) external virtual;
}

contract DorToken is Ownable, BEP20 {

    BPContract public BP;
    bool public bpEnabled;
    bool public BPDisabledForever = false;

    constructor(address wallet, uint256 totalSupply) Ownable() BEP20("Dor Token","DOR") {
        _mint(wallet, totalSupply);
        transferOwnership(wallet);
    }

    /**
     * @dev Set Bot Protection addreess
     */
    function setBPAddrss(address _bp) external onlyOwner {
        require(address(BP) == address(0), "Can only be initialized once");
        BP = BPContract(_bp);
    }

    /**
     * @dev Enable/Disable Bot Protection
     */
    function setBpEnabled(bool _enabled) external onlyOwner {
        bpEnabled = _enabled;
    }

    /**
     * @dev Disable Bot Protection forever
     */
    function setBotProtectionDisableForever() external onlyOwner {
        require(BPDisabledForever == false);
        BPDisabledForever = true;
    }
    
    /**
     * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
     * the total supply.
     *
     * Requirements
     *
     * - `msg.sender` must be the token owner
     */
    function mint(uint256 amount) public onlyOwner returns (bool) {
        uint256 totalSupply = totalSupply();
        require(
            totalSupply + amount < 1000000000 ether,
            'DOR::mint: exceeding the permitted limits');
        _mint(_msgSender(), amount);
        return true;
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {BEP20-_burn}.
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {BEP20-_burn} and {BEP20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount) public {
        uint256 currentAllowance = allowance(account, _msgSender());
        require(currentAllowance >= amount, "BEP20: burn amount exceeds allowance");
        unchecked {
            _approve(account, _msgSender(), currentAllowance - amount);
        }
        _burn(account, amount);
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address from, address to, uint256 amount) internal override {
        if (bpEnabled && !BPDisabledForever){
                BP.protect(from, to, amount);
        }
        super._transfer(from, to, amount);
    }
}