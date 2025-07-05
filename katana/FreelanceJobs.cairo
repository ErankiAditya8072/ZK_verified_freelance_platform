// SPDX-License-Identifier: MIT
%lang starknet

@contract_interface
trait IFreelanceJobs {
    fn create_job{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(job_id: felt, budget: felt, client: felt);
    fn accept_job{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(job_id: felt, freelancer: felt);
    fn complete_job{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(job_id: felt, freelancer: felt);
}

struct Job {
    job_id: felt,
    budget: felt,
    client: felt,
    freelancer: felt,
    completed: felt,
}

@storage_var
fn jobs(job_id: felt) -> Job {}

@event
fn JobCompleted(job_id: felt, freelancer: felt) {}

@external
fn create_job(job_id: felt, budget: felt, client: felt) {
    let job = Job { job_id, budget, client, freelancer: 0, completed: 0 };
    jobs::write(job_id, job);
    return ();
}

@external
fn accept_job(job_id: felt, freelancer: felt) {
    let mut job = jobs::read(job_id);
    job.freelancer = freelancer;
    jobs::write(job_id, job);
    return ();
}

@external
fn complete_job(job_id: felt, freelancer: felt) {
    let mut job = jobs::read(job_id);
    assert(job.freelancer == freelancer, 'Not assigned freelancer');
    job.completed = 1;
    jobs::write(job_id, job);
    JobCompleted(job_id, freelancer);
    return ();
} 