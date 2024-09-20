

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DIDMethod {
    // Estructura para almacenar los datos de un DID
    struct DIDMethod_Data_tokio {
        address owner;
        string publicKey;
        string metadata;
    }

    // Evento para cuando se crea un nuevo DID
    event DIDMethod_Created(address indexed did, address owner, string publicKey, string metadata);
    

    // Evento para cuando se actualiza un DID
    event DIDMethod_Updated(address indexed did, string publicKey, string metadata);
    // Mapeo para asociar un DID con su información
    mapping(address => DIDMethod_Data_tokio) private dids_meth;

    modifier onlyOwner(address did) {
        require(dids_meth[did].owner == msg.sender, "Only the owner can update this DID");
        _;
    }

    
    // Actualizar un DID existente
    function updateDID(string memory newPublicKey, string memory newMetadata) external onlyOwner(msg.sender) {
        require(bytes(newPublicKey).length > 0, "New public key is required");
        require(bytes(newMetadata).length > 0, "New metadata is required");

        DIDMethod_Data_tokio storage didData = dids_meth[msg.sender];
        didData.publicKey = newPublicKey;
        didData.metadata = newMetadata;
        
        emit DIDMethod_Updated(msg.sender, newPublicKey, newMetadata);
    }

    // Crear un nuevo DID
    function createDID(string memory _publicKey, string memory _metadata) external  {
        require(bytes(_publicKey).length > 0, "Public key is required");
        require(bytes(_metadata).length > 0, "Authentication method is required");
        
        require(dids_meth[msg.sender].owner == address(0), "DID already exists");

        // Crear nuevo DID
        dids_meth[msg.sender] = DIDMethod_Data_tokio({
            owner: msg.sender,
            publicKey: _publicKey,
            metadata: _metadata
        });
        
        emit DIDMethod_Created(msg.sender, msg.sender, _publicKey, _metadata);
    }

    // Obtener la información de un DID
    function getDID(address did) external view returns (address owner, string memory publicKey, string memory metadata) {
        DIDMethod_Data_tokio storage didData = dids_meth[did];

        require(didData.owner != address(0), "DID not found");

        return (didData.owner, didData.publicKey, didData.metadata);
    }
}