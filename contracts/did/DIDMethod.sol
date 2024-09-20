
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libs/DIDUtils.sol";

contract DIDMethod {

    using DidUtils for string;  // Habilita el uso de DidUtils con strings

    // Estructura para almacenar los datos de un DID
    struct DIDData {
        string didId;
        address owner;
        string metadata;
    }

    // Evento para cuando se crea un nuevo DID
    event DIDCreated(string indexed did, address owner, string publicKey, string metadata);

    // Mapeo para asociar un DID con su información
    mapping(string => DIDData) private dids;
    string[] private didList; // Array para almacenar los DIDs

    // Generar una clave pública aleatoria
    function generateDIDMethod() internal view returns (string memory) {
        return string(abi.encodePacked("publickey_", uint256(uint160(msg.sender))));
    }

    // Crear un nuevo DID
    function createDID(string memory _metadata) external {
        // Generar clave pública automáticamente
        string memory publicKey = generateDIDMethod();
        
        // Formato del DID
        string memory did = string(abi.encodePacked("did:tokio:", publicKey));

        // Asegurarse de que el DID no exista aún
        require(bytes(dids[did].didId).length == 0, "DID already exists");

        // Almacenar la información del DID
        dids[did] = DIDData({
            didId: did,          // El DID completo, no solo la publicKey
            owner: msg.sender,   // Asignar correctamente el propietario
            metadata: _metadata
        });
        didList.push(did); // Agregar el DID al array

        emit DIDCreated(did, msg.sender, publicKey, _metadata);
    }

    // Obtener la información de un DID
    function getDID(string memory did) external view returns (string memory publicKey, string memory metadata) {
        require(did.verifyDIDFormat(), "Invalid DID format");  // Verifica el formato del DID

        DIDData storage didData = dids[did];
        require(bytes(didData.didId).length > 0, "DID not found");

        return (didData.didId, didData.metadata);
    }

    //Listado de did creados
    function getAllDIDs() external view returns (string[] memory) {
        return didList;
    }
}