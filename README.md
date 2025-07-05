ZK Freelance Protocol

A minimal full-stack freelance platform using:

- **Katana** (Starknet devnet) for job lifecycle smart contracts
- **MoPro** (ZK proof simulator) to verify job completion offchain
- **Hardhat** (EVM) for escrow logic and ZK-based fund release

This project demonstrates how zero-knowledge proofs and smart contracts can automate trustless work verification and payment.

---

## Architecture

```text
Freelancer Completes Work
        ↓
[Katana] Cairo Contract → Job marked complete
        ↓
[MoPro] Python ZK Stub → Generates fake ZK proof
        ↓
[Hardhat] Solidity Contract → Verifies proof, releases payment
