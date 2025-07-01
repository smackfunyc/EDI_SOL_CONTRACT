# EDI_SOL_CONTRACT

Simple Shipping Smart Contract
Overview
This Solidity smart contract demonstrates a simplified Electronic Data Interchange (EDI) and Fourth Party Logistics (4PL) use case for shipping and logistics. It allows a 4PL provider to:

Create shipment records with EDI-like data (shipment ID, origin, destination).
Update shipment status (Created, InTransit, Delivered).
Query shipment details for transparency.

The contract uses access control to restrict updates to the contract owner (4PL provider) and emits events for real-time tracking, simulating a basic EDI 856 Advance Shipment Notice workflow.
Purpose
Built for portfolio demonstration, this contract showcases blockchain’s potential in logistics for secure, transparent data exchange and supply chain management. It was designed to be implemented in one day, focusing on simplicity and functionality.
Deployment

Environment: Use Remix IDE (https://remix.ethereum.org/) and MetaMask.
Network: Deploy on Sepolia testnet.
Steps:
Compile SimpleShipping.sol in Remix.
Deploy using MetaMask with test ETH.
Interact via Remix to create shipments, update status, and query data.


Verification: Check transactions on Sepolia Etherscan (https://sepolia.etherscan.io/).

Usage

Create Shipment: Input a unique shipmentId, origin, and destination.
Update Status: Change status (0 = Created, 1 = InTransit, 2 = Delivered).
Get Shipment: Retrieve shipment details by shipmentId.

Relevance to EDI/4PL

EDI: Mimics standardized data exchange (e.g., EDI 856) for shipment tracking.
4PL: Acts as a single point of control, managing shipment data and status updates, aligning with 4PL’s role in overseeing the supply chain.

Future Enhancements

Add multi-party access (e.g., for 3PLs or carriers).
Integrate real-time tracking with oracles.
Support more EDI transaction types (e.g., EDI 850 Purchase Order).
