# DID Solidity Contract

This project implements a decentralized identifier (DID) system using smart contracts on the Ethereum blockchain. The DID system allows users to create, manage, and verify decentralized identifiers that are self-owned and not dependent on any central registry.

## Contract Structure

The project consists of three main contracts/libraries:

1. **`DIDMethod.sol`**:
    - This is the main contract responsible for generating, storing, and managing decentralized identifiers (DIDs).
    - Each DID is associated with metadata and an Ethereum address as the owner.
    - Users can create DIDs, view them, and retrieve the list of DIDs they own.

2. **`DIDUtils.sol`**:
    - A utility library providing functions to verify DID format, and helper functions for string manipulation.

3. **`BytesUtils.sol`**:
    - A utility library that provides byte-level operations like slicing, comparing, and converting hexadecimal strings to bytes.

## Functionality Overview

### DIDMethod.sol

The **DIDMethod** contract allows users to:

- **Create a DID**:
    - `createDID(string memory _metadata)`: Creates a new DID using the user's Ethereum address and stores metadata.
    
- **Retrieve a DID**:
    - `getDID(string memory did)`: Fetches the DID details and associated metadata.
    
- **List all DIDs**:
    - `getAllDIDs()`: Returns all the DIDs created on the contract.

- **Get DIDs by owner**:
    - `getDIDsByOwner(address owner)`: Returns a list of DIDs owned by a specific Ethereum address.

### DIDUtils.sol

- `verifyDIDFormat(string memory did)`: Verifies that a DID follows the correct format (`did:tokio:<publicKey>`).

### BytesUtils.sol

- **Byte operations**:
    - `slice`: Slices a byte array.
    - `equal`: Compares two byte arrays.
    - `fromHex`: Converts a hexadecimal string to bytes.

## Usage

1. Deploy the `DIDMethod.sol` contract on an Ethereum-compatible network.
2. Interact with the contract to create, verify, and list DIDs using a front-end application or directly via tools like Remix or web3.js.

## Example

To create a DID with metadata, use the following function:

```solidity
function createDID(string memory _metadata) external;

