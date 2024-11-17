use starknet::ContractAddress;
use rental_platform::structs::host::ServiceData;

/// For Devs, note:
/// 1.  upload_service uploads a service to the dApp, which will in the future TODO: Start a poll.
///     Automatically returns true with the service_id as a (bool, felt252), else returns the 
///     opposite if for some reason the upload fails. 
/// 
/// 2.  update_service -- called to update info on the updated service.
/// 
/// 3.  is_eligible -- it is automatically set to false (using your implementation anyway) until the 
///     poll has been concluded. If in favour with the host, it is set to true, else it remains false.
///     TODO: For a Guest to book a service, always sheck this value.
/// 
/// 4.  is_open -- returns a boolean value if the service is open for use or not.
/// 
/// 5.  transfer_ownership -- Can only be done by the owner. Transfer the ownership of a service to another.
/// 
/// 6.  delete_service -- deletes a service.
/// 
/// 7.  vote -- up and down votes of a house @params service_id of the house/service, guest's contract
///     contract address, vote_variable read from the Guest's storage, and direction... true for up, false for
///     down.
/// 
/// 8.  write_log -- records a log of service ids mapped with the guest address (The guest that used the service)
///     This way voting up and down, rating and reviews of a services can only be done by guests who have used them.
#[starknet::interface]
pub trait IHostHandler<TContractState> {
    fn upload_service(ref self: TContractState, host: ContractAddress, name: felt252) -> (bool, felt252); // done
    fn update_service(ref self: TContractState, service_id: felt252, data: ServiceData);
    fn is_eligible(self: @TContractState, host: ContractAddress, service_id: felt252) -> bool;
    fn is_open(self: @TContractState, host: ContractAddress) -> bool;
    fn transfer_ownership(ref self: TContractState, new_host: ContractAddress);
    fn delete_service(self: @TContractState, service_id: felt252) -> bool;
    fn vote(ref self: TContractState, service_id: felt252, guest: ContractAddress, vote_variable: u8, direction: bool);
    fn write_log(ref self: TContractState, service_id: felt252, guest: ContractAddress);
}