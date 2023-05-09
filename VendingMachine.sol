// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract VendingMachine{
    address public owner;
    mapping(address=> uint) public donutBalances;
    constructor(){

        owner = msg.sender;  // address of the account that sent the current transaction , go " deploy & Run transactions" menu " Accounts" option
                               // some gas price will be cut from this account
        donutBalances[address(this)]=100;   // this is the address of current smart contract instance
  
    }

    function getVendingMachineBalance() public view returns(uint ) // view used for not to modify data in function , just to read the state variable
    {
        return donutBalances[address(this)];
    }   
    function restock(uint amount) public {
        require(msg.sender==owner, " Only the ower can restock "); //Only the person who is deploying the contract can restock 
        donutBalances[address(this)]+=amount;
    }
    function purchase(uint amount) public payable   // payable is used when this contract need to receive some Ether .
     {
         require(msg.value>=amount* 2 ether, " You must pay 2 ether per donut");
         require(donutBalances[address(this)]>=amount," Not enough in Stock ");

         donutBalances[address(this)]-= amount;
         donutBalances[msg.sender] += amount; // this is purchaser account  ( here solidity mapping is performed)
         
    }
}