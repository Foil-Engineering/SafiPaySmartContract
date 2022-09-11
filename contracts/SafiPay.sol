// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

 interface USDTInterface{
            function transfer(address _to, uint _value) external;
            function balanceOf(address who) external returns (uint) ;
    }

contract SafiPay{

    address public owner;

    event NewPayment(uint amount, address payeer, string transId);
    

    USDTInterface usdt = USDTInterface(address(this));

constructor() {
        owner = msg.sender;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function setUSDTContractAddress(address _usdtAddress) external onlyOwner{
        usdt = USDTInterface(_usdtAddress);
    }
    function pay(uint amount, string memory transId) external{
        usdt.transfer(address(this), amount);
        emit NewPayment(amount,msg.sender, transId);

    }

    function withdrawUsdt(uint amount, address to) onlyOwner external{
        usdt.transfer(to, amount);
    }

    function usdtBalance() external returns(uint){
        return usdt.balanceOf(address(this));
    }

}

