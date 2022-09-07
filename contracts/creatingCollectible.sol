// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openZeppelin/contracts/token/ERC721/ERC721.sol";

contract creatingCollectible is ERC721 {
    uint256 public tokenCounter;
    constructor() public ERC721("Dodgie", "dodge") {
        tokenCounter= 0;
    }
    function creating_collectible(string memory tokenURI) public view returns(uint256) {
        uint256 newItemId= tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenCounter+= 1;
    }
}