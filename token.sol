// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract FoxBitEmployee is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string private internalBaseURI = "https://foxbittokens.github.io/foxbittokenemployee/token.json";
    bool public sameMetadataForAll;

    constructor() ERC721("FoxBitEmployee", "FBET") {
        sameMetadataForAll = true;
    }

    function _baseURI() internal view override returns (string memory) {
        return internalBaseURI;
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    /**
     * @dev Burns `tokenId`.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) public onlyOwner  {
        _burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        if (sameMetadataForAll) {
            return internalBaseURI;
        }
        return super.tokenURI(tokenId);
    }

    function changeSameMetadataForAll(bool _sameMetadataForAll) external onlyOwner {
        sameMetadataForAll = _sameMetadataForAll;
    }

    function changeInternalBaseURI(string memory _internalBaseURI) external onlyOwner {
        internalBaseURI = _internalBaseURI;
    }


}
