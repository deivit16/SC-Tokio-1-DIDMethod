


// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.0;


// define the interface and event of Did in this interface
interface ID {

    event AddKey(string did, bytes pubKey, string[] controller);

    function addKey(string calldata did, bytes calldata newPubKey, string[] calldata pubKeyController,
        bytes calldata singer) external;

}