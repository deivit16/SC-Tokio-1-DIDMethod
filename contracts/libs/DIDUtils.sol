
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BytesUtils.sol";

library DidUtils {
    using BytesUtils for bytes;

    // example: did:tok:5Ee76017be7F983a520a778B413758A9DB49cBe9
    /**
    * @dev verify did format
    * @param did did
    */
    function verifyDIDFormat(string memory did) public pure returns (bool){
        bytes memory didData = bytes(did);
        bytes memory prefix = bytes("did:tokio:");

        if (didData.length != 49) {
            return false;
        }

        if (!BytesUtils.equal(BytesUtils.slice(didData, 0, prefix.length), prefix)) {
            return false;
        }

        bytes memory addressBytesData = BytesUtils.slice(didData, prefix.length, didData.length - prefix.length);
        bytes memory addressBytes = BytesUtils.fromHex(string(addressBytesData));
        
        return addressBytes.length == 20;
    }


}