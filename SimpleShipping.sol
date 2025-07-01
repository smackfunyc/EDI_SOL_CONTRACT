
// SPDX-License-Identifier: MIT
// License identifier: MIT ensures open-source compatibility and clarity on usage rights.

pragma solidity ^0.8.0;
// Specifies Solidity version >=0.8.0 for compatibility and modern features like safe math.

contract SimpleShipping {
    // Contract for managing shipment data in an EDI/4PL logistics context, simulating tracking and transparency.

    // State variable to store the contract owner's address (the 4PL provider).
    address public owner;

    // Enum defining possible shipment statuses, simplifying state tracking.
    enum Status { Created, InTransit, Delivered }
    // Created (0): Shipment initialized; InTransit (1): Shipment en route; Delivered (2): Shipment completed.

    // Struct to store shipment details, mimicking EDI data (e.g., EDI 856 Advance Shipment Notice).
    struct Shipment {
        string shipmentId; // Unique identifier for the shipment (e.g., "EDI123").
        string origin;    // Starting location (e.g., "New York").
        string destination; // Destination location (e.g., "Los Angeles").
        Status status;    // Current status of the shipment (from Status enum).
    }

    // Mapping to store shipments, associating each shipmentId with its Shipment struct.
    mapping(string => Shipment) public shipments;
    // Public visibility allows anyone to query shipment data, ensuring transparency.

    // Event emitted when a shipment's status is updated, enabling real-time tracking.
    event StatusUpdated(string shipmentId, Status status);
    // Useful for frontends or off-chain systems to monitor changes.

    // Constructor to initialize the contract, setting the deployer as the owner.
    constructor() {
        owner = msg.sender; // msg.sender is the address deploying the contract.
    }

    // Modifier to restrict certain functions to the owner (4PL provider).
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _; // Continues execution of the modified function if the check passes.
    }

    // Function to create a new shipment, restricted to the owner.
    function createShipment(
        string memory _shipmentId, // Unique ID for the shipment.
        string memory _origin,    // Shipment's starting point.
        string memory _destination // Shipment's endpoint.
    ) public onlyOwner {
        // Ensure the shipment ID doesn't already exist to prevent overwrites.
        require(bytes(shipments[_shipmentId].shipmentId).length == 0, "Shipment ID already exists");
        // Store new shipment in the mapping with initial status 'Created'.
        shipments[_shipmentId] = Shipment(_shipmentId, _origin, _destination, Status.Created);
        // Emit event to log the creation.
        emit StatusUpdated(_shipmentId, Status.Created);
    }

    // Function to update a shipment's status, restricted to the owner.
    function updateStatus(
        string memory _shipmentId, // ID of the shipment to update.
        Status _status           // New status (Created, InTransit, or Delivered).
    ) public onlyOwner {
        // Ensure the shipment exists before updating.
        require(bytes(shipments[_shipmentId].shipmentId).length != 0, "Shipment does not exist");
        // Update the shipment's status in the mapping.
        shipments[_shipmentId].status = _status;
        // Emit event to log the status change.
        emit StatusUpdated(_shipmentId, _status);
    }

    // Function to query shipment details, accessible to anyone (view function, no gas cost off-chain).
    function getShipment(
        string memory _shipmentId // ID of the shipment to query.
    ) public view returns (
        string memory shipmentId, // Returns shipment ID.
        string memory origin,    // Returns origin.
        string memory destination, // Returns destination.
        Status status           // Returns current status.
    ) {
        // Ensure the shipment exists before returning data.
        require(bytes(shipments[_shipmentId].shipmentId).length != 0, "Shipment does not exist");
        // Retrieve the shipment from the mapping.
        Shipment memory shipment = shipments[_shipmentId];
        // Return all shipment details.
        return (shipment.shipmentId, shipment.origin, shipment.destination, shipment.status);
    }
}
