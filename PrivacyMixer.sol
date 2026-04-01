// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PrivacyMixer is ReentrancyGuard {
    uint256 public constant DENOMINATION = 0.1 ether;
    
    mapping(bytes32 => bool) public commitments;
    mapping(bytes32 => bool) public nullifiers;

    event Deposit(bytes32 indexed commitment, uint32 leafIndex, uint256 timestamp);
    event Withdrawal(address to, bytes32 nullifierHash);

    /**
     * @dev Deposit 0.1 ETH and submit a commitment hash.
     */
    function deposit(bytes32 _commitment) external payable nonReentrant {
        require(msg.value == DENOMINATION, "Must send exactly 0.1 ETH");
        require(!commitments[_commitment], "Commitment already exists");

        commitments[_commitment] = true;
        emit Deposit(_commitment, 0, block.timestamp);
    }

    /**
     * @dev Withdraw to a new address by proving knowledge of the secret.
     * Note: In a production ZK-SNARK version, the proof is verified here.
     * This 'Lite' version uses a direct secret reveal for architectural demo.
     */
    function withdraw(
        address payable _to,
        bytes32 _nullifierHash,
        bytes32 _secret
    ) external nonReentrant {
        require(!nullifiers[_nullifierHash], "Nullifier already spent");
        
        // Verification: hash(secret + nullifierHash) == commitment
        bytes32 reconstructedCommitment = keccak256(abi.encodePacked(_secret, _nullifierHash));
        require(commitments[reconstructedCommitment], "Invalid secret or nullifier");

        nullifiers[_nullifierHash] = true;
        _to.transfer(DENOMINATION);

        emit Withdrawal(_to, _nullifierHash);
    }
}
