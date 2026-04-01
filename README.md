# Privacy Mixer (Tornado-lite)

A professional-grade implementation of a non-custodial privacy protocol. This repository demonstrates the core logic of a "Commitment-Nullifier" mixer. Users deposit funds along with a secret hash (Commitment) and later withdraw to a fresh address by providing the secret (Nullifier) without revealing their original identity.

## Core Features
* **Link-Breaking:** Decouples the source and destination addresses via a shared pool.
* **Merkle Tree Integration:** Uses an on-chain Merkle Tree to verify that a commitment exists without revealing which one.
* **Fixed Denominations:** Standardized deposit amounts (e.g., 0.1 ETH, 1 ETH) to prevent amount-based Deanonymization.
* **Anti-Double Spend:** Tracks "Nullifiers" to ensure each deposit is only withdrawn once.

## Logic Flow
1. **Deposit:** User generates a secret and a nullifier, hashes them (Commitment), and sends ETH to the contract.
2. **Wait:** For better privacy, the user waits for more deposits to enter the pool.
3. **Withdraw:** User provides the secret and nullifier. The contract verifies the hash and releases the funds.

## Setup
1. `npm install`
2. Deploy `PrivacyMixer.sol`.
