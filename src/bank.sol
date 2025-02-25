// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.26;
contract Bank{
    mapping(address => uint256) private balances; //map of addresses to their current balance
    
    function Deposit(uint256 value)external payable{
        require(msg.value == value,"Not Enough amount sent");
        require(msg.value > 0,"Value can not be zero");
        balances[msg.sender]+=value;
    }
    
    function Withdrawl(uint256 value)external payable {
        require(value>0,"cannot withdraw zero");
        require(balances[msg.sender]>=value,"NOT ENOUGH BALANCE");
        
        balances[msg.sender]-=value;

        (bool sent, ) = msg.sender.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
      
    }

    function balance_view(address user) external view returns (uint256) {
        return balances[user];
    }
     // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

}

