# Minimal Full-Stack Blockchain Freelance Platform

## PART 1 — Starknet (Katana)
1. **Install Katana** (Starknet devnet):
   - [Katana Docs](https://book.starknet.io/chapter_1/katana.html)
2. **Deploy Cairo contract:**
   - Navigate to `katana/` and deploy `FreelanceJobs.cairo` using Starknet CLI:
     ```sh
     starknet-compile FreelanceJobs.cairo --output FreelanceJobs.json --abi FreelanceJobs_abi.json
     katana
     # In another terminal:
     starknet deploy --contract FreelanceJobs.json
     ```

## PART 2 — MoPro (ZK Proof Stub)
1. **Simulate proof generation and verification:**
   - Navigate to `mopro/` and run:
     ```sh
     python mopro_stub.py
     ```
   - Example usage in Python:
     ```python
     from mopro_stub import generate_proof, verify_proof
     proof = generate_proof(1, 'freelancer_addr')
     assert verify_proof(proof)
     ```

## PART 3 — Hardhat (EVM Contract)
1. **Setup Hardhat:**
   - Navigate to `hardhat/` and initialize:
     ```sh
     npm init -y
     npm install --save-dev hardhat
     npx hardhat
     # Choose 'Create an empty hardhat.config.js'
     mkdir contracts
     # Place EscrowContract.sol in contracts/
     npx hardhat compile
     npx hardhat node
     # In another terminal:
     npx hardhat run --network localhost scripts/deploy.js
     ```
2. **Test contract:**
   - Interact with the contract using Hardhat console or scripts, passing the proof from MoPro stub.

---

This project demonstrates a minimal decentralized freelance platform using Starknet (Katana), MoPro (ZK proof stub), and Hardhat (EVM escrow contract). 