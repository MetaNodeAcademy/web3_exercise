// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 
 
contract CA_Nft is ERC721URIStorage, Ownable {
    // 使用原生 uint 计数器
    uint256 private _tokenIdCounter;

    constructor() ERC721("CA_Nft", "CAT") Ownable(msg.sender) {}

    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        unchecked { _tokenIdCounter++; }        // 原生自增，节省 gas
        uint256 tokenId = _tokenIdCounter;      // 与旧 Counters 行为一致：从 1 开始
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId; 
    }
}


