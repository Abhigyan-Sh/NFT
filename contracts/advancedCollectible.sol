// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openZeppelin/contracts/token/ERC721/ERC721.sol";
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract advancedCollectible is VRFConsumerBase, ERC721 {
    uint256 public tokenCounter;
    bytes32 public KeyHash;
    uint256 public fee;
    bytes32 public caller;
    bytes32 public RequestId;
    event RequestRandomness(RequestId);

    enum Breed {
        PUG, SHIBA_INU, ST_BERNARD
    }
    Breed public breed;

    constructor(_vrfCoordinator, _link, _keyHash, _fee) public VRFConsumerBase(_vrfCoordinator, _link) ERC721("Dodgie", "dogie") {
        tokenCounter= 0;
        KeyHash= _keyHash;
        fee= _fee;
    }

    function createMyCollectible() public {
        RequestId= requestRandomness(KeyHash, fee);
        emit RequestRandomness(RequestId);
        caller= msg.sender;
    }
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        breed= Breed(randomness % 3);
        string memory tokenURI= TokenUri(breed);
        // 
        uint256 tokenId= tokenCounter;
        _safeMint(caller, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }
    function TokenUri(breed) public {
        if (breed== PUG) {
            return "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json";
        }
        else if(breed== SHIBA_INU) {
            return "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json";
        }
        else if(breed== ST_BERNARD) {
            return "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json";
        }
    }
}