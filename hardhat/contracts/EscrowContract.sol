// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EscrowContract {
    struct Job {
        address client;
        address freelancer;
        uint256 amount;
        bool funded;
        bool released;
    }

    mapping(uint256 => Job) public jobs;
    address public owner;

    event JobCreated(uint256 indexed jobId, address client, uint256 amount);
    event PaymentReleased(uint256 indexed jobId, address freelancer, uint256 amount);

    constructor() { owner = msg.sender; }

    function createJob(uint256 jobId) external payable {
        require(jobs[jobId].client == address(0), "Job exists");
        jobs[jobId] = Job(msg.sender, address(0), msg.value, true, false);
        emit JobCreated(jobId, msg.sender, msg.value);
    }

    function setFreelancer(uint256 jobId, address freelancer) external {
        require(msg.sender == jobs[jobId].client, "Not client");
        jobs[jobId].freelancer = freelancer;
    }

    function releasePayment(uint256 jobId, string memory proof) external {
        Job storage job = jobs[jobId];
        require(job.funded && !job.released, "Not funded or already released");
        require(_verifyProof(proof), "Invalid proof");
        job.released = true;
        payable(job.freelancer).transfer(job.amount);
        emit PaymentReleased(jobId, job.freelancer, job.amount);
    }

    function _verifyProof(string memory proof) internal pure returns (bool) {
        bytes memory b = bytes(proof);
        return b.length > 10 && b[0] == 'p'; // Mocked check
    }
} 